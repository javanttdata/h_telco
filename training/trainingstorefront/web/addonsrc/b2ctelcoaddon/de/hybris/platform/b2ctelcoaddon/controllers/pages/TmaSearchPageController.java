/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorcms.model.components.SearchBoxComponentModel;
import de.hybris.platform.acceleratorservices.controllers.page.PageType;
import de.hybris.platform.acceleratorservices.customer.CustomerLocationService;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.impl.SearchBreadcrumbBuilder;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.ThirdPartyConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractSearchPageController;
import de.hybris.platform.acceleratorstorefrontcommons.util.MetaSanitizerUtil;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonWebConstants;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.cms2.model.pages.ContentPageModel;
import de.hybris.platform.cms2.servicelayer.services.CMSComponentService;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.search.ProductSearchFacade;
import de.hybris.platform.commercefacades.search.data.AutocompleteResultData;
import de.hybris.platform.commercefacades.search.data.SearchFilterQueryData;
import de.hybris.platform.commercefacades.search.data.SearchQueryData;
import de.hybris.platform.commercefacades.search.data.SearchStateData;
import de.hybris.platform.commerceservices.enums.SearchQueryContext;
import de.hybris.platform.commerceservices.search.facetdata.FacetData;
import de.hybris.platform.commerceservices.search.facetdata.FacetRefinement;
import de.hybris.platform.commerceservices.search.facetdata.ProductSearchPageData;
import de.hybris.platform.commerceservices.search.pagedata.PageableData;
import de.hybris.platform.commerceservices.search.solrfacetsearch.data.FilterQueryOperator;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.util.Config;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/search")
public class TmaSearchPageController extends AbstractSearchPageController
{
	private static final Logger LOG = Logger.getLogger(TmaSearchPageController.class);

	private static final String SEARCH_META_DESCRIPTION_ON = "search.meta.description.on";
	private static final String SEARCH_META_DESCRIPTION_RESULTS = "search.meta.description.results";
	private static final String COMPONENT_UID_PATH_VARIABLE_PATTERN = "{componentUid:.*}";
	private static final String SEARCH_CMS_PAGE_ID = "search";
	private static final String NO_RESULTS_CMS_PAGE_ID = "searchEmpty";
	private static final String PAGE_TYPE = "pageType";
	private static final String USER_LOCATION = "userLocation";
	private static final String SEARCH_PAGE_DATA = "searchPageData";
	private static final String TEXT = "text";

	@Resource(name = "productSearchFacade")
	private ProductSearchFacade<ProductData> productSearchFacade;

	@Resource(name = "searchBreadcrumbBuilder")
	private SearchBreadcrumbBuilder searchBreadcrumbBuilder;

	@Resource(name = "customerLocationService")
	private CustomerLocationService customerLocationService;

	@Resource(name = "cmsComponentService")
	private CMSComponentService cmsComponentService;

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationClientService;

	@RequestMapping(method = RequestMethod.GET, params = "!q")
	public String textSearch(@RequestParam(value = TEXT, defaultValue = "") final String searchText,
			final HttpServletRequest request, final Model model) throws CMSItemNotFoundException
	{
		final ContentPageModel noResultPage = getContentPageForLabelOrId(NO_RESULTS_CMS_PAGE_ID);
		if (StringUtils.isNotBlank(searchText))
		{
			final PageableData pageableData = createPageableData(0, getSearchPageSize(), null, ShowMode.Page);

			final SearchQueryData searchQueryData = new SearchQueryData();
			searchQueryData.setValue(YSanitizer.sanitize(searchText));

			addProductTypeFilterQueries(searchQueryData);

			final SearchStateData searchState = new SearchStateData();
			searchState.setQuery(searchQueryData);

			ProductSearchPageData<SearchStateData, ProductData> searchPageData = null;

			try
			{
				searchPageData = encodeSearchPageData(productSearchFacade.textSearch(searchState, pageableData));
			}
			catch (final ConversionException e) // NOSONAR
			{
				LOG.error("There was an error while trying to encode the search page data ", e);
			}


			reorganizePricesForPos(searchPageData);

			if (searchPageData == null)
			{
				storeCmsPageInModel(model, noResultPage);
			}
			else
			{
				if (shouldRedirect(searchText, request, model, noResultPage, searchPageData))
				{
					return "redirect:" + searchPageData.getKeywordRedirectUrl();
				}
			}

			model.addAttribute(USER_LOCATION, customerLocationService.getUserLocation());
			getRequestContextData(request).setSearch(searchPageData);
			if (searchPageData != null)
			{
				model.addAttribute(WebConstants.BREADCRUMBS_KEY,
						searchBreadcrumbBuilder.getBreadcrumbs(null, YSanitizer.sanitize(searchText),
								CollectionUtils.isEmpty(searchPageData.getBreadcrumbs())));
			}
		}
		else
		{
			storeCmsPageInModel(model, noResultPage);
		}

		model.addAttribute(ThirdPartyConstants.SeoRobots.META_ROBOTS, ThirdPartyConstants.SeoRobots.NOINDEX_FOLLOW);
		model.addAttribute(PAGE_TYPE, PageType.PRODUCTSEARCH.name());

		setUpMetadataForPage(searchText, model);

		return getViewForPage(model);
	}

	@RequestMapping(method = RequestMethod.GET, params = "q")
	public String refineSearch(@RequestParam("q") final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode,
			@RequestParam(value = TEXT, required = false) final String searchText, final HttpServletRequest request,
			final Model model) throws CMSItemNotFoundException
	{
		final ProductSearchPageData<SearchStateData, ProductData> searchPageData = performSearch(YSanitizer.sanitize(searchQuery),
				page, showMode, YSanitizer.sanitize(sortCode), getSearchPageSize());

		reorganizePricesForPos(searchPageData);

		populateModel(model, searchPageData, showMode);
		model.addAttribute(USER_LOCATION, customerLocationService.getUserLocation());

		if (searchPageData.getPagination().getTotalNumberOfResults() == 0)
		{
			updatePageTitle(searchPageData.getFreeTextSearch(), model);
			storeCmsPageInModel(model, getContentPageForLabelOrId(NO_RESULTS_CMS_PAGE_ID));
		}
		else
		{
			storeContinueUrl(request);
			updatePageTitle(searchPageData.getFreeTextSearch(), model);
			storeCmsPageInModel(model, getContentPageForLabelOrId(SEARCH_CMS_PAGE_ID));
		}

		model.addAttribute(WebConstants.BREADCRUMBS_KEY, searchBreadcrumbBuilder.getBreadcrumbs(null, searchPageData));
		model.addAttribute(PAGE_TYPE, PageType.PRODUCTSEARCH.name());

		setUpMetadataForPage(searchText, model);

		return getViewForPage(model);
	}

	@ResponseBody
	@RequestMapping(value = "/results", method = RequestMethod.GET)
	public SearchResultsData<ProductData> jsonSearchResults(@RequestParam("q") final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode)
	{
		final ProductSearchPageData<SearchStateData, ProductData> searchPageData = performSearch(searchQuery, page, showMode,
				sortCode, getSearchPageSize());

		reorganizePricesForPos(searchPageData);
		final SearchResultsData<ProductData> searchResultsData = new SearchResultsData<>();
		searchResultsData.setResults(searchPageData.getResults());
		searchResultsData.setPagination(searchPageData.getPagination());
		return searchResultsData;
	}

	@ResponseBody
	@RequestMapping(value = "/facets", method = RequestMethod.GET)
	public FacetRefinement<SearchStateData> getFacets(@RequestParam("q") final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode)
	{
		final SearchQueryData searchQueryData = new SearchQueryData();
		searchQueryData.setValue(YSanitizer.sanitize(searchQuery));
		final SearchStateData searchState = new SearchStateData();
		addProductTypeFilterQueries(searchQueryData);
		searchState.setQuery(searchQueryData);

		final ProductSearchPageData<SearchStateData, ProductData> searchPageData = productSearchFacade.textSearch(searchState,
				createPageableData(page, getSearchPageSize(), YSanitizer.sanitize(sortCode), showMode));

		reorganizePricesForPos(searchPageData);

		final List<FacetData<SearchStateData>> facets = refineFacets(searchPageData.getFacets(),
				convertBreadcrumbsToFacets(searchPageData.getBreadcrumbs()));

		final FacetRefinement<SearchStateData> refinement = new FacetRefinement<>();
		refinement.setFacets(facets);
		refinement.setCount(searchPageData.getPagination().getTotalNumberOfResults());
		refinement.setBreadcrumbs(searchPageData.getBreadcrumbs());

		return refinement;
	}

	@ResponseBody
	@RequestMapping(value = "/autocomplete/" + COMPONENT_UID_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public AutocompleteResultData getAutocompleteSuggestions(@PathVariable final String componentUid,
			@RequestParam("term") final String term) throws CMSItemNotFoundException
	{
		final AutocompleteResultData resultData = new AutocompleteResultData();

		final SearchBoxComponentModel component = cmsComponentService.getSimpleCMSComponent(componentUid);

		if (component.isDisplaySuggestions())
		{
			resultData.setSuggestions(
					subList(productSearchFacade.getAutocompleteSuggestions(YSanitizer.sanitize(term)), component.getMaxSuggestions()));
		}

		if (component.isDisplayProducts())
		{
			resultData.setProducts(subList(productSearchFacade.textSearch(term, SearchQueryContext.SUGGESTIONS).getResults(),
					component.getMaxProducts()));
		}

		return resultData;
	}

	protected ProductSearchPageData<SearchStateData, ProductData> performSearch(final String searchQuery, final int page,
			final ShowMode showMode, final String sortCode, final int pageSize)
	{
		final PageableData pageableData = createPageableData(page, pageSize, sortCode, showMode);

		final SearchQueryData searchQueryData = new SearchQueryData();
		searchQueryData.setValue(searchQuery);
		addProductTypeFilterQueries(searchQueryData);

		final SearchStateData searchState = new SearchStateData();
		searchState.setQuery(searchQueryData);

		return encodeSearchPageData(productSearchFacade.textSearch(searchState, pageableData));
	}

	protected <E> List<E> subList(final List<E> list, final int maxElements)
	{
		if (CollectionUtils.isEmpty(list))
		{
			return Collections.emptyList();
		}

		if (list.size() > maxElements)
		{
			return list.subList(0, maxElements);
		}

		return list;
	}

	protected void updatePageTitle(final String searchText, final Model model)
	{
		storeContentPageTitleInModel(model, getPageTitleResolver().resolveContentPageTitle(
				getMessageSource().getMessage("search.meta.title", null, "search.meta.title", getI18nService().getCurrentLocale())
						+ " " + searchText));
	}

	private void reorganizePricesForPos(ProductSearchPageData<SearchStateData, ProductData> searchPageData)
	{
		if (searchPageData == null)
		{
			return;
		}

		List<ProductData> productDataList = searchPageData.getResults();

		if (productDataList == null)
		{
			return;
		}

		productDataList.forEach(productData -> {
			tmaPriceOrganizationClientService.organizePopsForProduct(productData);
		});
	}

	private void setUpMetadataForPage(
			@RequestParam(value = TEXT, defaultValue = "") String searchText, Model model)
	{
		final String metaDescription = MetaSanitizerUtil
				.sanitizeDescription(getMessageSource().getMessage(SEARCH_META_DESCRIPTION_RESULTS, null,
						SEARCH_META_DESCRIPTION_RESULTS, getI18nService().getCurrentLocale()) + " " + searchText + " "
						+ getMessageSource().getMessage(SEARCH_META_DESCRIPTION_ON, null, SEARCH_META_DESCRIPTION_ON,
						getI18nService().getCurrentLocale())
						+ " " + getSiteName());
		final String metaKeywords = MetaSanitizerUtil.sanitizeKeywords(searchText);
		setUpMetaData(model, metaKeywords, metaDescription);
	}

	private boolean shouldRedirect(
			@RequestParam(value = TEXT, defaultValue = "") String searchText,
			HttpServletRequest request, Model model, ContentPageModel noResultPage,
			ProductSearchPageData<SearchStateData, ProductData> searchPageData) throws CMSItemNotFoundException
	{
		if (searchPageData.getKeywordRedirectUrl() != null)
		{
			// if the search engine returns a redirect, just
			return true;
		}
		else if (searchPageData.getPagination().getTotalNumberOfResults() == 0)
		{
			model.addAttribute(SEARCH_PAGE_DATA, searchPageData);
			storeCmsPageInModel(model, noResultPage);
			updatePageTitle(searchText, model);
		}
		else
		{
			storeContinueUrl(request);
			populateModel(model, searchPageData, ShowMode.Page);
			storeCmsPageInModel(model, getContentPageForLabelOrId(SEARCH_CMS_PAGE_ID));
			updatePageTitle(searchText, model);
		}
		return false;
	}

	private void addProductTypeFilterQueries(final SearchQueryData searchQueryData)
	{
		final SearchFilterQueryData searchFilterQueryData = new SearchFilterQueryData();
		searchFilterQueryData.setKey("itemtype");
		searchFilterQueryData.setOperator(FilterQueryOperator.OR);
		final String itemTypes = Config.getParameter(B2ctelcoaddonWebConstants.FILTER_PRODUCT_TYPES);
		searchFilterQueryData.setValues(Arrays.stream(itemTypes.split(",")).collect(Collectors.toSet()));
		searchQueryData.setFilterQueries(Collections.singletonList(searchFilterQueryData));
	}
}
