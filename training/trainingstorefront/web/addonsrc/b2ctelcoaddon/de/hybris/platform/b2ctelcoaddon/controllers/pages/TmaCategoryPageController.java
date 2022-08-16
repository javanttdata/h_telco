/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorservices.controllers.page.PageType;
import de.hybris.platform.acceleratorservices.data.RequestContextData;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.ThirdPartyConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractCategoryPageController;
import de.hybris.platform.acceleratorstorefrontcommons.util.MetaSanitizerUtil;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonWebConstants;
import de.hybris.platform.b2ctelcofacades.product.TmaPoVariantFacade;
import de.hybris.platform.category.model.CategoryModel;
import de.hybris.platform.cms2.model.pages.CategoryPageModel;
import de.hybris.platform.commercefacades.product.data.CategoryData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.search.data.SearchFilterQueryData;
import de.hybris.platform.commercefacades.search.data.SearchQueryData;
import de.hybris.platform.commercefacades.search.data.SearchStateData;
import de.hybris.platform.commerceservices.search.facetdata.FacetRefinement;
import de.hybris.platform.commerceservices.search.facetdata.ProductCategorySearchPageData;
import de.hybris.platform.commerceservices.search.pagedata.PageableData;
import de.hybris.platform.commerceservices.search.solrfacetsearch.data.FilterQueryOperator;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.util.Config;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Controller for category page
 *
 * @since 1810
 */
@Controller
@RequestMapping(value = "/**/c")
public class TmaCategoryPageController extends AbstractCategoryPageController
{
	private static final String SEARCH_PAGE_DATA = "searchPageData";
	private final String[] DISALLOWED_FIELDS = new String[] {};

	@Resource(name = "tmaPoVariantFacade")
	private TmaPoVariantFacade tmaPoVariantFacade;

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationClientService;

	@RequestMapping(value = CATEGORY_CODE_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String category(@PathVariable("categoryCode") final String categoryCode, // NOSONAR
			@RequestParam(value = "q", required = false) final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode, final Model model,
			final HttpServletRequest request, final HttpServletResponse response) throws UnsupportedEncodingException
	{
		final String resultsPage = performSearchAndGetResultsPage(categoryCode, searchQuery, page, showMode, sortCode, model,
				request, response);
		final Object searchPageDataObj = model.asMap().get(SEARCH_PAGE_DATA);
		if (searchPageDataObj != null)
		{
			final ProductCategorySearchPageData searchPageData = (ProductCategorySearchPageData) searchPageDataObj;
			final List<ProductData> groupedResults = tmaPoVariantFacade.groupByBaseProduct(searchPageData.getResults());

			groupedResults.forEach(groupedProductData -> {
				tmaPriceOrganizationClientService.organizePopsForProduct(groupedProductData);
				if (!CollectionUtils.isEmpty(groupedProductData.getChildren()))
				{
					for (ProductData childProductData : groupedResults)
					{
						tmaPriceOrganizationClientService.organizePopsForProduct(childProductData);
					}
				}

				if (!CollectionUtils.isEmpty(groupedProductData.getParents()))
				{
					for (ProductData parentProductData : groupedResults)
					{
						tmaPriceOrganizationClientService.organizePopsForProduct(parentProductData);
					}
				}
			});

			searchPageData.setResults(groupedResults);
			populateModel(model, searchPageData, showMode);
		}
		return resultsPage;
	}

	@ResponseBody
	@RequestMapping(value = CATEGORY_CODE_PATH_VARIABLE_PATTERN + "/facets", method = RequestMethod.GET)
	public FacetRefinement<SearchStateData> getFacets(@PathVariable("categoryCode") final String categoryCode,
			@RequestParam(value = "q", required = false) final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode) throws UnsupportedEncodingException
	{
		return performSearchAndGetFacets(categoryCode, searchQuery, page, showMode, sortCode);
	}

	@ResponseBody
	@RequestMapping(value = CATEGORY_CODE_PATH_VARIABLE_PATTERN + "/results", method = RequestMethod.GET)
	public SearchResultsData<ProductData> getResults(@PathVariable("categoryCode") final String categoryCode,
			@RequestParam(value = "q", required = false) final String searchQuery,
			@RequestParam(value = "page", defaultValue = "0") final int page,
			@RequestParam(value = "show", defaultValue = "Page") final ShowMode showMode,
			@RequestParam(value = "sort", required = false) final String sortCode) throws UnsupportedEncodingException
	{
		return performSearchAndGetResultsData(categoryCode, searchQuery, page, showMode, sortCode);
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}

	@Override
	protected String performSearchAndGetResultsPage(final String categoryCode, final String searchQuery, final int page, // NOSONAR
			final ShowMode showMode, final String sortCode, final Model model, final HttpServletRequest request,
			final HttpServletResponse response) throws UnsupportedEncodingException
	{
		final CategoryModel category = getCommerceCategoryService().getCategoryForCode(categoryCode);

		final String redirection = checkRequestUrl(request, response, getCategoryModelUrlResolver().resolve(category));
		if (StringUtils.isNotEmpty(redirection))
		{
			return redirection;
		}

		final CategoryPageModel categoryPage = getCategoryPage(category);

		final TmaCategorySearchEvaluator categorySearch = new TmaCategorySearchEvaluator(categoryCode, searchQuery, page, showMode,
				sortCode, categoryPage);

		ProductCategorySearchPageData<SearchStateData, ProductData, CategoryData> searchPageData = null;
		try
		{
			categorySearch.doSearch();
			searchPageData = categorySearch.getSearchPageData();
		}
		catch (final ConversionException e) // NOSONAR
		{
			searchPageData = createEmptySearchResult(categoryCode);
		}

		final boolean showCategoriesOnly = categorySearch.isShowCategoriesOnly();

		storeCmsPageInModel(model, categorySearch.getCategoryPage());
		storeContinueUrl(request);

		populateModel(model, searchPageData, showMode);
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, getSearchBreadcrumbBuilder().getBreadcrumbs(categoryCode, searchPageData));
		model.addAttribute("showCategoriesOnly", Boolean.valueOf(showCategoriesOnly));
		model.addAttribute("categoryName", category.getName());
		model.addAttribute("pageType", PageType.CATEGORY.name());
		model.addAttribute("userLocation", getCustomerLocationService().getUserLocation());

		updatePageTitle(category, model);

		final RequestContextData requestContextData = getRequestContextData(request);
		requestContextData.setCategory(category);
		requestContextData.setSearch(searchPageData);

		if (searchQuery != null)
		{
			model.addAttribute(ThirdPartyConstants.SeoRobots.META_ROBOTS, ThirdPartyConstants.SeoRobots.NOINDEX_FOLLOW);
		}

		final String metaKeywords = MetaSanitizerUtil.sanitizeKeywords(
				category.getKeywords().stream().map(keywordModel -> keywordModel.getKeyword()).collect(Collectors.toSet()));
		final String metaDescription = MetaSanitizerUtil.sanitizeDescription(category.getDescription());
		setUpMetaData(model, metaKeywords, metaDescription);

		return getViewPage(categorySearch.getCategoryPage());

	}

	@Override
	protected ProductCategorySearchPageData<SearchStateData, ProductData, CategoryData> populateSearchPageData(
			final String categoryCode, final String searchQuery, final int page, final ShowMode showMode, final String sortCode)
	{
		final CategoryModel category = getCommerceCategoryService().getCategoryForCode(categoryCode);
		final CategoryPageModel categoryPage = getCategoryPage(category);
		final TmaCategorySearchEvaluator categorySearch = new TmaCategorySearchEvaluator(categoryCode, searchQuery, page, showMode,
				sortCode, categoryPage);
		categorySearch.doSearch();

		return categorySearch.getSearchPageData();
	}

	protected class TmaCategorySearchEvaluator
	{
		private final String categoryCode;
		private final SearchQueryData searchQueryData = new SearchQueryData();
		private final int page;
		private final ShowMode showMode;
		private final String sortCode;
		private CategoryPageModel categoryPage;
		private boolean showCategoriesOnly;
		private ProductCategorySearchPageData<SearchStateData, ProductData, CategoryData> searchPageData;

		public TmaCategorySearchEvaluator(final String categoryCode, final String searchQuery, final int page,
				final ShowMode showMode, final String sortCode, final CategoryPageModel categoryPage)
		{
			this.categoryCode = categoryCode;
			this.searchQueryData.setValue(searchQuery);
			this.page = page;
			this.showMode = showMode;
			this.sortCode = sortCode;
			this.categoryPage = categoryPage;
		}

		public void doSearch()
		{
			showCategoriesOnly = false;

			if (categoryPage == null)
			{
				categoryPage = getDefaultCategoryPage();
			}

			final SearchStateData searchState = new SearchStateData();
			addProductTypeFilterQueries(searchQueryData);
			searchState.setQuery(searchQueryData);

			final PageableData pageableData = createPageableData(page, getSearchPageSize(), sortCode, showMode);
			searchPageData = getProductSearchFacade().categorySearch(categoryCode, searchState, pageableData);

			//Encode SearchPageData
			searchPageData = (ProductCategorySearchPageData) encodeSearchPageData(searchPageData);
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

		public int getPage()
		{
			return page;
		}

		public CategoryPageModel getCategoryPage()
		{
			return categoryPage;
		}

		public boolean isShowCategoriesOnly()
		{
			return showCategoriesOnly;
		}

		public ProductCategorySearchPageData<SearchStateData, ProductData, CategoryData> getSearchPageData()
		{
			return searchPageData;
		}
	}

}
