/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.checkout.steps;

import de.hybris.platform.acceleratorstorefrontcommons.annotations.PreValidateCheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.CheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.b2ctelcoaddon.controllers.ControllerConstants;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.cms2.model.pages.ContentPageModel;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import static de.hybris.platform.b2ctelcoaddon.controllers.pages.CartPageController.CART_CHECKOUT_ERROR;


/**
 * MultiStepCheckoutController.
 */
@Controller
@RequestMapping(value = "/checkout/multi")
public class MultiStepCheckoutController extends AbstractCheckoutStepController
{
	private static final String MULTI = "multi";

	@Override
	@RequestMapping(method = RequestMethod.GET)
	@PreValidateCheckoutStep(checkoutStep = MULTI)
	public String enterStep(final Model model, final RedirectAttributes redirectAttributes)
			throws CMSItemNotFoundException, CommerceCartModificationException
	{
		if (validateCart(redirectAttributes))
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.ERROR_MESSAGES_HOLDER, CART_CHECKOUT_ERROR, null);
			return REDIRECT_PREFIX + "/cart";
		}

		return getCheckoutStep().nextStep();
	}


	@RequestMapping(value = "/termsAndConditions")
	@RequireHardLogIn
	public String getTermsAndConditions(final Model model) throws CMSItemNotFoundException
	{
		final ContentPageModel pageForRequest = getCmsPageService().getPageForLabel("/termsAndConditions");
		storeCmsPageInModel(model, pageForRequest);
		setUpMetaDataForContentPage(model, pageForRequest);
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, getContentPageBreadcrumbBuilder().getBreadcrumbs(pageForRequest));
		return ControllerConstants.Views.Fragments.Checkout.TermsAndConditionsPopup;
	}

	/**
	 * Express checkout.
	 *
	 * @param model
	 * @param redirectModel
	 * @return
	 * @throws CMSItemNotFoundException
	 * @throws CommerceCartModificationException
	 */
	@RequestMapping(value = "/express", method = RequestMethod.GET)
	@RequireHardLogIn
	public String performExpressCheckout(final Model model, final RedirectAttributes redirectModel)
			throws CMSItemNotFoundException, CommerceCartModificationException
	{
		if (getCheckoutFlowFacade().hasValidCart())
		{
			switch (getCheckoutFacade().performExpressCheckout())
			{
				case SUCCESS:
					return REDIRECT_URL_SUMMARY;

				case ERROR_DELIVERY_ADDRESS:
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
							"checkout.express.error.deliveryAddress");
					return REDIRECT_URL_ADD_DELIVERY_ADDRESS;

				case ERROR_DELIVERY_MODE:
				case ERROR_CHEAPEST_DELIVERY_MODE:
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
							"checkout.express.error.deliveryMode");
					return REDIRECT_URL_CHOOSE_DELIVERY_METHOD;

				case ERROR_PAYMENT_INFO:
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
							"checkout.express.error.paymentInfo");
					return REDIRECT_URL_ADD_PAYMENT_METHOD;

				default:
					GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.ERROR_MESSAGES_HOLDER,
							"checkout.express.error.notAvailable");
			}
		}
		return enterStep(model, redirectModel);
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

	protected CheckoutStep getCheckoutStep()
	{
		return getCheckoutStep(MULTI);
	}

}
