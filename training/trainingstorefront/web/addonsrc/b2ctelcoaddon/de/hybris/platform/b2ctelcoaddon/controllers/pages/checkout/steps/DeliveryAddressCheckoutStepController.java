/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.checkout.steps;

import de.hybris.platform.acceleratorstorefrontcommons.annotations.PreValidateCheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.CheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.forms.AddressForm;
import de.hybris.platform.b2ctelcoaddon.controllers.ControllerConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.util.CartHelper;
import de.hybris.platform.b2ctelcofacades.order.TmaOrderEntryFacade;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.address.data.AddressVerificationResult;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.user.data.AddressData;
import de.hybris.platform.commercefacades.user.data.CountryData;
import de.hybris.platform.commercefacades.user.data.RegionData;
import de.hybris.platform.commerceservices.address.AddressVerificationDecision;
import de.hybris.platform.util.Config;

import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Delivery address page controller.
 */
@Controller
@RequestMapping(value = "/checkout/multi/delivery-address")
public class DeliveryAddressCheckoutStepController extends AbstractCheckoutStepController
{
	protected static final String DELIVERY_ADDRESS = "delivery-address";
	protected static final String ATTR_CART_DATA = "cartData";
	protected static final String ATTR_COUNTRY = "country";
	protected static final String ATTR_REGIONS = "regions";
	protected static final String ATTR_DELIVERY_ADDRESSES = "deliveryAddresses";
	protected static final String ATTR_NO_ADDRESS = "noAddress";
	protected static final String ATTR_ADDRESS_FORM = "addressForm";
	protected static final String ATTR_SHOW_SAVE_TO_ADDRESS_BOOK = "showSaveToAddressBook";
	private final String[] DISALLOWED_FIELDS = new String[] {};

	@Resource(name = "tmaOrderEntryFacade")
	private TmaOrderEntryFacade tmaOrderEntryFacade;

	@Override
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@RequireHardLogIn
	@PreValidateCheckoutStep(checkoutStep = DELIVERY_ADDRESS)
	public String enterStep(final Model model, final RedirectAttributes redirectAttributes) throws CMSItemNotFoundException
	{
		getCheckoutFacade().setDeliveryAddressIfAvailable();

		final CartData cartData = getCheckoutFacade().getCheckoutCart();
		cartData.setEntries(CartHelper.removeEmptyEntries(cartData.getEntries()));
		cartData.setEntries(getTmaOrderEntryFacade().getAllSpoEntries(cartData));

		model.addAttribute(ATTR_CART_DATA, cartData);
		model.addAttribute(ATTR_DELIVERY_ADDRESSES, getDeliveryAddresses(cartData.getDeliveryAddress()));
		model.addAttribute(ATTR_NO_ADDRESS, Boolean.valueOf(getCheckoutFlowFacade().hasNoDeliveryAddress()));
		model.addAttribute(ATTR_ADDRESS_FORM, new AddressForm());
		model.addAttribute(ATTR_SHOW_SAVE_TO_ADDRESS_BOOK, Boolean.TRUE);
		prepareDataForPage(model);
		storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		model.addAttribute(WebConstants.BREADCRUMBS_KEY,
				getResourceBreadcrumbBuilder().getBreadcrumbs("checkout.multi.deliveryAddress.breadcrumb"));
		model.addAttribute("metaRobots", "noindex,nofollow");
		setCheckoutStepLinksForModel(model, getCheckoutStep());

		return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@RequireHardLogIn
	public String add(final AddressForm addressForm, final BindingResult bindingResult, final Model model,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		getAddressValidator().validate(addressForm, bindingResult);

		final CartData cartData = getCheckoutFacade().getCheckoutCart();
		cartData.setEntries(getTmaOrderEntryFacade().getAllSpoEntries(cartData));

		model.addAttribute(ATTR_CART_DATA, cartData);
		model.addAttribute(ATTR_DELIVERY_ADDRESSES, getDeliveryAddresses(cartData.getDeliveryAddress()));
		this.prepareDataForPage(model);
		storeAddresses(addressForm, model);

		if (bindingResult.hasErrors())
		{
			GlobalMessages.addErrorMessage(model, "address.error.formentry.invalid");
			storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			setCheckoutStepLinksForModel(model, getCheckoutStep());
			return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
		}
		final AddressData newAddress = constructNewAddress(addressForm);
		adjustAddressVisibility(addressForm, newAddress);

		// Verify the address data.
		final AddressVerificationResult<AddressVerificationDecision> verificationResult = getAddressVerificationFacade()
				.verifyAddressData(newAddress);
		final boolean addressRequiresReview = getAddressVerificationResultHandler().handleResult(verificationResult, newAddress,
				model, redirectModel, bindingResult, getAddressVerificationFacade().isCustomerAllowedToIgnoreAddressSuggestions(),
				"checkout.multi.address.updated");

		if (addressRequiresReview)
		{
			storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
		}

		getUserFacade().addAddress(newAddress);
		final AddressData previousSelectedAddress = getCheckoutFacade().getCheckoutCart().getDeliveryAddress();
		// Set the new address as the selected checkout delivery address
		getCheckoutFacade().setDeliveryAddress(newAddress);

		if (previousSelectedAddress != null && !previousSelectedAddress.isVisibleInAddressBook())
		{ // temporary address should be removed
			getUserFacade().removeAddress(previousSelectedAddress);
		}

		return getCheckoutStep().nextStep();
	}

	protected void adjustAddressVisibility(final AddressForm addressForm, final AddressData newAddress)
	{
		if (addressForm.getSaveInAddressBook() != null)
		{
			newAddress.setVisibleInAddressBook(addressForm.getSaveInAddressBook().booleanValue());
			if (addressForm.getSaveInAddressBook().booleanValue() && getUserFacade().isAddressBookEmpty())
			{
				newAddress.setDefaultAddress(true);
			}
		}
		else if (getCheckoutCustomerStrategy().isAnonymousCheckout())
		{
			newAddress.setDefaultAddress(true);
			newAddress.setVisibleInAddressBook(true);
		}
	}

	protected AddressData constructNewAddress(final AddressForm addressForm)
	{
		final AddressData newAddress = new AddressData();
		newAddress.setTitleCode(addressForm.getTitleCode());
		newAddress.setFirstName(addressForm.getFirstName());
		newAddress.setLastName(addressForm.getLastName());
		newAddress.setLine1(addressForm.getLine1());
		newAddress.setLine2(addressForm.getLine2());
		newAddress.setTown(addressForm.getTownCity());
		newAddress.setPostalCode(addressForm.getPostcode());
		newAddress.setBillingAddress(false);
		newAddress.setShippingAddress(true);
		newAddress.setPhone(addressForm.getPhone());
		if (addressForm.getCountryIso() != null)
		{
			final CountryData countryData = getI18NFacade().getCountryForIsocode(addressForm.getCountryIso());
			newAddress.setCountry(countryData);
		}
		if (addressForm.getRegionIso() != null && !StringUtils.isEmpty(addressForm.getRegionIso()))
		{
			final RegionData regionData = getI18NFacade().getRegion(addressForm.getCountryIso(), addressForm.getRegionIso());
			newAddress.setRegion(regionData);
		}

		return newAddress;
	}

	protected void storeAddresses(final AddressForm addressForm, final Model model)
	{
		if (StringUtils.isNotBlank(addressForm.getCountryIso()))
		{
			model.addAttribute(ATTR_REGIONS, getI18NFacade().getRegionsForCountryIso(addressForm.getCountryIso()));
			model.addAttribute(ATTR_COUNTRY, addressForm.getCountryIso());
		}

		model.addAttribute(ATTR_NO_ADDRESS, Boolean.valueOf(getCheckoutFlowFacade().hasNoDeliveryAddress()));
		model.addAttribute(ATTR_SHOW_SAVE_TO_ADDRESS_BOOK, Boolean.TRUE);
	}

	/**
	 * Edit resource.
	 *
	 * @param editAddressCode
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * @throws CMSItemNotFoundException
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	@RequireHardLogIn
	public String editAddressForm(@RequestParam("editAddressCode") final String editAddressCode, final Model model,
			final RedirectAttributes redirectAttributes) throws CMSItemNotFoundException
	{
		final ValidationResults validationResults = getCheckoutStep().validate(redirectAttributes);
		if (getCheckoutStep().checkIfValidationErrors(validationResults))
		{
			return getCheckoutStep().onValidation(validationResults);
		}

		AddressData addressData = null;
		if (StringUtils.isNotEmpty(editAddressCode))
		{
			addressData = getCheckoutFacade().getDeliveryAddressForCode(editAddressCode);
		}

		final AddressForm addressForm = new AddressForm();
		final boolean hasAddressData = addressData != null;
		if (hasAddressData)
		{
			addressForm.setAddressId(addressData.getId());
			addressForm.setTitleCode(addressData.getTitleCode());
			addressForm.setFirstName(addressData.getFirstName());
			addressForm.setLastName(addressData.getLastName());
			addressForm.setLine1(addressData.getLine1());
			addressForm.setLine2(addressData.getLine2());
			addressForm.setTownCity(addressData.getTown());
			addressForm.setPostcode(addressData.getPostalCode());
			addressForm.setCountryIso(addressData.getCountry().getIsocode());
			addressForm.setSaveInAddressBook(Boolean.valueOf(addressData.isVisibleInAddressBook()));
			addressForm.setShippingAddress(Boolean.valueOf(addressData.isShippingAddress()));
			addressForm.setBillingAddress(Boolean.valueOf(addressData.isBillingAddress()));
			addressForm.setPhone(addressData.getPhone());
			if (addressData.getRegion() != null && !StringUtils.isEmpty(addressData.getRegion().getIsocode()))
			{
				addressForm.setRegionIso(addressData.getRegion().getIsocode());
			}
		}

		final CartData cartData = getCheckoutFacade().getCheckoutCart();
		cartData.setEntries(getTmaOrderEntryFacade().getAllSpoEntries(cartData));

		model.addAttribute(ATTR_CART_DATA, cartData);
		model.addAttribute(ATTR_DELIVERY_ADDRESSES, getDeliveryAddresses(cartData.getDeliveryAddress()));
		if (StringUtils.isNotBlank(addressForm.getCountryIso()))
		{
			model.addAttribute(ATTR_REGIONS, getI18NFacade().getRegionsForCountryIso(addressForm.getCountryIso()));
			model.addAttribute(ATTR_COUNTRY, addressForm.getCountryIso());
		}
		model.addAttribute(ATTR_NO_ADDRESS, Boolean.valueOf(getCheckoutFlowFacade().hasNoDeliveryAddress()));
		model.addAttribute("edit", Boolean.valueOf(hasAddressData));
		model.addAttribute(ATTR_ADDRESS_FORM, addressForm);
		if (addressData != null)
		{
			model.addAttribute(ATTR_SHOW_SAVE_TO_ADDRESS_BOOK, Boolean.valueOf(!addressData.isVisibleInAddressBook()));
		}
		storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		model.addAttribute(WebConstants.BREADCRUMBS_KEY,
				getResourceBreadcrumbBuilder().getBreadcrumbs("checkout.multi.deliveryAddress.breadcrumb"));
		model.addAttribute("metaRobots", "noindex,nofollow");
		setCheckoutStepLinksForModel(model, getCheckoutStep());

		return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
	}

	/**
	 * Save resource.
	 *
	 * @param addressForm
	 * @param bindingResult
	 * @param model
	 * @param redirectModel
	 * @return
	 * @throws CMSItemNotFoundException
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	@RequireHardLogIn
	public String edit(final AddressForm addressForm, final BindingResult bindingResult, final Model model,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		getAddressValidator().validate(addressForm, bindingResult);
		if (StringUtils.isNotBlank(addressForm.getCountryIso()))
		{
			model.addAttribute(ATTR_REGIONS, getI18NFacade().getRegionsForCountryIso(addressForm.getCountryIso()));
			model.addAttribute(ATTR_COUNTRY, addressForm.getCountryIso());
		}
		model.addAttribute(ATTR_NO_ADDRESS, Boolean.valueOf(getCheckoutFlowFacade().hasNoDeliveryAddress()));

		if (bindingResult.hasErrors())
		{
			GlobalMessages.addErrorMessage(model, "address.error.formentry.invalid");
			storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
			return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
		}

		final AddressData newAddress = constructNewAddress(addressForm);
		newAddress.setId(addressForm.getAddressId());
		newAddress.setVisibleInAddressBook(
				addressForm.getSaveInAddressBook() == null ? true : addressForm.getSaveInAddressBook().booleanValue());
		newAddress.setDefaultAddress(getUserFacade().isAddressBookEmpty() || getUserFacade().getAddressBook().size() == 1
				|| Boolean.TRUE.equals(addressForm.getDefaultAddress()));

		// Verify the address data.
		final AddressVerificationResult<AddressVerificationDecision> verificationResult = getAddressVerificationFacade()
				.verifyAddressData(newAddress);
		final boolean addressRequiresReview = getAddressVerificationResultHandler().handleResult(verificationResult, newAddress,
				model, redirectModel, bindingResult, getAddressVerificationFacade().isCustomerAllowedToIgnoreAddressSuggestions(),
				"checkout.multi.address.updated");

		if (addressRequiresReview)
		{
			setAttributesForAddressReview(addressForm, model);
			return ControllerConstants.Views.Pages.MultiStepCheckout.AddEditDeliveryAddressPage;
		}

		getUserFacade().editAddress(newAddress);
		getCheckoutFacade().setDeliveryModeIfAvailable();
		getCheckoutFacade().setDeliveryAddress(newAddress);

		return getCheckoutStep().nextStep();
	}

	protected void setAttributesForAddressReview(final AddressForm addressForm, final Model model) throws CMSItemNotFoundException
	{
		if (StringUtils.isNotBlank(addressForm.getCountryIso()))
		{
			model.addAttribute(ATTR_REGIONS, getI18NFacade().getRegionsForCountryIso(addressForm.getCountryIso()));
			model.addAttribute(ATTR_COUNTRY, addressForm.getCountryIso());
		}
		storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));

		if (StringUtils.isNotEmpty(addressForm.getAddressId()))
		{
			final AddressData addressData = getCheckoutFacade().getDeliveryAddressForCode(addressForm.getAddressId());
			if (addressData != null)
			{
				model.addAttribute(ATTR_SHOW_SAVE_TO_ADDRESS_BOOK, Boolean.valueOf(!addressData.isVisibleInAddressBook()));
				model.addAttribute("edit", Boolean.TRUE);
			}
		}
	}

	/**
	 * Delete resource.
	 *
	 * @param addressCode
	 * @param redirectModel
	 * @param model
	 * @return
	 * @throws CMSItemNotFoundException
	 */
	@RequestMapping(value = "/remove", method =
	{ RequestMethod.GET, RequestMethod.POST })
	@RequireHardLogIn
	public String removeAddress(@RequestParam("addressCode") final String addressCode, final RedirectAttributes redirectModel,
			final Model model) throws CMSItemNotFoundException
	{
		final AddressData addressData = new AddressData();
		addressData.setId(addressCode);
		getUserFacade().removeAddress(addressData);
		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER, "account.confirmation.address.removed");
		storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		model.addAttribute(ATTR_ADDRESS_FORM, new AddressForm());

		return getCheckoutStep().currentStep();
	}

	/**
	 * Select address from list.
	 *
	 * @param addressForm
	 * @param redirectModel
	 * @return
	 */

	@RequestMapping(value = "/select", method = RequestMethod.POST)
	@RequireHardLogIn
	public String doSelectSuggestedAddress(final AddressForm addressForm, final RedirectAttributes redirectModel)
	{
		final Set<String> resolveCountryRegions = org.springframework.util.StringUtils
				.commaDelimitedListToSet(Config.getParameter("resolve.country.regions"));

		final AddressData selectedAddress = new AddressData();
		selectedAddress.setId(addressForm.getAddressId());
		selectedAddress.setTitleCode(addressForm.getTitleCode());
		selectedAddress.setFirstName(addressForm.getFirstName());
		selectedAddress.setLastName(addressForm.getLastName());
		selectedAddress.setLine1(addressForm.getLine1());
		selectedAddress.setLine2(addressForm.getLine2());
		selectedAddress.setTown(addressForm.getTownCity());
		selectedAddress.setPostalCode(addressForm.getPostcode());
		selectedAddress.setBillingAddress(false);
		selectedAddress.setShippingAddress(true);
		final CountryData countryData = getI18NFacade().getCountryForIsocode(addressForm.getCountryIso());
		selectedAddress.setCountry(countryData);

		if (resolveCountryRegions.contains(countryData.getIsocode()) && addressForm.getRegionIso() != null
				&& !StringUtils.isEmpty(addressForm.getRegionIso()))
		{
			final RegionData regionData = getI18NFacade().getRegion(addressForm.getCountryIso(), addressForm.getRegionIso());
			selectedAddress.setRegion(regionData);
		}

		if (addressForm.getSaveInAddressBook() != null)
		{
			selectedAddress.setVisibleInAddressBook(addressForm.getSaveInAddressBook().booleanValue());
		}

		if (Boolean.TRUE.equals(addressForm.getEditAddress()))
		{
			getUserFacade().editAddress(selectedAddress);
		}
		else
		{
			getUserFacade().addAddress(selectedAddress);
		}

		final AddressData previousSelectedAddress = getCheckoutFacade().getCheckoutCart().getDeliveryAddress();
		// Set the new address as the selected checkout delivery address
		getCheckoutFacade().setDeliveryAddress(selectedAddress);
		if (previousSelectedAddress != null && !previousSelectedAddress.isVisibleInAddressBook())
		{ // temporary address should be removed
			getUserFacade().removeAddress(previousSelectedAddress);
		}

		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER, "checkout.multi.address.added");

		return getCheckoutStep().nextStep();
	}


	/**
	 * This method gets called when the "Use this Address" button is clicked. It sets the selected delivery address on
	 * the checkout facade - if it has changed, and reloads the page highlighting the selected delivery address.
	 *
	 * @param selectedAddressCode
	 *           - the id of the delivery address.
	 *
	 * @return - a URL to the page to load.
	 */
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@RequireHardLogIn
	public String doSelectDeliveryAddress(@RequestParam("selectedAddressCode") final String selectedAddressCode,
			final RedirectAttributes redirectAttributes)
	{
		final ValidationResults validationResults = getCheckoutStep().validate(redirectAttributes);
		if (getCheckoutStep().checkIfValidationErrors(validationResults))
		{
			return getCheckoutStep().onValidation(validationResults);
		}
		if (StringUtils.isNotBlank(selectedAddressCode))
		{
			cleanupTempAddress(selectedAddressCode);
		}
		return getCheckoutStep().nextStep();
	}

	protected void cleanupTempAddress(final String selectedAddressCode)
	{
		final AddressData selectedAddressData = getCheckoutFacade().getDeliveryAddressForCode(selectedAddressCode);
		if (selectedAddressData != null)
		{
			final AddressData cartCheckoutDeliveryAddress = getCheckoutFacade().getCheckoutCart().getDeliveryAddress();
			if (isAddressIdChanged(cartCheckoutDeliveryAddress, selectedAddressData))
			{
				getCheckoutFacade().setDeliveryAddress(selectedAddressData);
				if (cartCheckoutDeliveryAddress != null && !cartCheckoutDeliveryAddress.isVisibleInAddressBook())
				{ // temporary address should be removed
					getUserFacade().removeAddress(cartCheckoutDeliveryAddress);
				}
			}
		}
	}

	@RequestMapping(value = "/back", method = RequestMethod.GET)
	@RequireHardLogIn
	@Override
	public String back(final RedirectAttributes redirectAttributes)
	{
		return getCheckoutStep().previousStep();
	}

	@RequestMapping(value = "/next", method = RequestMethod.GET)
	@RequireHardLogIn
	@Override
	public String next(final RedirectAttributes redirectAttributes)
	{
		return getCheckoutStep().nextStep();
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}


	protected CheckoutStep getCheckoutStep()
	{
		return getCheckoutStep(DELIVERY_ADDRESS);
	}

	protected TmaOrderEntryFacade getTmaOrderEntryFacade()
	{
		return tmaOrderEntryFacade;
	}
}
