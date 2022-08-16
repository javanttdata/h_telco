/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.processtype;

import static de.hybris.platform.b2ctelcoservices.constants.B2ctelcoservicesConstants.SELECTED_PROCESS_TYPE;

import de.hybris.platform.acceleratorservices.urlresolver.SiteBaseUrlResolutionService;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.forms.TmaProcessTypeForm;
import de.hybris.platform.basecommerce.model.site.BaseSiteModel;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.user.UserFacade;
import de.hybris.platform.servicelayer.session.SessionService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Controller for product details page.
 *
 * @since 6.7
 */
@Controller
@Scope("tenant")
@RequestMapping(value = "/processTypes")
public class TmaProcessTypeSelectionController extends AbstractPageController
{
	private static final String LOGIN_URL = "/login";
	private final String[] DISALLOWED_FIELDS = new String[] {};

	@Resource(name = "userFacade")
	private UserFacade userFacade;
	@Resource(name = "sessionService")
	private SessionService sessionService;
	@Resource(name = "siteBaseUrlResolutionService")
	private SiteBaseUrlResolutionService siteBaseUrlResolutionService;

	/**
	 * Stores selected process type on the session and 1. refreshes current page, if the user is already logged in 2.
	 * redirects to login page, otherwise
	 *
	 * @param tmaProcessTypeForm
	 *           process type form
	 * @param model
	 *           page model
	 * @param bindingResult
	 *           binding result
	 * @param request
	 *           request
	 * @return redirect to current page or login page
	 * @throws CMSItemNotFoundException
	 */

	@RequestMapping(value = "/selectProcessType", method = RequestMethod.POST)
	public String selectProcessType(final TmaProcessTypeForm tmaProcessTypeForm, final Model model,
			final BindingResult bindingResult, final HttpServletRequest request) throws CMSItemNotFoundException
	{
		if (bindingResult.hasErrors())
		{
			GlobalMessages.addErrorMessage(model, "tmaProcessType.general.error");
			return TelcoControllerConstants.Actions.Cms.TMA_PROCESSTYPE_LISTING_COMPONENT;
		}

		final String redirectUrl = request.getHeader("Referer");
		final BaseSiteModel currentBaseSite = getBaseSiteService().getCurrentBaseSite();
		final String websiteUrl = siteBaseUrlResolutionService.getWebsiteUrlForSite(currentBaseSite, true, "");

		if (redirectUrl.startsWith(websiteUrl) && !userFacade.isAnonymousUser())

		{
			sessionService.setAttribute(SELECTED_PROCESS_TYPE, tmaProcessTypeForm.getProcessTypeName());
			return REDIRECT_PREFIX + XSSFilterUtil.filter(redirectUrl);
		}
		return REDIRECT_PREFIX + LOGIN_URL;
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}
}
