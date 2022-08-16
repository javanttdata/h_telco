/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.misc;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.AbstractController;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcofacades.data.TmaOfferData;
import de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionBaseData;
import de.hybris.platform.b2ctelcofacades.product.TmaProductOfferFacade;
import de.hybris.platform.b2ctelcofacades.user.TmaCustomerFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.b2ctelcoservices.model.TmaFixedBundledProductOfferingModel;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * Controller for product offers listed on product details page.
 *
 * @since 6.7
 */
@Controller("OffersController")
@RequestMapping(value = "/offers")
public class OfferListingController extends AbstractController
{
	private static final String PRODUCT = "product";
	private static final String OFFERS = "offers";
	private static final String SUBSCRIPTION_INFO = "subscriptionInfo";

	@Resource(name = "tmaProductOfferFacade")
	private TmaProductOfferFacade tmaProductOfferFacade;

	@Resource(name = "customerFacade")
	private TmaCustomerFacade customerFacade;

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationService;

	/**
	 * @param processType
	 *           type of the process (RETENTION, TARIFF_CHANGE, etc.)
	 * @param affectedProductCode
	 *           code of current product from product details page
	 * @param bpoCode
	 *           bpo from CPI subscription
	 * @param subscriberIdentities
	 *           subscription identities
	 * @param model
	 *           page model
	 * @return retention offer panel
	 */
	@RequestMapping(value = "/{processType}/{affectedProductCode}", method = RequestMethod.GET)
	public String getOffers(@PathVariable final String processType, @PathVariable final String affectedProductCode,
			@RequestParam(required = false) final String bpoCode, @RequestParam(required = false) final String subscriberIdentities,
			final Model model)
	{
		addProductToModel(affectedProductCode, model);
		final List<TmaSubscriptionBaseData> selectedSubscriptions = getCustomerFacade()
				.getSubscriptionBasesFromString(subscriberIdentities);

		if (!canDisplayOffers(bpoCode, affectedProductCode, selectedSubscriptions, processType))
		{
			model.addAttribute(OFFERS, new ArrayList<>());
			return TelcoControllerConstants.Views.Fragments.Product.OFFER_LISTING_PANEL;
		}

		final TmaSubscriptionBaseData selectedSubscriptionBaseData = selectedSubscriptions.iterator().next();
		model.addAttribute(SUBSCRIPTION_INFO, selectedSubscriptionBaseData);
		final Set<String> requiredProductCodes = getCustomerFacade()
				.getMainTariffProductCodesForSubscriptionBases(selectedSubscriptions);

		if (requiredProductCodes.isEmpty())
		{
			model.addAttribute(OFFERS, new ArrayList<>());
			return TelcoControllerConstants.Views.Fragments.Product.OFFER_LISTING_PANEL;
		}

		final List<TmaOfferData> offers = obtainOffersForProvidedData(processType, affectedProductCode, bpoCode,
				requiredProductCodes);
		model.addAttribute(OFFERS, offers);
		return TelcoControllerConstants.Views.Fragments.Product.OFFER_LISTING_PANEL;
	}

	private void addProductToModel(final String affectedProductCode, final Model model)
	{
		final ProductData affectedProductData = getTmaProductOfferFacade()
				.getPoForCode(affectedProductCode, Arrays.asList(ProductOption.SUMMARY, ProductOption.STOCK, ProductOption.PRICE));
		model.addAttribute(PRODUCT, affectedProductData);
	}

	private boolean canDisplayOffers(final String bpoCode, final String affectedProductCode,
			final List<TmaSubscriptionBaseData> subscriptions, final String processType)
	{
		return isValidBpo(bpoCode, affectedProductCode) && areSubscriptionsEligibleForProcess(subscriptions, processType);
	}

	private boolean isValidBpo(final String bpoCode, final String affectedProductCode)
	{
		return StringUtils.isNotEmpty(bpoCode) && getTmaProductOfferFacade().isValidParent(affectedProductCode, bpoCode);
	}

	private boolean areSubscriptionsEligibleForProcess(final List<TmaSubscriptionBaseData> subscriptionDatas,
			final String processType)
	{
		final Set<TmaSubscriptionBaseData> eligibleSubscriptions = getCustomerFacade()
				.retrieveEligibleSubscriptions(TmaProcessType.valueOf(processType));

		return subscriptionDatas.stream()
				.allMatch(subscriptionData -> isSubscriptionEligible(subscriptionData, eligibleSubscriptions));
	}

	private boolean isSubscriptionEligible(final TmaSubscriptionBaseData subscriptionBaseData,
			final Set<TmaSubscriptionBaseData> eligibleSubscriptions)
	{
		Optional<TmaSubscriptionBaseData> subscription = eligibleSubscriptions.stream().filter(eligibleSubscription ->
				eligibleSubscription.getSubscriberIdentity().equals(subscriptionBaseData.getSubscriberIdentity())
						&& eligibleSubscription.getBillingSystemId().equals(subscriptionBaseData.getBillingSystemId())).findFirst();
		return subscription.isPresent();
	}

	private List<TmaOfferData> obtainOffersForProvidedData(final String processType, final String affectedProductCode,
			final String bpoCode, final Set<String> requiredProductCodes)
	{
		final List<TmaOfferData> offerings = getTmaProductOfferFacade().getOffers(processType, affectedProductCode, bpoCode,
				requiredProductCodes);

		final List<TmaOfferData> offers = offerings.stream()
				.filter(offer -> !offer.getProduct().getItemType().equals(TmaFixedBundledProductOfferingModel._TYPECODE)).collect(
						Collectors.toList());

		if (offers.isEmpty()) {
			return offers;
		}

		// reorganize POPs as flat structure for offers
		for (TmaOfferData offer : offers)
		{
			ProductData offerPo = offer.getProduct();
			if (offer.getProduct() == null) {
				continue;
			}

			getTmaPriceOrganizationService().organizePopsForProduct(offerPo);
		}

		return offers;
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaProductOfferFacade getTmaProductOfferFacade()
	{
		return tmaProductOfferFacade;
	}

	protected TmaCustomerFacade getCustomerFacade()
	{
		return customerFacade;
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaPriceOrganizationService getTmaPriceOrganizationService()
	{
		return tmaPriceOrganizationService;
	}
}
