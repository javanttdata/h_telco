/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorfacades.customerlocation.CustomerLocationFacade;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcofacades.bpoguidedselling.TmaBpoGuidedSellingFacade;
import de.hybris.platform.b2ctelcofacades.configurableguidedselling.EntryGroupFacade;
import de.hybris.platform.b2ctelcofacades.data.*;
import de.hybris.platform.b2ctelcofacades.price.TmaPriceFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.product.data.PriceData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.search.data.SearchStateData;
import de.hybris.platform.commerceservices.search.facetdata.ProductSearchPageData;
import de.hybris.platform.commerceservices.search.pagedata.PageableData;
import de.hybris.platform.servicelayer.exceptions.ModelNotFoundException;
import de.hybris.platform.servicelayer.exceptions.UnknownIdentifierException;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections4.map.LinkedMap;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;


/**
 * Controller Returns the Lister page for respective Product offering Groups associated with BPO
 *
 * @since 6.7
 */
@Controller
@RequestMapping(value = "/bpo")
public class TmaBpoGuidedSellingController extends AbstractSearchPageController
{
	private static final Logger LOG = Logger.getLogger(TmaBpoGuidedSellingController.class);

	private static final String NO_RESULTS_CMS_PAGE_ID = "searchEmpty";
	private static final String BPO_LISTER_PAGE = "bpoGuidedSellingProductList";
	private static final String[] DISALLOWED_FIELDS = new String[] {};

	private TmaBpoGuidedSellingFacade tmaBpoGuidedSellingFacade;
	private EntryGroupFacade entryGroupFacade;
	private CustomerLocationFacade customerLocationFacade;

	@Resource(name = "tmaPriceFacade")
	private TmaPriceFacade tmaPriceFacade;

	@RequestMapping(value =
			{ "/configure/{bpoCode}", "/configure/{bpoCode}/{groupId}",
					"/configure/{bpoCode}/{groupId}/{parentEntryNumber}" }, method = RequestMethod.GET)
	public String getGuidedSellingJourneyForGroup(@PathVariable("bpoCode") final String bpoCode,
			@PathVariable(value = "groupId", required = false) final String groupId,
			@PathVariable(value = "parentEntryNumber", required = false) final Integer parentEntryNumber,
			@RequestParam(value = "q", required = false) final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode, final Model model,
			final HttpServletRequest request) throws CMSItemNotFoundException
	{
		String currentStepKey = null;
		String nextStepKey = null;
		try
		{
			final LinkedMap<String, GuidedSellingStepData> bundleProductOfferingGuidedSellingStepData = (LinkedMap<String, GuidedSellingStepData>) getTmaBpoGuidedSellingFacade()
					.getCalculatedStepsForBPO(bpoCode);

			if (null != groupId)
			{
				final boolean isValidStep = bundleProductOfferingGuidedSellingStepData.containsKey(groupId);
				if (!isValidStep)
				{
					return setupErrorPage(model, NO_RESULTS_CMS_PAGE_ID, "bpo.guidedselling.group.error");
				}
				currentStepKey = (groupId);
			}

			if (groupId == null && !bundleProductOfferingGuidedSellingStepData.isEmpty())
			{
				currentStepKey = bundleProductOfferingGuidedSellingStepData.firstKey();
			}

			if (!bundleProductOfferingGuidedSellingStepData.isEmpty())
			{
				nextStepKey = bundleProductOfferingGuidedSellingStepData.nextKey(currentStepKey);
			}

			final PageableData pageableData = createPageableData(page, getSearchPageSize(), sortCode, showMode);
			final ProductSearchPageData<SearchStateData, ProductData> searchPageData = getTmaBpoGuidedSellingFacade()
					.getProductsAssociatedWithGroups(currentStepKey, pageableData, searchQuery, bpoCode, parentEntryNumber);

			populateModelWithAttributes(bpoCode, model, currentStepKey, bundleProductOfferingGuidedSellingStepData, searchPageData,
					nextStepKey, parentEntryNumber);
			populateModel(model, searchPageData, showMode);
			setUpPageTitle(getPageTitle(), model);
			storeContinueUrl(request);
			storeCmsPageInModel(model, getCmsPageService().getPageForId(BPO_LISTER_PAGE));
		}
		catch (final IllegalArgumentException e)
		{
			LOG.error(" No parent entry with number " + parentEntryNumber + " found in the order", e);
			return setupErrorPage(model, NO_RESULTS_CMS_PAGE_ID, "bpo.guidedselling.group.error");
		}
		catch (final ModelNotFoundException | UnknownIdentifierException e)
		{
			LOG.error(" BPO does not exist", e);
			return setupErrorPage(model, NO_RESULTS_CMS_PAGE_ID, "bpo.guidedselling.code.error");
		}
		catch (final UnsupportedOperationException e)
		{
			LOG.error(" FBPO not supported", e);
			return setupErrorPage(model, NO_RESULTS_CMS_PAGE_ID, "bpo.guidedselling.code.error");
		}

		return getViewForPage(model);
	}

	protected String setupErrorPage(final Model model, final String label, final String errorMessage)
			throws CMSItemNotFoundException
	{
		storeCmsPageInModel(model, getContentPageForLabelOrId(label));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(label));
		GlobalMessages.addErrorMessage(model, errorMessage);
		return TelcoControllerConstants.Views.Pages.Error.ERROR_NOT_FOUND_PAGE;
	}

	protected void setUpPageTitle(final String bundleName, final Model model)
	{
		storeContentPageTitleInModel(model, getPageTitleResolver().resolveContentPageTitle(bundleName));
	}

	protected String getPageTitle()
	{
		return getMessageSource().getMessage("bpo.guidedsellling.component.name.default", null,
				getI18nService().getCurrentLocale());
	}

	private void populateModelWithAttributes(final String bpoCode, final Model model, final String currentStepKey,
			final Map<String, GuidedSellingStepData> bundleProductOfferingGuidedSellingStepData,
			final ProductSearchPageData<SearchStateData, ProductData> searchPageData, final String nextStepKey,
			final Integer parentEntryNumber) throws CMSItemNotFoundException
	{
		if (searchPageData == null)
		{
			storeCmsPageInModel(model, getContentPageForLabelOrId(NO_RESULTS_CMS_PAGE_ID));
		}
		else if (searchPageData.getPagination().getTotalNumberOfResults() == 0)
		{
			model.addAttribute("searchPageData", searchPageData);
			storeCmsPageInModel(model, getContentPageForLabelOrId(NO_RESULTS_CMS_PAGE_ID));
		}
		else
		{
			model.addAttribute("currentStep", currentStepKey);
			model.addAttribute("bpoCode", bpoCode);
			model.addAttribute("dashboard", getTmaBpoGuidedSellingFacade().getDashBoardForBPO(bpoCode, parentEntryNumber));
			model.addAttribute("nextStep", nextStepKey);
			model.addAttribute("parentEntryNumber", parentEntryNumber);
			model.addAttribute("cgsProcessType", getProcessTypeByGroup(parentEntryNumber));
			searchPageData.getResults().forEach(this::organizeProductPriceData);
		}
		model.addAttribute("userLocation", getCustomerLocationFacade().getUserLocationData());
	}

	private String getProcessTypeByGroup(final Integer parentEntryNumber)
	{
		return TmaProcessType.ACQUISITION.getCode();
	}

	private void organizeProductPriceData(ProductData productData)
	{
		PriceData priceData = productData.getPrices().get(0);
		if (priceData != null)
		{
			TmaProductOfferingPriceData compositePriceWithFlatPrices = obtainPopDataWithFlatPrices(
					priceData.getProductOfferingPrice());
			productData.getPrices().get(0).setProductOfferingPrice(compositePriceWithFlatPrices);
		}
	}

	private TmaProductOfferingPriceData obtainPopDataWithFlatPrices(TmaProductOfferingPriceData complexPopData)
	{
		TmaCompositeProdOfferPriceData result = new TmaCompositeProdOfferPriceData();
		Set<TmaProductOfferingPriceData> children = new HashSet<>();
		result.setChildren(children);

		List<TmaOneTimeProdOfferPriceChargeData> otcPrices =
				getTmaPriceFacade().getListOfPriceComponents(complexPopData, TmaOneTimeProdOfferPriceChargeData.class);

		List<TmaRecurringProdOfferPriceChargeData> rcPrices =
				getTmaPriceFacade().getListOfPriceComponents(complexPopData, TmaRecurringProdOfferPriceChargeData.class);

		result.getChildren().addAll(otcPrices);
		result.getChildren().addAll(rcPrices);

		return result;
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

	protected EntryGroupFacade getEntryGroupFacade()
	{
		return entryGroupFacade;
	}

	@Autowired
	public void setEntryGroupFacade(final EntryGroupFacade entryGroupFacade)
	{
		this.entryGroupFacade = entryGroupFacade;
	}

	protected CustomerLocationFacade getCustomerLocationFacade()
	{
		return customerLocationFacade;
	}

	@Autowired
	public void setCustomerLocationFacade(final CustomerLocationFacade customerLocationFacade)
	{
		this.customerLocationFacade = customerLocationFacade;
	}

	protected TmaPriceFacade getTmaPriceFacade()
	{
		return tmaPriceFacade;
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}
}
