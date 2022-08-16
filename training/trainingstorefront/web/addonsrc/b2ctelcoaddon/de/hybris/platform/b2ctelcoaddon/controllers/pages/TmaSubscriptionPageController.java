/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.Breadcrumb;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.ResourceBreadcrumbBuilder;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonWebConstants;
import de.hybris.platform.b2ctelcofacades.data.TmaAverageServiceUsageData;
import de.hybris.platform.b2ctelcofacades.data.TmaSubscribedProductData;
import de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionAccessData;
import de.hybris.platform.b2ctelcofacades.order.TmaCartFacade;
import de.hybris.platform.b2ctelcofacades.product.TmaProductOfferFacade;
import de.hybris.platform.b2ctelcofacades.subscription.TmaSubscribedProductFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.order.CartFacade;
import de.hybris.platform.commercefacades.order.data.CCPaymentInfoData;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.CartModificationData;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.user.UserFacade;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;
import de.hybris.platform.servicelayer.exceptions.ModelNotFoundException;
import de.hybris.platform.servicelayer.exceptions.UnknownIdentifierException;
import de.hybris.platform.subscriptionfacades.data.SubscriptionBillingData;
import de.hybris.platform.subscriptionfacades.data.SubscriptionData;
import de.hybris.platform.subscriptionfacades.exceptions.SubscriptionFacadeException;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Nonnull;
import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



/**
 * Controller for home page.
 */
@Controller
@RequestMapping("/my-account/subscription")
public class TmaSubscriptionPageController extends AbstractSearchPageController
{

	// Internal Redirects
	private static final String REDIRECT_MY_ACCOUNT = REDIRECT_PREFIX + "/my-account";
	private static final String REDIRECT_URL_CART = REDIRECT_PREFIX + "/cart";
	private static final String REDIRECT_MY_ACCOUNT_SUBSCRIPTION = REDIRECT_PREFIX + "/my-account/subscription/";
	private static final String REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE = REDIRECT_PREFIX + "/my-account/subscription/%s/manage";

	// CMS Pages
	private static final String SUBSCRIPTIONS_CMS_PAGE = "subscriptions";
	private static final String SUBSCRIPTION_COMPARISON_CMS_PAGE = "subscriptionComparison";
	private static final String SUBSCRIPTIONS_BASE_CMS_PAGE = "subscriptionBase";
	private static final String SUBSCRIPTION_BILLING_ACTIVITY_CMS_PAGE = "subscriptionBillingActivity";
	private static final String SUBSCRIPTION_DETAILS_CMS_PAGE = "subscription";

	private static final String MY_ACCOUNT_SUBSCRIPTION_URL = "/my-account/subscription";

	/**
	 * We use this suffix pattern because of an issue with Spring 3.1 where a Uri value is incorrectly extracted if it
	 * contains on or more '.' characters. Please see https://jira.springsource.org/browse/SPR-6164 for a discussion on
	 * the issue and future resolution.
	 */
	private static final String SUBSCRIPTION_ID_PATH_VARIABLE_PATTERN = "{subscriptionId:.*}";


	private static final Logger LOG = Logger.getLogger(TmaSubscriptionPageController.class);

	@Resource(name = "userFacade")
	protected UserFacade userFacade;

	@Resource(name = "accountBreadcrumbBuilder")
	private ResourceBreadcrumbBuilder accountBreadcrumbBuilder;

	@Resource(name = "cartFacade")
	private CartFacade cartFacade;

	@Resource(name = "tmaSubscribedProductFacade")
	private TmaSubscribedProductFacade tmaSubscribedProductFacade;

	@Resource(name = "tmaProductOfferFacade")
	private TmaProductOfferFacade tmaProductOfferFacade;

	@Resource(name = "cartFacade")
	private TmaCartFacade tmaCartFacade;

	/**
	 * subscriptions is get method.It finds available subscriptions, paymentInfoMap, Breadcrum for loggedin user.
	 *
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	@RequireHardLogIn
	public String subscriptions(@Nonnull final Model model) throws CMSItemNotFoundException
	{
		final Map<String, CCPaymentInfoData> paymentInfoMap = new HashMap<>();
		try
		{
			final Map<TmaSubscriptionAccessData, Set<TmaSubscribedProductData>> subscriptionInfoMap = tmaSubscribedProductFacade
					.getSubscriptions();
			//get Upgrade option

			if (MapUtils.isNotEmpty(subscriptionInfoMap))
			{
				model.addAttribute(B2ctelcoaddonWebConstants.SUBINFOMAP, subscriptionInfoMap);
			}
		}
		catch (final SubscriptionFacadeException subscriptionFacadeException)
		{
			LOG.error("Error while retrieving subscriptions", subscriptionFacadeException);
		}
		final List<CCPaymentInfoData> paymentInfoData = userFacade.getCCPaymentInfos(true);
		paymentInfoData.forEach(paymentInfo -> paymentInfoMap.put(paymentInfo.getSubscriptionId(), paymentInfo));

		storeCmsPageInModel(model, getContentPageForLabelOrId(SUBSCRIPTIONS_CMS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(SUBSCRIPTIONS_CMS_PAGE));
		model.addAttribute(B2ctelcoaddonWebConstants.PAYMENTINFOMAP, paymentInfoMap);
		model.addAttribute(B2ctelcoaddonWebConstants.BREADCRUMBS_KEY,
				accountBreadcrumbBuilder.getBreadcrumbs(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION));
		model.addAttribute(B2ctelcoaddonWebConstants.METAROBOTS, B2ctelcoaddonWebConstants.NOINDEX_NOFOLLOW);
		return getViewForPage(model);
	}

	/**
	 * Get method finds available subscription details for loggedin user for manage subscription Page.
	 *
	 * @param subscriptionId
	 *           Subscription ID
	 * @param actionVal
	 *           manage or details
	 * @return
	 */
	@RequestMapping(value = "/{subscriptionId:.*}/{actionVal}", method = RequestMethod.GET)
	@RequireHardLogIn
	public String subscription(@PathVariable("subscriptionId") final String subscriptionId,
			@PathVariable("actionVal") final String actionVal, final Model model) throws CMSItemNotFoundException
	{
		try
		{
			final TmaSubscribedProductData subscriptionDetails = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			ProductData subscriptionProductData = getTmaProductOfferFacade().getPoForCode(subscriptionDetails.getProductCode(),
					Arrays.asList(ProductOption.BASIC, ProductOption.PRICE));
			subscriptionProductData = tmaSubscribedProductFacade.getSubscriptionTermAndPrice(subscriptionProductData);

			final List<ProductData> upgradeOptions = tmaSubscribedProductFacade
					.getUpsellingOptionsForSubscription(subscriptionDetails.getProductCode());
			final List<ProductData> upsellingOptions = new ArrayList();
			upgradeOptions.forEach(upsellingOption -> {
				tmaSubscribedProductFacade.getSubscriptionTermAndPrice(upsellingOption);
				upsellingOptions.add(upsellingOption);
			});

			final List<Breadcrumb> breadcrumbs = buildSubscriptionDetailBreadcrumb(subscriptionDetails);
			final Map<String, String> extensionOptions = extensionOptionsSelect(subscriptionDetails);

			model.addAttribute(B2ctelcoaddonWebConstants.ACTION_VAL, actionVal);
			model.addAttribute(B2ctelcoaddonWebConstants.EXTENSION_OPTIONS, extensionOptions);
			model.addAttribute(B2ctelcoaddonWebConstants.BREADCRUMBS_KEY, breadcrumbs);
			model.addAttribute(B2ctelcoaddonWebConstants.PAYMENTINFOS, userFacade.getCCPaymentInfos(true));
			model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_DATA, subscriptionDetails);
			model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_PRODUCT_DATA, subscriptionProductData);
			model.addAttribute(B2ctelcoaddonWebConstants.UPGRADABLE, CollectionUtils.isNotEmpty(upsellingOptions));

		}
		catch (final UnknownIdentifierException | ModelNotFoundException e)
		{
			LOG.warn("Attempted to load a subscription that does not exist or is not visible", e);
			return REDIRECT_MY_ACCOUNT;
		}

		storeCmsPageInModel(model, getContentPageForLabelOrId(SUBSCRIPTION_DETAILS_CMS_PAGE));
		model.addAttribute(B2ctelcoaddonWebConstants.METAROBOTS, B2ctelcoaddonWebConstants.NOINDEX_NOFOLLOW);
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(SUBSCRIPTION_DETAILS_CMS_PAGE));
		return getViewForPage(model);
	}

	/**
	 * Get method finds available subscription-base details for loggedin user for show related service details.
	 *
	 * @param billingSystemId
	 *           ID of billing system
	 * @param subscriberIdentity
	 *           ID of TmaSubscriptionBase
	 * @return
	 */
	@RequestMapping(value = "/subscription-base/{billingSystemId}/{subscriberIdentity}", method = RequestMethod.GET)
	@RequireHardLogIn
	public String subscriptionBaseServices(
			@Nonnull @PathVariable(value = "billingSystemId", required = true) final String billingSystemId,
			@Nonnull @PathVariable(value = "subscriberIdentity", required = true) final String subscriberIdentity,
			@Nonnull final Model model) throws CMSItemNotFoundException
	{
		Map<TmaSubscribedProductData, Set<TmaAverageServiceUsageData>> subscriptionBaseServicesWithValueMap = new HashMap<>();
		ProductData productData = null;
		try
		{
			final String accessType = tmaSubscribedProductFacade.getSubscriptionAccessByPrincipalAndSubscriptionBase(billingSystemId,
					subscriberIdentity);
			subscriptionBaseServicesWithValueMap = tmaSubscribedProductFacade
					.getSubscriptionBaseServicesWithAvgValues(subscriberIdentity, billingSystemId);
				productData = tmaSubscribedProductFacade.upsellSubscriptionProductData(subscriberIdentity, billingSystemId);
		}
		catch (final SubscriptionFacadeException e)
		{
			LOG.error("Error while retrieving subscriptionBases", e);
		}

		storeCmsPageInModel(model, getContentPageForLabelOrId(SUBSCRIPTIONS_BASE_CMS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(SUBSCRIPTIONS_BASE_CMS_PAGE));
		model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_FACADE, tmaSubscribedProductFacade);
		model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIBER_IDENTITY, subscriberIdentity);
		model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTIONBASE_SERVICES_VALUE_MAP, subscriptionBaseServicesWithValueMap);
		model.addAttribute(B2ctelcoaddonWebConstants.PRODUCT_DATA, productData);
		final List<Breadcrumb> breadcrumbs = accountBreadcrumbBuilder.getBreadcrumbs(null);
		breadcrumbs.add(new Breadcrumb(MY_ACCOUNT_SUBSCRIPTION_URL, getMessageSource()
				.getMessage(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION, null, getI18nService().getCurrentLocale()), null));
		breadcrumbs.add(new Breadcrumb("#",
				getMessageSource().getMessage(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_SUBSCRIPTIONBASE, null,
						getI18nService().getCurrentLocale()) + " " + subscriberIdentity,
				null));
		model.addAttribute(B2ctelcoaddonWebConstants.BREADCRUMBS_KEY, breadcrumbs);

		model.addAttribute(B2ctelcoaddonWebConstants.METAROBOTS, B2ctelcoaddonWebConstants.NOINDEX_NOFOLLOW);
		return getViewForPage(model);
	}


	/**
	 * This Post method responsible for extending TMAservice's Term for duration.
	 *
	 * @param contractDurationExtension
	 *           Integer value for which contract need to be extended
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @return
	 */
	@RequestMapping(value = "/extend-term-duration", method = RequestMethod.POST)
	public String extendSubscriptionTermDuration(
			@RequestParam(value = "contractDurationExtension", required = true) final Integer contractDurationExtension,
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId,
			final RedirectAttributes redirectAttributes)
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			final Integer newContractDuration = subscribedProductData.getContractDuration() + contractDurationExtension;
			final String contractFrequency = subscribedProductData.getContractFrequency();
			final Date startDate = subscribedProductData.getStartDate();
			final Date subscriptionServiceEndDate = tmaSubscribedProductFacade.getSubscriptionServiceEndDate(contractFrequency,
					newContractDuration, startDate);
			subscribedProductData.setContractDuration(newContractDuration);
			subscribedProductData.setEndDate(subscriptionServiceEndDate);
			tmaSubscribedProductFacade.updateSubscribedProduct(subscribedProductData.getBillingsystemId(),
					subscribedProductData.getBillingSubscriptionId(), subscribedProductData);
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.CONF_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM_SUCCESS);
		}
		catch (final ModelNotFoundException e)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM_UNABLE);
			LOG.error(String.format("Unable to extend term duration by '%s' for subscription '%s'", contractDurationExtension,
					YSanitizer.sanitize(subscriptionId)), e);
		}
		return String.format(REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE, XSSFilterUtil.filter(subscriptionId));
	}


	/**
	 * This Get method responsible for loading upgrading option for subsription.
	 *
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @return
	 */

	@RequestMapping(value = "/upgrades-comparison", method = RequestMethod.GET)
	public String upgradeSubscriptionComparison(@Nonnull @RequestParam(value = "subscriptionId") final String subscriptionId,
			@Nonnull final Model model) throws CMSItemNotFoundException
	{
		try
		{
			// initially leave upgradePreviewData empty because it's filled dynamically in method viewPotentialUpgradeBillingDetails
			final List<SubscriptionBillingData> upgradePreviewData = new ArrayList<>();
			model.addAttribute("upgradePreviewData", upgradePreviewData);

			final TmaSubscribedProductData subscriptionDetails = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			ProductData subscriptionProductData = getTmaProductOfferFacade().getPoForCode(subscriptionDetails.getProductCode(),
					Arrays.asList(ProductOption.BASIC, ProductOption.PRICE));
			subscriptionProductData = tmaSubscribedProductFacade.getSubscriptionTermAndPrice(subscriptionProductData);

			model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_PRODUCT_DATA, subscriptionProductData);

			final List<ProductData> upgradeOptions = tmaSubscribedProductFacade
					.getUpsellingOptionsForSubscription(subscriptionDetails.getProductCode());
			final List<ProductData> upsellingOptions = new ArrayList();
			upgradeOptions.forEach(upsellingOption -> {
				tmaSubscribedProductFacade.getSubscriptionTermAndPrice(upsellingOption);
				upsellingOptions.add(upsellingOption);
			});

			model.addAttribute(B2ctelcoaddonWebConstants.UPSELLING_OPTION, upsellingOptions);

			final List<Breadcrumb> breadcrumbs = buildSubscriptionDetailBreadcrumb(subscriptionDetails);
			model.addAttribute(B2ctelcoaddonWebConstants.BREADCRUMBS_KEY, breadcrumbs);

			model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_DATA, subscriptionDetails);

			final CartData cartData = cartFacade.getSessionCart();
			model.addAttribute(B2ctelcoaddonWebConstants.CART_DATA, cartData);
		}
		catch (final UnknownIdentifierException e)
		{
			LOG.warn("Attempted to load a subscription that does not exist or is not visible", e);
			return REDIRECT_MY_ACCOUNT;
		}
		storeCmsPageInModel(model, getContentPageForLabelOrId(SUBSCRIPTION_COMPARISON_CMS_PAGE));
		model.addAttribute(B2ctelcoaddonWebConstants.METAROBOTS, B2ctelcoaddonWebConstants.NOINDEX_NOFOLLOW);
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(SUBSCRIPTION_COMPARISON_CMS_PAGE));
		return getViewForPage(model);
	}

	/**
	 * This Post method responsible for upgrading subscription.
	 *
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @param originalOrderCode
	 * @param originalEntryNumber
	 * @return
	 */
	@RequestMapping(value = "/upgrade", method = RequestMethod.POST)
	public String upgradesubscription(@RequestParam(value = "productCode", required = true) final String productCode,
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId, final Model model,
			@RequestParam(value = "qty", required = false, defaultValue = "1") final long qty,
			@RequestParam(value = "subscriberId", required = true) final String subscriberId,
			@RequestParam(value = "subscriberBillingId", required = true) final String subscriberBillingId,
			@RequestParam(value = "rootBpoCode", required = false) final String rootBpoCode,
			@RequestParam(value = "cartGroupNo", required = false, defaultValue = "-1") final int cartGroupNo,
			@RequestParam(value = "subscriptionTermId", required = true) final String subscriptionTermId)
	{
		CartModificationData cartModification;

		try
		{
			cartModification = tmaCartFacade.addProductOfferingToCart(productCode, qty, TmaProcessType.TARIFF_CHANGE.getCode(), rootBpoCode,
					cartGroupNo, subscriptionTermId, subscriberId, subscriberBillingId);
			model.addAttribute("modifiedCartData", Collections.singletonList(cartModification));

			if (cartModification.getQuantityAdded() == 0L)
			{
				GlobalMessages.addErrorMessage(model,
						B2ctelcoaddonWebConstants.TEXT_BASKET_INFO_QUANTITY_NOITEMADDED + cartModification.getStatusCode());
				model.addAttribute(B2ctelcoaddonWebConstants.ERROR_MSG,
						B2ctelcoaddonWebConstants.TEXT_BASKET_INFO_QUANTITY_NOITEMADDED + cartModification.getStatusCode());
			}
			else if (cartModification.getQuantityAdded() < 1)
			{
				GlobalMessages.addErrorMessage(model,
						B2ctelcoaddonWebConstants.TEXT_BASKET_INFO_QUANTITY_REDUCEDNUMITEMADDED + cartModification.getStatusCode());
				model.addAttribute(B2ctelcoaddonWebConstants.ERROR_MSG,
						B2ctelcoaddonWebConstants.TEXT_BASKET_INFO_QUANTITY_REDUCEDNUMITEMADDED + cartModification.getStatusCode());
			}

			final CartData cartData = cartFacade.getSessionCart();
			model.addAttribute("cartData", cartData);
		}
		catch (final CommerceCartModificationException e)
		{
			model.addAttribute(B2ctelcoaddonWebConstants.ERROR_MSG, "basket.error.occurred");
			GlobalMessages.addErrorMessage(model, "basket.information.quantity.noItemsAdded. " + e.getMessage());
			LOG.warn("Couldn't upgrade subscription '" + YSanitizer.sanitize(subscriptionId) + "' to product '" + YSanitizer.sanitize(productCode) + "'. AddToCart failed.",
					e);
		}

		return REDIRECT_URL_CART;
	}


	/**
	 * This Post method responsible for changing state of subscription.
	 *
	 * @param newState
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @return
	 */
	@RequestMapping(value = "/change-state", method = RequestMethod.POST)
	public String changeSubscriptionState(@RequestParam(value = "newState", required = true) final String newState,
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId,
			final RedirectAttributes redirectAttributes)
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			subscribedProductData.setSubscriptionStatus(newState);
			tmaSubscribedProductFacade.updateSubscribedProduct(subscribedProductData.getBillingsystemId(),
					subscribedProductData.getBillingSubscriptionId(), subscribedProductData);
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.CONF_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_CHANGESTATE_SUCCESS);
		}
		catch (final ModelNotFoundException e)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_CHANGESTATE_UNABLE);
			LOG.error(String.format("Unable to change state to '%s' for subscription '%s'", YSanitizer.sanitize(newState), YSanitizer.sanitize(subscriptionId)), e);
		}

		return String.format(REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE, XSSFilterUtil.filter(subscriptionId));
	}

	/**
	 * This Post method responsible for updating sAutorenewalStatus state of subscription.
	 *
	 * @param autorenew
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @return
	 */
	@RequestMapping(value = "/set-autorenewal-status", method = RequestMethod.POST)
	public String setAutorenewalStatus(@RequestParam(value = "autorenew", required = true) final boolean autorenew,
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId,
			final RedirectAttributes redirectAttributes)
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			subscribedProductData.setRenewalType(String.valueOf(autorenew));
			tmaSubscribedProductFacade.updateSubscribedProduct(subscribedProductData.getBillingsystemId(),
					subscribedProductData.getBillingSubscriptionId(), subscribedProductData);
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.CONF_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_CHANGEAUTORENEW_SUCCESS);
		}
		catch (final ModelNotFoundException e)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_CHANGEAUTORENEW_UNABLE);
			LOG.error(String.format("Unable to change auto-renew status to '%s' for subscription '%s'", String.valueOf(autorenew),
					YSanitizer.sanitize(subscriptionId)), e);
		}

		return String.format(REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE, XSSFilterUtil.filter(subscriptionId));
	}

	/**
	 * This Post method responsible for Canceling subscription.
	 *
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @return
	 */
	@RequestMapping(value = "/cancel/" + SUBSCRIPTION_ID_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String cancelsubscription(@PathVariable(value = "subscriptionId") final String subscriptionId,
			final RedirectAttributes redirectAttributes)
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			subscribedProductData.setCancelledDate(new Date());
			subscribedProductData.setSubscriptionStatus("CANCELLED");
			tmaSubscribedProductFacade.updateSubscribedProduct(subscribedProductData.getBillingsystemId(),
					subscribedProductData.getBillingSubscriptionId(), subscribedProductData);
		}
		catch (final ModelNotFoundException e)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_CANCEL_UNABLE);
			LOG.error("Unable to cancel subscription", e);
		}

		return String.format(REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE, XSSFilterUtil.filter(subscriptionId));
	}

	/**
	 * This get method show billing acitvity of user.
	 *
	 * @param subscriptionId
	 *           ID of TmaService
	 */
	@RequestMapping(value = "/billing-activity", method = RequestMethod.GET)
	public String viewSubscriptionBillingActivity(
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId, final Model model)
			throws CMSItemNotFoundException
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			model.addAttribute(B2ctelcoaddonWebConstants.SUBSCRIPTION_DATA, subscribedProductData);

			final List<Breadcrumb> breadcrumbs = buildSubscriptionDetailBreadcrumb(subscribedProductData);
			model.addAttribute(B2ctelcoaddonWebConstants.BREADCRUMBS_KEY, breadcrumbs);

			final List<SubscriptionBillingData> billingActivities = tmaSubscribedProductFacade
					.createBillingActivityData(subscriptionId);

			model.addAttribute("billingActivities", billingActivities);
		}
		catch (final SubscriptionFacadeException | ModelNotFoundException e)
		{
			LOG.warn("Viewing billing activities for subscriptions failed. Returning to subscription details page.", e);
			return REDIRECT_MY_ACCOUNT_SUBSCRIPTION + XSSFilterUtil.filter(subscriptionId);
		}

		storeCmsPageInModel(model, getContentPageForLabelOrId(SUBSCRIPTION_BILLING_ACTIVITY_CMS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(SUBSCRIPTION_BILLING_ACTIVITY_CMS_PAGE));
		model.addAttribute(B2ctelcoaddonWebConstants.METAROBOTS, B2ctelcoaddonWebConstants.NOINDEX_NOFOLLOW);
		return getViewForPage(model);
	}


	/**
	 * This Post method responsible for updating default payment of TMAservice.
	 *
	 * @param paymentMethodId
	 *           Sting value for service need to be updated
	 * @param subscriptionId
	 *           Id for subscription for with terms need to be extended
	 * @param effectiveFrom
	 *           Date from which it will be effective
	 * @return
	 */

	@RequestMapping(value = "/billing-activity/payment-method/replace", method = RequestMethod.POST)
	public String replaceSubscriptionPaymentMethod(
			@RequestParam(value = "paymentMethodId", required = true) final String paymentMethodId,
			@RequestParam(value = "subscriptionId", required = true) final String subscriptionId,
			@RequestParam(value = "effectiveFrom", required = true) final String effectiveFrom,
			final RedirectAttributes redirectAttributes)
	{
		try
		{
			final TmaSubscribedProductData subscribedProductData = tmaSubscribedProductFacade.getSubscriptionsById(subscriptionId);
			subscribedProductData.setPaymentMethodId(paymentMethodId);
			tmaSubscribedProductFacade.updateSubscribedProduct(subscribedProductData.getBillingsystemId(),
					subscribedProductData.getBillingSubscriptionId(), subscribedProductData);

			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.CONF_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_REPLACEPAYMNETMETHOD_SUCCESS);
		}
		catch (final ModelNotFoundException e)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER,
					B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_REPLACEPAYMNETMETHOD_UNABLE);
			LOG.error(String.format("Unable to replace payment method for subscription '%s'", YSanitizer.sanitize(subscriptionId)), e);
		}

		return String.format(REDIRECT_MY_ACCOUNT_SUBSCRIPTION_MANAGE, XSSFilterUtil.filter(subscriptionId));
	}

	private List<Breadcrumb> buildSubscriptionDetailBreadcrumb(final SubscriptionData subscriptionData)
	{
		final List<Breadcrumb> breadcrumbs = accountBreadcrumbBuilder
				.getBreadcrumbs(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION);
		breadcrumbs.get(breadcrumbs.size() - 1).setUrl(MY_ACCOUNT_SUBSCRIPTION_URL);
		breadcrumbs.add(new Breadcrumb("#",
				getMessageSource().getMessage(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_SUBSCRIPTIONBREADCRUM, new Object[]
				{ subscriptionData.getId() }, "Subscription {0}", getI18nService().getCurrentLocale()), null));
		return breadcrumbs;
	}

	private Map<String, String> extensionOptionsSelect(final SubscriptionData subscriptionDetails)
	{
		final Map<String, String> extensionOptions = new HashMap<>();
		for (int i = 1; i <= 3; i++)
		{
			final String counter = String.valueOf(i);
			final String message = getMessageSource().getMessage(B2ctelcoaddonWebConstants.TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM,
					new Object[]
					{ subscriptionDetails.getContractFrequency(), counter },
					B2ctelcoaddonWebConstants.ACCOUNT_SUBSCRIPTION_EXTENDTERM_DEFAULT_MSG, getI18nService().getCurrentLocale());

			extensionOptions.put(counter, message);
		}
		return extensionOptions;
	}

	protected TmaProductOfferFacade getTmaProductOfferFacade()
	{
		return tmaProductOfferFacade;
	}
}
