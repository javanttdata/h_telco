/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.misc;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.AbstractController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.forms.UpdateQuantityForm;
import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcofacades.configurableguidedselling.EntryGroupFacade;
import de.hybris.platform.b2ctelcofacades.data.CartActionInput;
import de.hybris.platform.b2ctelcofacades.data.TmaBpoPreConfigData;
import de.hybris.platform.b2ctelcofacades.order.TmaCartFacade;
import de.hybris.platform.b2ctelcofacades.order.TmaOrderEntryFacade;
import de.hybris.platform.b2ctelcofacades.order.impl.DefaultTmaCartFacade;
import de.hybris.platform.b2ctelcofacades.product.TmaBpoPreConfigFacade;
import de.hybris.platform.b2ctelcofacades.product.TmaProductFacade;
import de.hybris.platform.b2ctelcofacades.product.TmaProductOfferFacade;
import de.hybris.platform.b2ctelcofacades.user.TmaCustomerFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.b2ctelcoservices.services.TmaSubscriptionTermService;
import de.hybris.platform.commercefacades.order.CartFacade;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.CartModificationData;
import de.hybris.platform.commercefacades.order.data.OrderEntryData;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.PriceData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;
import de.hybris.platform.jalo.JaloObjectNoLongerValidException;
import de.hybris.platform.servicelayer.exceptions.ModelNotFoundException;
import de.hybris.platform.subscriptionfacades.data.SubscriptionTermData;
import de.hybris.platform.subscriptionservices.model.SubscriptionTermModel;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Controller for Add to Cart functionality which is not specific to a certain page.
 */
@Controller("TelcoAddToCartController")
public class AddToCartController extends AbstractController
{

	private static final Logger LOG = Logger.getLogger(AddToCartController.class);

	private static final String BPO_PRECONFIG_INVALID_ERROR_MESSAGE = "bpo.preconfig.invalid.error.message";

	private static final String INVALID_PRE_CONFIG_CALL = "invalidPreConfigCall";

	private static final String MODIFIED_CART_DATA = "modifiedCartData";

	private static final String BASKET_INFORMATION_QUANTITY_NO_ITEMS_ADDED = "basket.information.quantity.noItemsAdded";

	private static final String BASKET_ERROR_OCCURRED = "basket.error.occurred";

	private static final String CART_ENTRY_WAS_NOT_CREATED_REASON = "Cart entry was not created. Reason: ";

	private static final String CART = "/cart";

	private static final String BPO_CONFIGURE_PATH = "/bpo/configure/";

	private static final String BASKET_ERROR_QUANTITY_INVALID = "basket.error.quantity.invalid";

	private static final String QUANTITY = "quantity";

	private static final String ERROR_MSG_TYPE = "errorMsg";

	private static final int DEFAULT_ENTRY_NUMBER = -1;

	private static final String PRODUCT = "product";

	private final String[] DISALLOWED_FIELDS = new String[] {};

	protected static final String SUCCESS = "success";

	private static final String CART_DATA = "cartData";


	@Resource(name = "cartFacade")
	private CartFacade cartFacade;

	@Resource(name = "productFacade")
	private TmaProductFacade productFacade;

	@Resource(name = "tmaProductOfferFacade")
	private TmaProductOfferFacade productOfferFacade;

	@Resource(name = "cartFacade")
	private TmaCartFacade tmaCartFacade;

	@Resource(name = "entryGroupFacade")
	private EntryGroupFacade entryGroupFacade;

	@Resource(name = "tmaBpoPreConfigFacade")
	private TmaBpoPreConfigFacade tmaBpoPreConfigFacade;

	@Resource(name = "customerFacade")
	private TmaCustomerFacade customerFacade;

	@Resource(name = "tmaOrderEntryFacade")
	private TmaOrderEntryFacade tmaOrderEntryFacade;

	@Resource(name = "tmaSubscriptionTermService")
	private TmaSubscriptionTermService tmaSubscriptionTermService;


	/**
	 * Adds a new {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} entry to cart. The
	 * entry can be added as a simple product offering, or also as part of a bundled product offering identified through
	 * the rootBpoCode parameter.
	 *
	 * @param productCodePost
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel#CODE}
	 * @param processType
	 * 		represents the process flow in the context of which the entry is added to cart (Acquisition, Retention,
	 * 		etc.)
	 * @param qty
	 * 		quantity to be added;default value is 1
	 * @param rootBpoCode
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel#CODE} of the root
	 * 		Bundled Product Offering, as part of which the
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} is added
	 * @param parentEntryNumber
	 * 		specifies the identifier of the cart entry serving as parent for the entry to be added too
	 * @param subscriptionTermId
	 * 		specifies the identifier of the new subscription term
	 * @param subscriberIdentity
	 * 		represents subscriber identity for an existing customer
	 * @param subscriberBillingId
	 * 		represents subscriber billing system id for an existing customer
	 * @param model
	 * 		the Spring model
	 * @return the path for AddToCart popup showing the new added entries
	 */
	@RequestMapping(value = "/cart/add", method = RequestMethod.POST, produces = "application/json")
	public String addSpoToCart(@RequestParam("productCodePost") final String productCodePost,
			@RequestParam(value = "processType") final String processType,
			@RequestParam(value = "qty", required = false, defaultValue = "1") final long qty,
			@RequestParam(value = "rootBpoCode", required = false) final String rootBpoCode,
			@RequestParam(value = "parentEntryNumber", required = false, defaultValue = "-1") final int parentEntryNumber,
			@RequestParam(value = "subscriptionTermId", required = false) final String subscriptionTermId,
			@RequestParam(value = "subscriberIdentity", required = false) final String subscriberIdentity,
			@RequestParam(value = "subscriberBillingId", required = false) final String subscriberBillingId, final Model model)
	{
		if (qty <= 0)
		{
			model.addAttribute(ERROR_MSG_TYPE, BASKET_ERROR_QUANTITY_INVALID);
			model.addAttribute(QUANTITY, 0L);
		}
		else
		{
			final CartActionInput dataSource = createCartActionInput(processType, productCodePost, subscriptionTermId,
					subscriberIdentity, subscriberBillingId, rootBpoCode, qty);
			try
			{
				addProductOfferingToCart(dataSource, parentEntryNumber, model);
			}
			catch (CommerceCartModificationException e)
			{
				model.addAttribute(ERROR_MSG_TYPE, BASKET_ERROR_OCCURRED);
				LOG.warn("Couldn't add product of code " + YSanitizer.sanitize(dataSource.getProductCode()) + " to cart.", e);
			}
			final CartData cartData = getCartFacade().getSessionCart();
			model.addAttribute(CART_DATA, cartData);
		}

		model.addAttribute(PRODUCT,
				getProductFacade().getProductForCodeAndOptions(productCodePost, Collections.singletonList(ProductOption.BASIC)));

		return TelcoControllerConstants.Views.Fragments.Cart.ADD_TO_CART_POPUP;
	}


	/**
	 * Adds multiple {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} entries to cart, as
	 * part of a bundle product offering specified by the given rootBpoCode. The entries can be added under an existing
	 * cart entries group indicated by the cartGroupNo parameter, or under a new entry group .
	 *
	 * @param simpleProductOfferings
	 * 		a list of {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel#CODE}
	 * @param processType
	 * 		represents the process flow in the context of which the entry is added to cart (Acquisition, Retention,
	 * 		etc.)
	 * @param rootBpoCode
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel#CODE} of the root
	 * 		Bundled Product Offering, as part of which the
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} are added
	 * @param parentEntryNumber
	 * 		specifies the identifier of the cart entry serving as parent for the new entries to be added to cart
	 * @param model
	 * 		the Spring model
	 * @return the link to cart page
	 */
	@RequestMapping(value = "/cart/addBpo", method = RequestMethod.POST)
	public String addBpoToCart(@RequestParam(value = "simpleProductOfferings") final List<String> simpleProductOfferings,
			@RequestParam(value = "processType") final String processType,
			@RequestParam(value = "rootBpoCode") final String rootBpoCode,
			@RequestParam(value = "parentEntryNumber", required = false, defaultValue = "-1") final int parentEntryNumber,
			@RequestParam(value = "subscriptionTermId", required = false) final String subscriptionTermId,
			@RequestParam(value = "subscriberIdentity", required = false) final String subscriberIdentity,
			@RequestParam(value = "subscriberBillingId", required = false) final String subscriberBillingId, final Model model)
	{
		try
		{
			final String termId = getSubscriptionTermId(subscriptionTermId, simpleProductOfferings, parentEntryNumber);
			final List<CartModificationData> cartModifications = new ArrayList<>();

			int parentEntryNo = parentEntryNumber;
			for (final String spo : simpleProductOfferings)
			{
				CartActionInput dataSource = createCartActionInput(processType, spo, termId, subscriberIdentity,
						subscriberBillingId, rootBpoCode, DefaultTmaCartFacade.DEFAULT_QUANTITY);
				final CartActionInput cartActionInput = createCartAction(dataSource, parentEntryNo);

				final List<CartModificationData> cartModificationData = getTmaCartFacade()
						.processCartAction(Collections.singletonList(cartActionInput));
				cartModifications.addAll(cartModificationData);

				if (CollectionUtils.isNotEmpty(cartModificationData) && parentEntryNo == DEFAULT_ENTRY_NUMBER)
				{
					parentEntryNo = cartModificationData.iterator().next().getEntry().getEntryNumber();
				}
			}

			model.addAttribute(MODIFIED_CART_DATA, cartModifications);

			for (final CartModificationData cartModification : cartModifications)
			{
				if (cartModification.getEntry() == null)
				{
					GlobalMessages.addErrorMessage(model, BASKET_INFORMATION_QUANTITY_NO_ITEMS_ADDED);
					model.addAttribute(ERROR_MSG_TYPE, BASKET_INFORMATION_QUANTITY_NO_ITEMS_ADDED);
					throw new CommerceCartModificationException(CART_ENTRY_WAS_NOT_CREATED_REASON + cartModification.getStatusCode());
				}
			}
		}
		catch (final CommerceCartModificationException ex)
		{
			final List<String> sanitizedSimpleProductOffering = new ArrayList<>();
			model.addAttribute(ERROR_MSG_TYPE, BASKET_ERROR_OCCURRED);
			simpleProductOfferings.forEach(simpleProductOffering ->
					sanitizedSimpleProductOffering.add(YSanitizer.sanitize(simpleProductOffering)));
			LOG.error("Couldn't add BPO of code " + YSanitizer.sanitize(rootBpoCode) + " and spos with codes"
					+ sanitizedSimpleProductOffering, ex);
		}

		return REDIRECT_PREFIX + CART;
	}

	/**
	 * Adds a new {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} entry to cart for the
	 * BPO. The entry can be added as a simple product offering as a part of a bundled product offering identified
	 * through the rootBpoCode parameter and group number if any
	 *
	 * @param productCodePost
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel#CODE}
	 * @param qty
	 * 		quantity to be added;default value is 1
	 * @param processType
	 * 		represents the process flow in the context of which the entry is added to cart (Acquisition, Retention,
	 * 		etc.)
	 * @param rootBpoCode
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel#CODE} of the root
	 * 		Bundled Product Offering, as part of which the
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} is added
	 * @param currentStep
	 * 		Step id or the group Id from where the SPO is added to the BPO
	 * @param parentEntryNumber
	 * 		specifies the identifier of the cart entry serving as parent for the new entry to be added too
	 * @param model
	 * 		the Spring model
	 * @param query
	 * 		The applied query on page
	 * @param page
	 * 		The page number from which the product is added to the cart
	 * @return the path for bpo guided selling for the group appended with the group number
	 */
	@RequestMapping(value = "/cart/addSpo", method = RequestMethod.POST, produces = "application/json")
	public String addSpoToBpoConfiguration(@RequestParam("productCodePost") final String productCodePost,
			@RequestParam(value = "qty", required = false, defaultValue = "1") final long qty,
			@RequestParam(value = "processType") final String processType,
			@RequestParam(value = "rootBpoCode") final String rootBpoCode,
			@RequestParam(value = "currentStep", required = false) final String currentStep,
			@RequestParam(value = "parentEntryNumber", required = false, defaultValue = "-1") final int parentEntryNumber,
			final Model model, final RedirectAttributes redirectModel,
			@RequestParam(value = "q", required = false) final String query,
			@RequestParam(value = "page", required = false) final String page)
	{
		int parentEntryNo = parentEntryNumber;
		try
		{
			if (qty <= 0)
			{
				model.addAttribute(ERROR_MSG_TYPE, BASKET_ERROR_QUANTITY_INVALID);
				model.addAttribute(QUANTITY, 0L);

				model.addAttribute(PRODUCT, getProductFacade()
						.getProductForCodeAndOptions(productCodePost, Collections.singletonList(ProductOption.BASIC)));

				return this.extractJourneyRedirectUrl(XSSFilterUtil.filter(rootBpoCode), String.valueOf(parentEntryNumber),
						XSSFilterUtil.filter(currentStep), XSSFilterUtil.filter(page), XSSFilterUtil.filter(query));
			}

			CartActionInput dataSource = createCartActionInput(processType, productCodePost, Strings.EMPTY, Strings.EMPTY,
					Strings.EMPTY, rootBpoCode, qty);
			final List<CartModificationData> cartModifications = addProductOfferingToCart(dataSource, parentEntryNo, model);

			if (CollectionUtils.isNotEmpty(cartModifications))
			{
				parentEntryNo = getParentEntryNumber(parentEntryNumber, cartModifications.iterator().next());
			}

			if (parentEntryNo != DEFAULT_ENTRY_NUMBER)
			{
				model.addAttribute("parentEntryNumber", parentEntryNo);
			}
			final CartData cartData = getCartFacade().getSessionCart();
			model.addAttribute(CART_DATA, cartData);
		}
		catch (final CommerceCartModificationException ex)
		{
			final CartData cartData = getCartFacade().getSessionCart();
			model.addAttribute(CART_DATA, cartData);
			model.addAttribute(ERROR_MSG_TYPE, BASKET_ERROR_OCCURRED);
			LOG.error("Couldn't add SPO of code " + YSanitizer.sanitize(productCodePost) + " as part of " + YSanitizer
					.sanitize(rootBpoCode), ex);
			GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER, BASKET_ERROR_OCCURRED);

			return REDIRECT_PREFIX + BPO_CONFIGURE_PATH + XSSFilterUtil.filter(rootBpoCode) + "/" + XSSFilterUtil.filter(currentStep)
					+ "/" + parentEntryNo;
		}

		model.addAttribute(PRODUCT,
				getProductFacade().getProductForCodeAndOptions(productCodePost, Collections.singletonList(ProductOption.BASIC)));

		return this.extractJourneyRedirectUrl(XSSFilterUtil.filter(rootBpoCode), String.valueOf(parentEntryNo),
				XSSFilterUtil.filter(currentStep), XSSFilterUtil.filter(page), XSSFilterUtil.filter(query));
	}

	private int getParentEntryNumber(final Integer parentEntryNumber, final CartModificationData modification)
	{
		if (modification == null)
		{
			return parentEntryNumber;
		}

		if (modification.getParentEntryNumber() == null)
		{
			return DEFAULT_ENTRY_NUMBER;
		}

		return modification.getParentEntryNumber();
	}

	/**
	 * Removes the SPO added to the journey step
	 *
	 * @param entryNumber
	 * 		entry number of the cart entry to be updated
	 * @param groupId
	 * 		The groupId of the journey
	 * @param bpoCode
	 * 		The parent BPO code for the journey
	 * @param parentEntryNumber
	 * 		specifies the identifier of the parent entry where the entry is to be removed from
	 * @param model
	 * 		page model to be populated with information
	 * @param form
	 * 		update quantity form specifying the new quantity of the product from the entry with the number given
	 * @param bindingResult
	 * 		request binding result to retrieve validation errors from
	 * @param redirectModel
	 * 		redirect model to be populated with information
	 * @return redirect url to the journey page
	 */

	@RequestMapping(value = "/cart/removeSpo", method = RequestMethod.POST)
	public String removeSpoFromJourneyStep(
			@RequestParam("entryNumber") final long entryNumber,
			@RequestParam("bpoCode") final String bpoCode,
			@RequestParam("groupId") final String groupId,
			@RequestParam("parentEntryNumber") final String parentEntryNumber,
			final Model model, @Valid final UpdateQuantityForm form,
			final BindingResult bindingResult, final RedirectAttributes redirectModel)
	{

		if (bindingResult.hasErrors())
		{
			populatePageModelWithErrors(model, bindingResult);
		}
		else if (getCartFacade().hasEntries())
		{
			try
			{
				final long newQuantity = form.getQuantity();
				final CartModificationData cartModification = getTmaCartFacade().updateCartEntry(entryNumber, newQuantity);
				String alertMessageCode;
				if (cartModification.getQuantity() == newQuantity)
				{
					// Success in either removal or updating the quantity
					alertMessageCode = cartModification.getQuantity() == 0 ? "basket.page.message.remove"
							: "basket.page.message.update";
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER, alertMessageCode);
				}
			}
			catch (final JaloObjectNoLongerValidException | CommerceCartModificationException ex)
			{
				LOG.error("Could not update quantity of product with entry number: " + entryNumber + ".", ex);
			}
		}
		return REDIRECT_PREFIX + BPO_CONFIGURE_PATH + XSSFilterUtil.filter(bpoCode) + "/" + XSSFilterUtil.filter(groupId) + "/"
				+ XSSFilterUtil.filter(parentEntryNumber);
	}

	@RequestMapping(value = "/cart/preconfig/{preConfig}", method = RequestMethod.GET)
	public String addpreConfig(
			@PathVariable("preConfig") final String preConfig,
			final Model model, final RedirectAttributes redirectModel)
	{
		try
		{
			final TmaBpoPreConfigData tmaBpoPreConfigData = getTmaBpoPreConfigFacade().getPreConfigBpo(preConfig);
			if (tmaBpoPreConfigData != null && CollectionUtils.isNotEmpty(tmaBpoPreConfigData.getSpoList()))
			{
				final List<CartModificationData> cartModifications = getTmaCartFacade().addBpoSelectedOfferings(
						tmaBpoPreConfigData.getRootBpoCode(), tmaBpoPreConfigData.getSpoList(), TmaProcessType.ACQUISITION.getCode(),
						-1, Strings.EMPTY, Strings.EMPTY, Strings.EMPTY);
				model.addAttribute(MODIFIED_CART_DATA, cartModifications);

				for (final CartModificationData cartModification : cartModifications)
				{
					if (cartModification.getEntry() == null)
					{
						throw new CommerceCartModificationException(
								CART_ENTRY_WAS_NOT_CREATED_REASON + cartModification.getStatusCode());
					}
				}
			}
		}
		catch (final ModelNotFoundException | IllegalArgumentException modelNotFoundException)
		{
			LOG.info(modelNotFoundException);
			redirectModel.addFlashAttribute(INVALID_PRE_CONFIG_CALL, BPO_PRECONFIG_INVALID_ERROR_MESSAGE);
		}
		catch (final CommerceCartModificationException cartModificationException)
		{
			LOG.info(cartModificationException);
			redirectModel.addFlashAttribute(INVALID_PRE_CONFIG_CALL, BASKET_ERROR_OCCURRED);
		}

		return REDIRECT_PREFIX + CART;
	}


	private List<CartModificationData> addProductOfferingToCart(final CartActionInput inputDataSource, final int parentEntryNumber,
			final Model model) throws CommerceCartModificationException
	{
		List<CartModificationData> cartModifications;

		final String subscriptionTermId = getSubscriptionTermId(inputDataSource.getSubscriptionTermId(),
				inputDataSource.getProductCode(), parentEntryNumber);
		final CartActionInput dataSource = createCartActionInput(inputDataSource.getProcessType(),
				inputDataSource.getProductCode(), subscriptionTermId, inputDataSource.getSubscriberId(),
				inputDataSource.getSubscriberBillingId(), inputDataSource.getRootBpoCode(), inputDataSource.getQuantity());
		final CartActionInput cartActionInput = createCartAction(dataSource, parentEntryNumber);

		cartModifications = getTmaCartFacade().processCartAction(Collections.singletonList(cartActionInput));
		cartModifications.get(0).setParentEntryNumber(
				getParentEntryNumber(parentEntryNumber, cartActionInput, cartModifications.iterator().next()));

		model.addAttribute(MODIFIED_CART_DATA, cartModifications);

		cartModifications.forEach((CartModificationData cartModification) ->
				processCartModificationResponse(inputDataSource.getQuantity(), model, cartModification));

		return cartModifications;
	}
	private void processCartModificationResponse(final long quantity, final Model model,
			final CartModificationData cartModification)
	{
		if (cartModification == null || cartModification.getEntry() == null || cartModification.getEntry().getBpo() == null)
		{
			return;
		}

		if (cartModification.getQuantityAdded() == 0L)
		{
			GlobalMessages
					.addErrorMessage(model, "basket.information.quantity.noItemsAdded." + cartModification.getStatusCode());
			model.addAttribute(ERROR_MSG_TYPE, "basket.information.quantity.noItemsAdded." + cartModification.getStatusCode());
		}

		if (cartModification.getQuantityAdded() < quantity)
		{
			GlobalMessages.addErrorMessage(model,
					"basket.information.quantity.reducedNumberOfItemsAdded." + cartModification.getStatusCode());
			model.addAttribute(ERROR_MSG_TYPE,
					"basket.information.quantity.reducedNumberOfItemsAdded." + cartModification.getStatusCode());
		}

		model.addAttribute("entry", cartModification.getEntry());
		model.addAttribute("cartCode", cartModification.getCartCode());
		model.addAttribute(QUANTITY, quantity);
	}

	private CartActionInput createCartAction(final CartActionInput dataSource, final int parentEntryNumber)
	{
		if (StringUtils.isEmpty(dataSource.getRootBpoCode()))
		{
			return createCartActionInput(dataSource.getProcessType(), dataSource.getProductCode(),
					dataSource.getSubscriptionTermId(), dataSource.getSubscriberId(), dataSource.getSubscriberBillingId(),
					dataSource.getRootBpoCode(), dataSource.getQuantity());
		}

		final OrderEntryData rootEntry = getTmaOrderEntryFacade()
				.getEntry(getCartFacade().getSessionCart().getEntries(), parentEntryNumber);
		final List<OrderEntryData> entriesInBundle = getTmaOrderEntryFacade().getAllChildEntries(rootEntry);
		final List<ProductData> parentBpos = getIntermediateParentsToBeAdded(dataSource.getProductCode(),
				dataSource.getRootBpoCode(), entriesInBundle);

		if (CollectionUtils.isEmpty(parentBpos))
		{
			throw new IllegalArgumentException(
					"Couldn't add product " + YSanitizer.sanitize(dataSource.getProductCode()) + " to cart.");
		}

		final ProductData firstParentAlreadyInCart = parentBpos.iterator().next();

		final OrderEntryData parentEntry = entriesInBundle.stream()
				.filter((OrderEntryData entry) -> entry.getProduct().getCode().equals(firstParentAlreadyInCart.getCode()))
				.findFirst().orElse(null);


		final CartActionInput cartActionInput = createCartActionInput(getProcessType(parentEntry, dataSource.getProcessType()),
				parentBpos.get(0).getCode(), dataSource.getSubscriptionTermId(), dataSource.getSubscriberId(),
				dataSource.getSubscriberBillingId(), dataSource.getRootBpoCode(), DefaultTmaCartFacade.DEFAULT_QUANTITY);

		CartActionInput oldCartActionInput = cartActionInput;

		for (int i = 1; i < parentBpos.size(); i++)
		{
			final CartActionInput newCartActionInput = createCartActionInput(
					getProcessType(parentEntry, dataSource.getProcessType()),
					parentBpos.get(i).getCode(), dataSource.getSubscriptionTermId(), dataSource.getSubscriberId(),
					dataSource.getSubscriberBillingId(), dataSource.getRootBpoCode(), DefaultTmaCartFacade.DEFAULT_QUANTITY);

			oldCartActionInput.setChildren(Collections.singletonList(newCartActionInput));
			oldCartActionInput = newCartActionInput;

		}

		final CartActionInput childCartActionInput = createCartActionInput(getProcessType(parentEntry,
				dataSource.getProcessType()), dataSource.getProductCode(), dataSource.getSubscriptionTermId(),
				dataSource.getSubscriberId(), dataSource.getSubscriberBillingId(), dataSource.getRootBpoCode(),
				dataSource.getQuantity());
		oldCartActionInput.setChildren(Collections.singletonList(childCartActionInput));

		if (parentEntry == null)
		{
			return cartActionInput;
		}

		final CartActionInput addToExistingBpoCartActionInput = cartActionInput.getChildren().iterator().next();
		addToExistingBpoCartActionInput.setParentEntryNumber(parentEntry.getEntryNumber());

		return addToExistingBpoCartActionInput;
	}

	private String getProcessType(final OrderEntryData parentEntry, final String processType)
	{
		if (parentEntry == null)
		{
			return processType;
		}

		return null;
	}

	private List<ProductData> getIntermediateParentsToBeAdded(final String spoCode, final String rootBpo,
			final List<OrderEntryData> entriesInBundle)
	{
		final List<ProductData> parentBpos = getProductFacade().getIntermediateBpos(spoCode, rootBpo);

		if (CollectionUtils.isEmpty(parentBpos))
		{
			return Collections.emptyList();
		}

		if (CollectionUtils.isEmpty(entriesInBundle))
		{
			Collections.reverse(parentBpos);

			return parentBpos;
		}

		final List<String> posInBundleEntry = entriesInBundle.stream()
				.map(OrderEntryData::getProduct)
				.map(ProductData::getCode)
				.collect(Collectors.toList());

		final Optional<ProductData> firstParentAlreadyInCart = parentBpos.stream()
				.filter((ProductData bpo) -> posInBundleEntry.contains(bpo.getCode())).findFirst();

		if (firstParentAlreadyInCart.isEmpty())
		{
			return Collections.emptyList();
		}

		parentBpos.subList(parentBpos.indexOf(firstParentAlreadyInCart.get()) + 1, parentBpos.size()).clear();

		Collections.reverse(parentBpos);

		return parentBpos;
	}

	private CartActionInput createCartActionInput(final String processType, final String productCode,
			final String subscriptionTermId, final String subscriberId, final String subscriberBillingId, final String bpoCode,
			final long quantity)
	{

		final CartActionInput cartActionInput = new CartActionInput();

		cartActionInput.setCartId(getCartFacade().getSessionCart().getCode());
		cartActionInput.setUserGuid(getCustomerFacade().getCurrentCustomerUid());
		cartActionInput.setProductCode(productCode);
		cartActionInput.setProcessType(processType);
		cartActionInput.setSubscriptionTermId(subscriptionTermId);
		cartActionInput.setSubscriberId(subscriberId);
		cartActionInput.setSubscriberBillingId(subscriberBillingId);
		if (!StringUtils.equalsIgnoreCase(productCode, bpoCode))
		{
			cartActionInput.setRootBpoCode(bpoCode);
		}
		cartActionInput.setQuantity(quantity);

		return cartActionInput;
	}

	private Integer getParentEntryNumber(final int parentEntryNumber, final CartActionInput cartActionInput,
			final CartModificationData cartModificationData)
	{
		if (cartActionInput.getParentEntryNumber() != null)
		{
			return parentEntryNumber;
		}

		return cartModificationData.getEntry().getEntryNumber();
	}

	private void populatePageModelWithErrors(final Model model, final BindingResult bindingResult)
	{
		for (final ObjectError error : bindingResult.getAllErrors())
		{
			final String errorMessageCode = "".equals(error.getCode()) ? BASKET_ERROR_QUANTITY_INVALID : error.getDefaultMessage();
			GlobalMessages.addErrorMessage(model, errorMessageCode);
		}
	}

	/**
	 * This generates the redirect url for the BPO guided selling journey , if the current Step is empty it redirects to
	 * the TmaEditEntryGroupController
	 *
	 * @param rootBpoCode
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel#CODE} of the root
	 * 		Bundled Product Offering, as part of which the
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} is added
	 * @param currentStep
	 * 		The Current step or the Group of
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel} of the root Bundled
	 * 		Product Offering, from where
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaSimpleProductOfferingModel} is added
	 * @param parentEntryNumber
	 * 		The idenifier of the parent entry corresponding to the
	 *      {@link de.hybris.platform.b2ctelcoservices.model.TmaBundledProductOfferingModel}
	 * @param page
	 * 		The page number from which the product is added to the cart
	 * @param query
	 * 		The applied query on page
	 * @return redirect url String
	 */
	private String extractJourneyRedirectUrl(final String rootBpoCode, final String parentEntryNumber, final String currentStep,
			final String page, final String query)
	{
		if (!StringUtils.isBlank(currentStep))
		{

			if (!StringUtils.isBlank(page))
			{
				return REDIRECT_PREFIX + BPO_CONFIGURE_PATH + rootBpoCode + "/" + currentStep + "/" + parentEntryNumber
						+ "?q=" + query + "&page=" + page;

			}
			return REDIRECT_PREFIX + BPO_CONFIGURE_PATH + rootBpoCode + "/" + currentStep + "/" + parentEntryNumber;
		}
		return REDIRECT_PREFIX + "/bpo/edit/configure/" + rootBpoCode + "/" + parentEntryNumber;
	}

	private String getSubscriptionTermId(final String subscriptionTermId, final String spoCode, final int parentEntryNumber)
	{
		if (StringUtils.isNotEmpty(subscriptionTermId))
		{
			return subscriptionTermId;
		}

		final String parentTermId = getSubscriptionTermId(getTmaCartFacade().getSessionCart(), parentEntryNumber);

		if (StringUtils.isNotEmpty(parentTermId))
		{
			return parentTermId;
		}

		final ProductData productOffering = getProductOfferFacade()
				.getPoForCode(spoCode, Collections.singletonList(ProductOption.PRODUCT_OFFERING_PRICES));

		final PriceData bestApplicablePrice = productOffering.getPrices().stream()
				.sorted(Comparator.comparingInt(PriceData::getPriority).reversed())
				.collect(Collectors.toList()).iterator().next();

		if (bestApplicablePrice == null || CollectionUtils.isEmpty(bestApplicablePrice.getSubscriptionTerms()))
		{
			return null;
		}

		final SubscriptionTermModel defaultSubscriptionTerm = getTmaSubscriptionTermService().getDefaultSubscriptionTerm();
		if (defaultSubscriptionTerm != null)
		{
			for (SubscriptionTermData subscriptionTerm : bestApplicablePrice.getSubscriptionTerms())
			{
				if (subscriptionTerm.getId().equals(defaultSubscriptionTerm.getId()))
				{
					return subscriptionTerm.getId();
				}
			}
		}

		return bestApplicablePrice.getSubscriptionTerms().iterator().next().getId();
	}

	private String getSubscriptionTermId(final String subscriptionTermId, final List<String> spoCodes, final int parentEntryNumber)
	{
		if (subscriptionTermId != null)
		{
			return subscriptionTermId;
		}

		for (String spoCode : spoCodes)
		{
			final String termId = getSubscriptionTermId(subscriptionTermId, spoCode, parentEntryNumber);

			if (termId != null)
			{
				return termId;
			}
		}

		return null;
	}

	private String getSubscriptionTermId(final CartData cart, final int parentEntryNumber)
	{
		if (parentEntryNumber != DEFAULT_ENTRY_NUMBER || cart == null || CollectionUtils.isEmpty(cart.getEntries()))
		{
			return null;
		}

		final OrderEntryData entry = getTmaOrderEntryFacade().getEntry(cart.getEntries(), parentEntryNumber);

		if (entry != null && entry.getSubscriptionInfo() != null && entry.getSubscriptionInfo().getSubscriptionTerm() != null
				&& StringUtils.isNotEmpty(entry.getSubscriptionInfo().getSubscriptionTerm().getId()))
		{
			return entry.getSubscriptionInfo().getSubscriptionTerm().getId();
		}

		return null;
	}

	protected CartFacade getCartFacade()
	{
		return cartFacade;
	}

	protected void setCartFacade(final CartFacade cartFacade)
	{
		this.cartFacade = cartFacade;
	}

	protected TmaProductFacade getProductFacade()
	{
		return productFacade;
	}

	protected TmaCartFacade getTmaCartFacade()
	{
		return tmaCartFacade;
	}

	public void setTmaCartFacade(final TmaCartFacade tmaCartFacade)
	{
		this.tmaCartFacade = tmaCartFacade;
	}

	protected EntryGroupFacade getEntryGroupFacade()
	{
		return entryGroupFacade;
	}

	public void setEntryGroupFacade(final EntryGroupFacade entryGroupFacade)
	{
		this.entryGroupFacade = entryGroupFacade;
	}

	public TmaBpoPreConfigFacade getTmaBpoPreConfigFacade()
	{
		return tmaBpoPreConfigFacade;
	}

	public void setTmaBpoPreConfigFacade(final TmaBpoPreConfigFacade tmaBpoPreConfigFacade)
	{
		this.tmaBpoPreConfigFacade = tmaBpoPreConfigFacade;
	}

	public TmaCustomerFacade getCustomerFacade()
	{
		return customerFacade;
	}

	protected TmaOrderEntryFacade getTmaOrderEntryFacade()
	{
		return tmaOrderEntryFacade;
	}

	protected TmaProductOfferFacade getProductOfferFacade()
	{
		return productOfferFacade;
	}

	protected TmaSubscriptionTermService getTmaSubscriptionTermService()
	{
		return tmaSubscriptionTermService;
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}
}
