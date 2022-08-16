/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.checkout.steps;

import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Checkout wizard controller interface.
 */
public interface CheckoutStepController
{
	/**
	 * Swapping the parameter order might break the validation aspect from working.
	 * 
	 * @param model
	 * @param redirectAttributes
	 * @return returns the result for entering the checkout step
	 * @throws CMSItemNotFoundException
	 * @throws CommerceCartModificationException
	 */
	String enterStep(final Model model, final RedirectAttributes redirectAttributes)
			throws CMSItemNotFoundException, CommerceCartModificationException;

	/**
	 *
	 * @param redirectAttributes
	 * @return checkoutstep link for navigating back
	 */
	String back(final RedirectAttributes redirectAttributes);

	/**
	 *
	 * @param redirectAttributes
	 * @return checkoutstep link for navigating next
	 */
	String next(final RedirectAttributes redirectAttributes);
}
