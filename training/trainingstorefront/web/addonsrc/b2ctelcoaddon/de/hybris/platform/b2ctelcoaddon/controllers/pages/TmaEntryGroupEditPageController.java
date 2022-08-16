/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcofacades.bpoguidedselling.TmaBpoGuidedSellingFacade;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.servicelayer.exceptions.ModelNotFoundException;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Controller Redirect To first step of the BPO Guided Selling Journey based on the entry group .
 *
 * @since 6.7
 */
@Controller
@RequestMapping(value = "/bpo/edit")
public class TmaEntryGroupEditPageController extends AbstractPageController
{
	protected static final String NO_RESULTS_CMS_PAGE_ID = "searchEmpty";
	private TmaBpoGuidedSellingFacade tmaBpoGuidedSellingFacade;

	@RequestMapping(value =
	{ "/configure/{bpoCode}/{entryGroupNumber}" }, method = RequestMethod.GET)
	public String editEntryGroup(@PathVariable("bpoCode") final String bpoCode,
			@PathVariable(value = "entryGroupNumber", required = false) final String entryGroupNumber, final Model model,
			final HttpServletRequest request) throws UnsupportedEncodingException, CMSItemNotFoundException
	{
		try
		{
			return REDIRECT_PREFIX + "/bpo/configure/" + XSSFilterUtil.filter(bpoCode) + "/"
					+ getTmaBpoGuidedSellingFacade().getFirstStepForBPO(bpoCode) + "/" + XSSFilterUtil.filter(entryGroupNumber);
		}
		catch (final ModelNotFoundException e)
		{
			return setupErrorPage(model, NO_RESULTS_CMS_PAGE_ID, "bpo.guidedselling.code.error");
		}
	}

	protected String setupErrorPage(final Model model, final String label, final String errorMessage)
			throws CMSItemNotFoundException
	{
		storeCmsPageInModel(model, getContentPageForLabelOrId(label));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(label));
		GlobalMessages.addErrorMessage(model, errorMessage);
		return TelcoControllerConstants.Views.Pages.Error.ERROR_NOT_FOUND_PAGE;
	}

	protected TmaBpoGuidedSellingFacade getTmaBpoGuidedSellingFacade()
	{
		return tmaBpoGuidedSellingFacade;
	}

	@Autowired
	public void setTmaBpoGuidedSellingFacade(final TmaBpoGuidedSellingFacade tmaBpoGuidedSellingFacade)
	{
		this.tmaBpoGuidedSellingFacade = tmaBpoGuidedSellingFacade;
	}
}
