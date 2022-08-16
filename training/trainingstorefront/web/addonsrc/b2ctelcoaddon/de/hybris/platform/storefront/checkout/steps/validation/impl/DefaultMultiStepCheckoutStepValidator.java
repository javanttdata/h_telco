/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.storefront.checkout.steps.validation.impl;


import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.AbstractCheckoutStepValidator;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.commercefacades.order.data.CartData;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Default implementation of checkout validator.
 */
public class DefaultMultiStepCheckoutStepValidator extends AbstractCheckoutStepValidator
{
	private static final Logger LOG = LoggerFactory.getLogger(DefaultMultiStepCheckoutStepValidator.class); // NOSONAR

	@Override
	public ValidationResults validateOnEnter(final RedirectAttributes redirectAttributes)
	{
		final CartData cartData = getCheckoutFacade().getCheckoutCart();
		if (cartData.getEntries() != null && !cartData.getEntries().isEmpty())
		{
			return getCheckoutFacade().hasShippingItems() ? ValidationResults.SUCCESS
					: ValidationResults.REDIRECT_TO_PICKUP_LOCATION;
		}
		LOG.info("Missing, empty or unsupported cart");
		return ValidationResults.FAILED;
	}
}
