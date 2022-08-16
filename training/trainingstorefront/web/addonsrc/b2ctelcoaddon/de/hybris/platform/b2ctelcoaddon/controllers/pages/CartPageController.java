/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorfacades.flow.impl.SessionOverrideCheckoutFlowFacade;
import de.hybris.platform.acceleratorservices.controllers.page.PageType;
import de.hybris.platform.acceleratorservices.enums.CheckoutFlowEnum;
import de.hybris.platform.acceleratorservices.enums.CheckoutPciOptionEnum;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.ResourceBreadcrumbBuilder;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractCartPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.forms.UpdateQuantityForm;
import de.hybris.platform.b2ctelcoaddon.forms.DeleteBundleForm;
import de.hybris.platform.b2ctelcofacades.data.CartActionInput;
import de.hybris.platform.b2ctelcofacades.data.TmaCartValidationData;
import de.hybris.platform.b2ctelcofacades.order.TmaCartFacade;
import de.hybris.platform.b2ctelcofacades.order.TmaOrderEntryFacade;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.CartModificationData;
import de.hybris.platform.commercefacades.order.data.OrderEntryData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;
import de.hybris.platform.jalo.JaloObjectNoLongerValidException;

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Controller of the cart page and related cart operations, like remove or update cart.
 */
@Controller
@Scope("tenant")
@RequestMapping(value = "/cart")
public class CartPageController extends AbstractCartPageController
{

	private static final Logger LOGGER = Logger.getLogger(CartPageController.class);
	private static final String INVALID_PRE_CONFIG_CALL = "invalidPreConfigCall";
	private static final String CART_PAGE = "cartPage";
	public static final String SHOW_CHECKOUT_FLOWS_CONFIG_KEY = "storefront.show.checkout.flows";
	public static final String CART_CMS_PAGE_LABEL = "cart";
	public static final String CART_CHECKOUT_ERROR = "cart.checkout.error";
	public static final String PAGE_TYPE_ATTRIBUTE = "pageType";
	public static final String CART_BREADCRUMB_KEY = "breadcrumb.cart";
	public static final String REDIRECT_TO_CART_URL = REDIRECT_PREFIX + "/cart";
	public static final String TYPE_MISMATCH_ERROR_CODE = "typeMismatch";
	public static final String SUBSCRIPTION_PRODUCT_ERROR_REGEX = "Subscription product.+must have a new quantity of 0 or 1.+";
	public static final String SUBSCRIPTION_PRODUCT_BASKET_ERROR = "basket.error.subscriptionProduct.quantity.invalid";
	public static final String BASKET_REMOVE_MESSAGE = "basket.page.message.remove";
	public static final String BASKET_UPDATE_MESSAGE = "basket.page.message.update";
	public static final String CART_DATA = "cartData";
	public static final String HAS_PICK_UP_CART_ENTRIES = "hasPickUpCartEntries";
	private final String[] DISALLOWED_FIELDS = new String[] {};

	private ResourceBreadcrumbBuilder resourceBreadcrumbBuilder;

	@Resource(name = "tmaOrderEntryFacade")
	private TmaOrderEntryFacade orderEntryFacade;

	/**
	 * Retrieves the configured value for the {@link CartPageController#SHOW_CHECKOUT_FLOWS_CONFIG_KEY}.
	 *
	 * @return configured value for the {@link CartPageController#SHOW_CHECKOUT_FLOWS_CONFIG_KEY} or false if none is
	 * provided
	 */
	@ModelAttribute("showCheckoutStrategies")
	public boolean isCheckoutStrategyVisible()
	{
		return getSiteConfigService().getBoolean(SHOW_CHECKOUT_FLOWS_CONFIG_KEY, false);
	}

	/**
	 * Displays the cart page.
	 *
	 * @param model
	 * 		page model to be populated with information
	 * @return name of the view to be displayed
	 * @throws CMSItemNotFoundException
	 * 		if the CmsPage cannot be found, while populating the model with meta data or title information
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String showCart(final Model model) throws CMSItemNotFoundException
	{
		if (model.asMap().containsKey(INVALID_PRE_CONFIG_CALL))
		{
			GlobalMessages.addErrorMessage(model, model.asMap().get(INVALID_PRE_CONFIG_CALL).toString());
		}
		prepareDataForPage(model);
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, resourceBreadcrumbBuilder.getBreadcrumbs(CART_BREADCRUMB_KEY));
		model.addAttribute(PAGE_TYPE_ATTRIBUTE, PageType.CART.name());
		storeCmsPageInModel(model, getCmsPageService().getPageForId(CART_PAGE));

		return getViewForPage(model);
	}

	/**
	 * Handle the '/cart/checkout' request url. This method checks to see if the cart is valid before allowing the
	 * checkout to begin. Note that this method does not require the user to be authenticated and therefore allows us to
	 * validate that the cart is valid without first forcing the user to login. The cart will be checked again once the
	 * user has logged in.
	 *
	 * @param model
	 * 		the spring Model object. not used here, but included in the signature to allow overriding in subclasses.
	 * @return The page to redirect to
	 */
	@RequestMapping(value = "/checkout", method = RequestMethod.GET)
	@RequireHardLogIn
	public String cartCheck(final Model model, final RedirectAttributes redirectModel)
	{
		SessionOverrideCheckoutFlowFacade.resetSessionOverrides();

		if (!getCartFacade().hasEntries())
		{
			LOGGER.debug("Missing or empty cart");

			// No session cart or empty session cart. Bounce back to the cart page.
			return REDIRECT_PREFIX + "/cart";
		}


		if (validateCart(redirectModel))
		{
			GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER, CART_CHECKOUT_ERROR, null);
			return REDIRECT_PREFIX + "/cart";
		}

		// Redirect to the start of the checkout flow to begin the checkout process
		// We just redirect to the generic '/checkout' page which will actually select the checkout flow
		// to use. The customer is not necessarily logged in on this request, but will be forced to login
		// when they arrive on the '/checkout' page.
		return REDIRECT_PREFIX + "/checkout";
	}

	/**
	 * @param model
	 * 		the Spring Model object. Included to allow subclass overriding.
	 * @param redirectModel
	 * 		the RedirectAttributes object. Included to allow subclass overriding.
	 */
	// This controller method is used to allow the site to force the visitor through a specified checkout flow.
	// If you only have a static configured checkout flow then you can remove this method.
	@RequestMapping(value = "/checkout/select-flow", method = RequestMethod.GET)
	@RequireHardLogIn
	public String initCheck(final Model model, final RedirectAttributes redirectModel,
			@RequestParam(value = "flow", required = false) final CheckoutFlowEnum checkoutFlow,
			@RequestParam(value = "pci", required = false) final CheckoutPciOptionEnum checkoutPci)
	{
		SessionOverrideCheckoutFlowFacade.resetSessionOverrides();

		if (!getCartFacade().hasEntries())
		{
			LOGGER.debug("Missing or empty cart");

			// No session cart or empty session cart. Bounce back to the cart page.
			return REDIRECT_PREFIX + "/cart";
		}

		// Override the Checkout Flow setting in the session
		if (checkoutFlow != null && StringUtils.isNotBlank(checkoutFlow.getCode()))
		{
			SessionOverrideCheckoutFlowFacade.setSessionOverrideCheckoutFlow(checkoutFlow);
		}

		// Override the Checkout PCI setting in the session
		if (checkoutPci != null && StringUtils.isNotBlank(checkoutPci.getCode()))
		{
			SessionOverrideCheckoutFlowFacade.setSessionOverrideSubscriptionPciOption(checkoutPci);
		}

		// Redirect to the start of the checkout flow to begin the checkout process
		// We just redirect to the generic '/checkout' page which will actually select the checkout flow
		// to use. The customer is not necessarily logged in on this request, but will be forced to login
		// when they arrive on the '/checkout' page.
		return REDIRECT_PREFIX + "/checkout";
	}

	/**
	 * Deletes all cart entries corresponding to the bundle with the number given from the current cart.
	 *
	 * @param form
	 * 		bundle delete form, indicating the bundle No to be deleted
	 * @param model
	 * 		page model to be populated with information
	 * @param bindingResult
	 * 		request binding result to retrieve validation errors from
	 * @param redirectModel
	 * 		page model used for redirection to be populated with information
	 * @return the url to which the request will be redirected
	 * @throws CMSItemNotFoundException
	 * 		if the CmsPage cannot be found, while populating the model with meta data or title information
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteCartBundle(@Valid final DeleteBundleForm form, final Model model, final BindingResult bindingResult,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		if (bindingResult.hasErrors())
		{
			for (final ObjectError error : bindingResult.getAllErrors())
			{
				GlobalMessages.addErrorMessage(model, error.getDefaultMessage());
			}
		}

		String alertMessageCode;
		try
		{
			final CartData cartData = getCartFacade().getSessionCart();
			final CartActionInput cartActionInput = new CartActionInput();
			cartActionInput.setUserGuid(cartData.getUser().getUid());
			cartActionInput.setCartId(cartData.getCode());
			cartActionInput.setEntryNumber(form.getEntryNumber());
			cartActionInput.setQuantity(0L);

			getCartFacade().processCartAction(Collections.singletonList(cartActionInput));
			alertMessageCode = "basket.page.bundle.message.remove";
		}
		catch (final CommerceCartModificationException e)
		{
			LOGGER.warn("Could not delete entry group with number " + form.getEntryNumber(), e);
			alertMessageCode = "basket.page.bundle.message.remove.error";
		}
		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER, alertMessageCode);
		prepareDataForPage(model);
		return REDIRECT_TO_CART_URL;
	}

	/**
	 * Update the quantity of the product for the entry with the number given.
	 *
	 * @param entryNumber
	 * 		entry number of the cart entry to be updated
	 * @param model
	 * 		page model to be populated with information
	 * @param form
	 * 		update quantity form specifying the new quantity of the product from the entry with the number given
	 * @param bindingResult
	 * 		request binding result to retrieve validation errors from
	 * @param request
	 * 		http request to retrieve the url from
	 * @param redirectModel
	 * 		redirect model to be populated with information
	 * @return the url to the result page
	 * @throws CMSItemNotFoundException
	 * 		if the CmsPage cannot be found, while populating the model with meta data or title information
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateCartQuantities(@RequestParam("entryNumber") final long entryNumber, final Model model,
			@Valid final UpdateQuantityForm form, final BindingResult bindingResult, final HttpServletRequest request,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		if (bindingResult.hasErrors())
		{
			populatePageModelWithErrors(model, bindingResult);
		}
		else if (getCartFacade().hasEntries())
		{
			try
			{
				final long newQuantity = form.getQuantity().longValue();
				final CartModificationData cartModification = getCartFacade().updateCartEntry(entryNumber, newQuantity);
				String alertMessageCode;
				if (cartModification.getQuantity() == newQuantity)
				{
					// Success in either removal or updating the quantity
					alertMessageCode = cartModification.getQuantity() == 0 ? BASKET_REMOVE_MESSAGE : BASKET_UPDATE_MESSAGE;
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER, alertMessageCode);
				}
				else
				{
					handleUpdateQuantityFailure(newQuantity, request, redirectModel, cartModification);
				}
			}
			catch (final JaloObjectNoLongerValidException | CommerceCartModificationException ex)
			{
				LOGGER.warn("Could not update quantity of product with entry number: " + entryNumber + ".", ex);
			}
			catch (final IllegalArgumentException e)
			{
				LOGGER.info(e);
				if (e.getMessage().matches(SUBSCRIPTION_PRODUCT_ERROR_REGEX))
				{
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
							SUBSCRIPTION_PRODUCT_BASKET_ERROR, new Object[]
									{ form.getQuantity() });
				}
			}
		}
		prepareDataForPage(model);
		return REDIRECT_TO_CART_URL;
	}

	/**
	 * Handles the case when the update quantity call failed by adding corresponding error messages on the redirectModel.
	 *
	 * @param newQuantity
	 * 		the new quantity, as set by the customer
	 * @param request
	 * 		http request to retrieve the url from
	 * @param redirectModel
	 * 		redirect model to be populated with information
	 * @param cartModification
	 * 		resulting cart modification after applying the quantity update
	 */
	protected void handleUpdateQuantityFailure(final long newQuantity, final HttpServletRequest request,
			final RedirectAttributes redirectModel, final CartModificationData cartModification)
	{
		final ProductData modifiedProduct = cartModification.getEntry().getProduct();
		final StringBuffer productUrl = request.getRequestURL().append(modifiedProduct.getUrl());
		final long updatedQuantity = cartModification.getQuantity();
		if (updatedQuantity > 0)
		{
			// Not enough stock available
			GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
					"basket.page.message.update.reducedNumberOfItemsAdded.lowStock", new Object[]
							{ modifiedProduct.getName(), updatedQuantity, newQuantity, productUrl });
			return;
		}
		// No more items available
		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
				"basket.page.message.update.reducedNumberOfItemsAdded.noStock", new Object[]
						{ modifiedProduct.getName(), productUrl });
	}

	/**
	 * Populates the page model with the errors found on the binding result given.
	 *
	 * @param model
	 * 		page model to be populated with errors
	 * @param bindingResult
	 * 		binding result to retrieve the errors from
	 */
	protected void populatePageModelWithErrors(final Model model, final BindingResult bindingResult)
	{
		for (final ObjectError error : bindingResult.getAllErrors())
		{
			final String errorMessageCode = TYPE_MISMATCH_ERROR_CODE.equals(error.getCode()) ? "basket.error.quantity.invalid"
					: error.getDefaultMessage();
			GlobalMessages.addErrorMessage(model, errorMessageCode);
		}
	}

	@Override
	protected void createProductList(final Model model) throws CMSItemNotFoundException
	{
		final CartData cartData = getCartFacade().getSessionCartWithEntryOrdering(false);
		createProductEntryList(model, cartData);
		storeCmsPageInModel(model, getContentPageForLabelOrId(CART_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(CART_CMS_PAGE_LABEL));

		final Map<OrderEntryData, List<OrderEntryData>> groupedCartEntries = createGroupedEntryMap(cartData);

		model.addAttribute("groupedCartEntries", groupedCartEntries);
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, getResourceBreadcrumbBuilder().getBreadcrumbs(CART_BREADCRUMB_KEY));
		model.addAttribute(PAGE_TYPE_ATTRIBUTE, PageType.CART.name());
	}

	@Override
	protected void createProductEntryList(final Model model, final CartData cartData)
	{
		boolean hasPickUpCartEntries = false;
		if (CollectionUtils.isEmpty(cartData.getEntries()))
		{
			model.addAttribute(CART_DATA, cartData);
			model.addAttribute(HAS_PICK_UP_CART_ENTRIES, hasPickUpCartEntries);
			return;
		}

		for (final OrderEntryData entry : cartData.getEntries())
		{
			if (CollectionUtils.isEmpty(entry.getEntries()))
			{
				hasPickUpCartEntries = hasPickUpCartEntries(entry) || hasPickUpCartEntries;
				setUpdateQuantityForm(model, entry);
			}
			else
			{
				final List<OrderEntryData> allSpoEntries = getOrderEntryFacade().getAllSpoEntries(entry);
				for (OrderEntryData spoEntry : allSpoEntries)
				{
					hasPickUpCartEntries = hasPickUpCartEntries(spoEntry) || hasPickUpCartEntries;
					setUpdateQuantityForm(model, spoEntry);
				}
			}
		}

		model.addAttribute(CART_DATA, cartData);
		model.addAttribute(HAS_PICK_UP_CART_ENTRIES, hasPickUpCartEntries);
	}

	private Map<OrderEntryData, List<OrderEntryData>> createGroupedEntryMap(final CartData cartData)
	{
		if (cartData == null)
		{
			return null;
		}

		final Map<OrderEntryData, List<OrderEntryData>> groupedCartEntries = new LinkedHashMap<>();

		if (CollectionUtils.isEmpty(cartData.getEntries()))
		{
			return groupedCartEntries;
		}

		cartData.getEntries().forEach((OrderEntryData entry) -> {
			if (CollectionUtils.isEmpty(entry.getEntries()))
			{
				groupedCartEntries.put(entry, Collections.emptyList());
				return;
			}

			final List<OrderEntryData> entryChildes = getOrderEntryFacade().getAllSpoEntries(entry);
			entry.setValidationMessages(getValidationMessages(entry));

			groupedCartEntries.put(entry, entryChildes);
		});

		return groupedCartEntries;
	}

	private Set<TmaCartValidationData> getValidationMessages(final OrderEntryData entry)
	{
		if (entry == null)
		{
			return Collections.emptySet();
		}

		final Set<TmaCartValidationData> validationMessages = new HashSet<>();

		if (CollectionUtils.isNotEmpty(entry.getValidationMessages()))
		{
			validationMessages.addAll(entry.getValidationMessages());
		}

		if (CollectionUtils.isEmpty(entry.getEntries()))
		{
			return validationMessages;
		}

		entry.getEntries().forEach((OrderEntryData childEntry) -> {
			if (childEntry == null)
			{
				return;
			}

			validationMessages.addAll(getValidationMessages(childEntry));
		});

		return validationMessages;
	}

	private boolean hasPickUpCartEntries(final OrderEntryData orderEntryData)
	{
		return orderEntryData.getDeliveryPointOfService() != null;
	}

	private void setUpdateQuantityForm(final Model model, final OrderEntryData entry)
	{
		final UpdateQuantityForm uqf = new UpdateQuantityForm();
		uqf.setQuantity(entry.getQuantity());
		model.addAttribute("updateQuantityForm" + entry.getEntryNumber(), uqf);
	}

	protected ResourceBreadcrumbBuilder getResourceBreadcrumbBuilder()
	{
		return resourceBreadcrumbBuilder;
	}

	@Resource(name = "simpleBreadcrumbBuilder")
	public void setResourceBreadcrumbBuilder(final ResourceBreadcrumbBuilder resourceBreadcrumbBuilder)
	{
		this.resourceBreadcrumbBuilder = resourceBreadcrumbBuilder;
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}

	@Override
	protected TmaCartFacade getCartFacade()
	{
		return (TmaCartFacade) super.getCartFacade();
	}

	protected TmaOrderEntryFacade getOrderEntryFacade()
	{
		return this.orderEntryFacade;
	}
}
