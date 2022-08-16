/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers;

/**
 * Controller constants.
 */
public interface ControllerConstants
{
	String ADDON_PREFIX = "addon:/b2ctelcoaddon/";

	/**
	 * Class with view name constants.
	 */
	interface Views
	{

		interface Pages
		{

			interface MultiStepCheckout
			{
				String AddEditDeliveryAddressPage = ADDON_PREFIX + "pages/checkout/multi/addEditDeliveryAddressPage";
				String ChooseDeliveryMethodPage = ADDON_PREFIX + "pages/checkout/multi/chooseDeliveryMethodPage";
				String ChoosePickupLocationPage = ADDON_PREFIX + "pages/checkout/multi/choosePickupLocationPage";
				String CheckoutSummaryPage = ADDON_PREFIX + "pages/checkout/multi/checkoutSummaryPage";
				String HostedOrderPageErrorPage = ADDON_PREFIX + "pages/checkout/multi/hostedOrderPageErrorPage";
				String HostedOrderPostPage = ADDON_PREFIX + "pages/checkout/multi/hostedOrderPostPage";
				String SilentOrderPostPage = ADDON_PREFIX + "pages/checkout/multi/silentOrderPostPage";
			}

			interface Checkout // NOSONAR
			{
				String CheckoutConfirmationPage = "pages/checkout/checkoutConfirmationPage"; // NOSONAR
			}
		}

		interface Fragments
		{

			interface Checkout
			{
				String TermsAndConditionsPopup = ADDON_PREFIX + "fragments/checkout/termsAndConditionsPopup";
				String BillingAddressForm = ADDON_PREFIX + "fragments/checkout/billingAddressForm";
			}

		}
	}
}
