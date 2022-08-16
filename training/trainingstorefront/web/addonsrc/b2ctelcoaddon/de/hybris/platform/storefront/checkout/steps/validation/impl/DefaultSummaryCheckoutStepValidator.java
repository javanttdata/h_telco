/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.storefront.checkout.steps.validation.impl;

import de.hybris.platform.acceleratorfacades.flow.CheckoutFlowFacade;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.AbstractCheckoutStepValidator;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.commercefacades.order.data.CartData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Default implementation of checkout summary validator.
 */
public class DefaultSummaryCheckoutStepValidator extends AbstractCheckoutStepValidator
{
	private static final Logger LOG = LoggerFactory.getLogger(DefaultSummaryCheckoutStepValidator.class); // NOSONAR

	@Override
	public ValidationResults validateOnEnter(final RedirectAttributes redirectAttributes)
	{
		final ValidationResults checkoutFlow = validateCheckoutFlow(redirectAttributes);
		if (checkoutFlow != null)
		{
			return checkoutFlow;
		}

		final CartData cartData = getCheckoutFacade().getCheckoutCart();

		if (!getCheckoutFacade().hasShippingItems())
		{
			cartData.setDeliveryAddress(null);
		}

		if (!getCheckoutFacade().hasPickUpItems() && "pickup".equals(cartData.getDeliveryMode().getCode()))
		{
			return ValidationResults.REDIRECT_TO_PICKUP_LOCATION;
		}

		return ValidationResults.SUCCESS;
	}

	protected ValidationResults validateCheckoutFlow(final RedirectAttributes redirectAttributes)
	{
		final CheckoutFlowFacade checkoutFlowFacade = getCheckoutFlowFacade();
		if (!checkoutFlowFacade.hasValidCart())
		{
			LOG.info("Missing, empty or unsupported cart");
			return ValidationResults.REDIRECT_TO_CART;
		}

		if (checkoutFlowFacade.hasNoDeliveryAddress())
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.deliveryAddress.notprovided");
			return ValidationResults.REDIRECT_TO_DELIVERY_ADDRESS;
		}

		if (checkoutFlowFacade.hasNoDeliveryMode())
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.deliveryMethod.notprovided");
			return ValidationResults.REDIRECT_TO_DELIVERY_METHOD;
		}

		if (checkoutFlowFacade.hasNoPaymentInfo())
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.paymentDetails.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_METHOD;
		}
		return null;
	}
}
