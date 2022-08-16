/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages;

import de.hybris.platform.acceleratorservices.controllers.page.PageType;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.Breadcrumb;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.acceleratorstorefrontcommons.forms.ReviewForm;
import de.hybris.platform.acceleratorstorefrontcommons.forms.validation.ReviewValidator;
import de.hybris.platform.acceleratorstorefrontcommons.util.MetaSanitizerUtil;
import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;
import de.hybris.platform.acceleratorstorefrontcommons.variants.VariantSortStrategy;
import de.hybris.platform.b2ctelcoaddon.breadcrumb.TmaProductOfferingBreadcrumbBuilder;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonWebConstants;
import de.hybris.platform.b2ctelcoaddon.constants.WebConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.util.ProductDataHelper;
import de.hybris.platform.b2ctelcofacades.data.BundleTabData;
import de.hybris.platform.b2ctelcofacades.data.FrequencyTabData;
import de.hybris.platform.b2ctelcofacades.data.TmaProductOfferingPriceData;
import de.hybris.platform.b2ctelcofacades.product.TmaProductOfferFacade;
import de.hybris.platform.b2ctelcoservices.model.TmaFixedBundledProductOfferingModel;
import de.hybris.platform.b2ctelcoservices.model.TmaProductOfferingModel;
import de.hybris.platform.b2ctelcoservices.services.TmaPoService;
import de.hybris.platform.catalog.enums.ProductReferenceTypeEnum;
import de.hybris.platform.category.model.CategoryModel;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.cms2.model.pages.AbstractPageModel;
import de.hybris.platform.cms2.servicelayer.services.CMSPageService;
import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.BaseOptionData;
import de.hybris.platform.commercefacades.product.data.CategoryData;
import de.hybris.platform.commercefacades.product.data.ImageData;
import de.hybris.platform.commercefacades.product.data.ImageDataType;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.product.data.ProductReferenceData;
import de.hybris.platform.commercefacades.product.data.ReviewData;
import de.hybris.platform.commerceservices.category.CommerceCategoryService;
import de.hybris.platform.commerceservices.url.UrlResolver;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.platform.servicelayer.exceptions.UnknownIdentifierException;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * Controller for product details page.
 */
@Controller
@Scope("tenant")
@RequestMapping(value = "/**/p")
public class ProductPageController extends AbstractPageController
{

	private static final Logger LOG = Logger.getLogger(ProductPageController.class);

	private static final String PRODUCT_CODE_PATH_VARIABLE_PATTERN = "/{productCode:.*}";
	private static final String REVIEWS_PATH_VARIABLE_PATTERN = "{numberOfReviews:.*}";
	private static final String PRODUCT_DATA = "product";
	private final String[] DISALLOWED_FIELDS = new String[] {};

	@Resource(name = "productModelUrlResolver")
	private UrlResolver<ProductModel> productModelUrlResolver;

	@Resource(name = "productFacade")
	private ProductFacade productFacade;

	@Resource(name = "tmaProductOfferFacade")
	private TmaProductOfferFacade productOfferFacade;

	@Resource(name = "productOfferingBreadcrumbBuilder")
	private TmaProductOfferingBreadcrumbBuilder productBreadcrumbBuilder;

	@Resource(name = "cmsPageService")
	private CMSPageService cmsPageService;

	@Resource(name = "variantSortStrategy")
	private VariantSortStrategy variantSortStrategy;

	@Resource(name = "reviewValidator")
	private ReviewValidator reviewValidator;

	@Resource(name = "categoryConverter")
	private Converter<CategoryModel, CategoryData> categoryConverter;

	@Resource(name = "commerceCategoryService")
	private CommerceCategoryService commerceCategoryService;

	@Resource(name = "categoryDataUrlResolver")
	private UrlResolver<CategoryData> categoryDataUrlResolver;

	@Resource(name = "tmaPoService")
	private TmaPoService tmaPoService;

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationService;

	/**
	 * View product details page.
	 *
	 * @param productCode
	 * 		product code
	 * @param model
	 * 		page model
	 * @param request
	 * 		http request
	 * @param response
	 * 		http response
	 * @return path to PDP page
	 * @throws CMSItemNotFoundException
	 * 		thrown in case the product with ID specified is not found
	 * @throws UnsupportedEncodingException
	 * 		thrown in case encoding is not supported
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String productDetail(@PathVariable("productCode") final String productCode, final Model model,
			final HttpServletRequest request, final HttpServletResponse response)
			throws CMSItemNotFoundException, UnsupportedEncodingException
	{
		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);

		if (productModel instanceof TmaFixedBundledProductOfferingModel)
		{
			throw new UnknownIdentifierException("Item not found");
		}

		final String redirection = checkRequestUrl(request, response, productModelUrlResolver.resolve(productModel));
		if (StringUtils.isNotEmpty(redirection))
		{
			return redirection;
		}

		updatePageTitle(productModel, model);
		LOG.debug("Get details for product " + YSanitizer.sanitize(productCode));
		populateProductDetailForDisplay(productModel, model, request);
		model.addAttribute(new ReviewForm());

		final List<ProductReferenceData> productReferences = productFacade.getProductReferencesForCode(productCode,
				Arrays.asList(ProductReferenceTypeEnum.SIMILAR, ProductReferenceTypeEnum.ACCESSORIES),
				Arrays.asList(ProductOption.BASIC, ProductOption.PRICE), null);
		model.addAttribute("productReferences", productReferences);
		model.addAttribute("pageType", PageType.PRODUCT.name());

		final ProductData productData = (ProductData) model.asMap().get(PRODUCT_DATA);
		final String metaKeywords = MetaSanitizerUtil.sanitizeKeywords(productData.getKeywords());
		final String metaDescription = MetaSanitizerUtil.sanitizeDescription(productData.getDescription());
		setUpMetaData(model, metaKeywords, metaDescription);
		return getViewForPage(model);
	}

	/**
	 * Zoom images.
	 *
	 * @param productCode
	 * 		product code
	 * @param galleryPosition
	 * 		position of the gallery
	 * @param model
	 * 		page model
	 * @return path to zoom images fragment
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/zoomImages", method = RequestMethod.GET)
	public String showZoomImages(@PathVariable("productCode") final String productCode,
			@RequestParam(value = "galleryPosition", required = false) final String galleryPosition, final Model model,
			final HttpServletRequest request)
	{
		final ProductData productData = getProductOfferFacade().getPoForCode(productCode,
				Collections.singleton(ProductOption.GALLERY));
		final List<Map<String, ImageData>> images = getGalleryImages(productData);
		populateProductData(productData, model, request);
		if (galleryPosition != null)
		{
			try
			{
				model.addAttribute("zoomImageUrl", images.get(Integer.parseInt(galleryPosition)).get("zoom").getUrl());
			}
			catch (final IndexOutOfBoundsException | NumberFormatException ioebe)
			{
				LOG.info(ioebe);
				model.addAttribute("zoomImageUrl", "");
			}
		}
		return TelcoControllerConstants.Views.Fragments.Product.ZOOM_IMAGES_POPUP;
	}

	/**
	 * Quick view.
	 *
	 * @param productCode
	 * 		product code
	 * @param model
	 * 		page model
	 * @param request
	 * 		http request
	 * @return path to quick view fragment
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/quickView", method = RequestMethod.GET)
	public String showQuickView(@PathVariable("productCode") final String productCode, final Model model,
			final HttpServletRequest request)
	{
		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);
		final ProductData productData = getProductOfferFacade().getPoForCode(productCode,
				Arrays.asList(ProductOption.BASIC, ProductOption.PRICE, ProductOption.SUMMARY, ProductOption.DESCRIPTION,
						ProductOption.CATEGORIES, ProductOption.PROMOTIONS, ProductOption.STOCK, ProductOption.REVIEW,
						ProductOption.VARIANT_FULL, ProductOption.DELIVERY_MODE_AVAILABILITY));

		sortVariantOptionData(productData);
		populateProductData(productData, model, request);
		getRequestContextData(request).setProduct(productModel);

		return TelcoControllerConstants.Views.Fragments.Product.QUICK_VIEW_POPUP;
	}

	/**
	 * Post review.
	 *
	 * @param productCode
	 * 		the product code
	 * @param form
	 * 		review form
	 * @param result
	 * 		binding result
	 * @param model
	 * 		page model
	 * @param request
	 * 		htto request
	 * @param redirectAttrs
	 * 		redirect attributes
	 * @return returns the path to PDP page
	 * @throws CMSItemNotFoundException
	 * 		in case setup of review page fails the error is thrown
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/review", method =
			{ RequestMethod.GET, RequestMethod.POST })
	public String postReview(@PathVariable final String productCode, final ReviewForm form, final BindingResult result,
			final Model model, final HttpServletRequest request, final RedirectAttributes redirectAttrs)
			throws CMSItemNotFoundException
	{
		getReviewValidator().validate(form, result);

		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);

		if (result.hasErrors())
		{
			updatePageTitle(productModel, model);
			GlobalMessages.addErrorMessage(model, "review.general.error");
			model.addAttribute("showReviewForm", Boolean.TRUE);
			populateProductDetailForDisplay(productModel, model, request);
			storeCmsPageInModel(model, getPageForProduct(productModel.getCode()));
			return getViewForPage(model);
		}

		return addReview(productCode, form, redirectAttrs, productModel);
	}

	/**
	 * Show review.
	 *
	 * @param productCode
	 * 		the product code
	 * @param numberOfReviews
	 * 		number of reviews
	 * @param model
	 * 		page model
	 * @param request
	 * 		http request
	 * @return the path to reviews page tab
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/reviewhtml/"
			+ REVIEWS_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String reviewHtml(@PathVariable("productCode") final String productCode,
			@PathVariable("numberOfReviews") final String numberOfReviews, final Model model, final HttpServletRequest request)
	{
		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);
		final List<ReviewData> reviews;
		final ProductData productData = getProductOfferFacade().getPoForCode(productCode,
				Arrays.asList(ProductOption.BASIC, ProductOption.REVIEW));

		if ("all".equals(numberOfReviews))
		{
			reviews = productFacade.getReviews(productCode);
		}
		else
		{
			final int reviewCount = Math.min(Integer.parseInt(numberOfReviews),
					(productData.getNumberOfReviews() == null ? 0 : productData.getNumberOfReviews()));
			reviews = productFacade.getReviews(productCode, reviewCount);
		}

		getRequestContextData(request).setProduct(productModel);
		reviews.forEach(review -> {
			review.setHeadline(XSSFilterUtil.filter(review.getHeadline()));
			review.setComment(XSSFilterUtil.filter(review.getComment()));
			review.setAlias(XSSFilterUtil.filter(review.getAlias()));
		});
		model.addAttribute("reviews", reviews);
		model.addAttribute("reviewsTotal", productData.getNumberOfReviews());
		model.addAttribute(new ReviewForm());

		return TelcoControllerConstants.Views.Fragments.Product.REVIEWS_TAB;
	}

	/**
	 * Write review dialog.
	 *
	 * @param productCode
	 * 		product code
	 * @param model
	 * 		page model
	 * @return path to review page
	 * @throws CMSItemNotFoundException
	 * 		in case setup of review page fails the error is thrown
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/writeReview", method = RequestMethod.GET)
	public String writeReview(@PathVariable final String productCode, final Model model) throws CMSItemNotFoundException
	{
		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);
		model.addAttribute(new ReviewForm());
		setUpReviewPage(model, productModel);
		return TelcoControllerConstants.Views.Pages.Product.WRITE_REVIEW;
	}

	@SuppressWarnings("WeakerAccess")
	protected void setUpReviewPage(final Model model, final ProductModel productModel) throws CMSItemNotFoundException
	{
		final ProductData productData = getProductOfferFacade().getPoForCode(productModel.getCode(),
				Arrays.asList(ProductOption.BASIC, ProductOption.DESCRIPTION));
		final String metaKeywords = MetaSanitizerUtil.sanitizeKeywords(productData.getKeywords());
		final String metaDescription = MetaSanitizerUtil.sanitizeDescription(productData.getDescription());
		setUpMetaData(model, metaKeywords, metaDescription);
		storeCmsPageInModel(model, getPageForProduct(productData.getCode()));
		model.addAttribute("product", productData);
		updatePageTitle(productModel, model);
	}

	/**
	 * Write review.
	 *
	 * @param productCode
	 * 		the product code
	 * @param form
	 * 		input form object
	 * @param result
	 * 		binding result
	 * @param model
	 * 		page model
	 * @param request
	 * 		request object
	 * @param redirectAttrs
	 * 		redirect attributes
	 * @return returns path to PDP page with review message on the model
	 * @throws CMSItemNotFoundException
	 * 		in case
	 */
	@RequestMapping(value = PRODUCT_CODE_PATH_VARIABLE_PATTERN + "/writeReview", method = RequestMethod.POST)
	public String writeReview(@PathVariable final String productCode, final ReviewForm form, final BindingResult result,
			final Model model, final HttpServletRequest request, final RedirectAttributes redirectAttrs)
			throws CMSItemNotFoundException
	{
		getReviewValidator().validate(form, result);

		final TmaProductOfferingModel productModel = getTmaPoService().getPoForCode(productCode);

		if (result.hasErrors())
		{
			GlobalMessages.addErrorMessage(model, "review.general.error");
			populateProductDetailForDisplay(productModel, model, request);
			setUpReviewPage(model, productModel);
			return TelcoControllerConstants.Views.Pages.Product.WRITE_REVIEW;
		}

		return addReview(productCode, form, redirectAttrs, productModel);
	}

	/**
	 * Unknown identifier error.
	 *
	 * @param exception
	 * 		exception o bject
	 * @param request
	 * 		http request
	 * @return forward patch to a 404 error page
	 */
	@ExceptionHandler(UnknownIdentifierException.class)
	public String handleUnknownIdentifierException(final UnknownIdentifierException exception, final HttpServletRequest request)
	{
		request.setAttribute("message", exception.getMessage());
		return FORWARD_PREFIX + "/404";
	}

	@SuppressWarnings("WeakerAccess")
	protected void updatePageTitle(final ProductModel productModel, final Model model)
	{
		storeContentPageTitleInModel(model, getPageTitleResolver().resolveProductPageTitle(productModel));
	}

	@SuppressWarnings("WeakerAccess")
	protected void populateProductDetailForDisplay(final TmaProductOfferingModel productModel, final Model model,
			final HttpServletRequest request) throws CMSItemNotFoundException
	{
		getRequestContextData(request).setProduct(productModel);

		final List<ProductOption> options = Arrays.asList(ProductOption.BASIC, ProductOption.PRICE, ProductOption.SUMMARY,
				ProductOption.DESCRIPTION, ProductOption.SOLD_INDIVIDUALLY, ProductOption.GALLERY, ProductOption.CATEGORIES,
				ProductOption.REVIEW, ProductOption.PROMOTIONS, ProductOption.CLASSIFICATION, ProductOption.VARIANT_MATRIX,
				ProductOption.VARIANT_MATRIX_ALL_OPTIONS, ProductOption.STOCK, ProductOption.VOLUME_PRICES,
				ProductOption.DELIVERY_MODE_AVAILABILITY, ProductOption.SPO_BUNDLE_TABS);

		final ProductData productData = getProductOfferFacade().getPoForCode(productModel.getCode(), options);
		sortVariantOptionData(productData);

		storeCmsPageInModel(model, getPageForProduct(productData.getCode()));
		populateProductData(productData, model, request);

		final List<Breadcrumb> breadcrumbs = productBreadcrumbBuilder.getBreadcrumbs(productData.getCode());
		// Note: This is the index of the category above the product's supercategory
		int productSuperSuperCategoryIndex = breadcrumbs.size() - 3;
		final List<CategoryData> superCategories = new ArrayList<>();
		if (productSuperSuperCategoryIndex == 0)
		{
			// The category at index 0 is never displayed as a supercategory; for
			// display purposes, the category at index 1 is the root category
			productSuperSuperCategoryIndex = 1;
		}
		if (productSuperSuperCategoryIndex > 0)
		{
			// When product has any supercategory
			final Breadcrumb productSuperSuperCategory = breadcrumbs.get(productSuperSuperCategoryIndex);
			final CategoryModel superSuperCategory = commerceCategoryService
					.getCategoryForCode(productSuperSuperCategory.getCategoryCode());
			for (final CategoryModel superCategory : superSuperCategory.getCategories())
			{
				final CategoryData categoryData = new CategoryData();
				categoryData.setName(superCategory.getName());
				categoryData.setUrl(categoryDataUrlResolver.resolve(categoryConverter.convert(superCategory)));
				superCategories.add(categoryData);
			}
		}

		model.addAttribute(B2ctelcoaddonWebConstants.SUPERCATEGORIES_KEY, superCategories);
		model.addAttribute(WebConstants.BREADCRUMBS_KEY, productBreadcrumbBuilder.getBreadcrumbs(productData.getCode()));
	}

	@SuppressWarnings("WeakerAccess")
	protected void populateProductData(final ProductData productData, final Model model, final HttpServletRequest request)
	{
		ProductDataHelper.setCurrentProduct(request, productData.getCode());
		model.addAttribute("galleryImages", getGalleryImages(productData));
		model.addAttribute(PRODUCT_DATA, productData);
		organizeProductPriceData(productData);
	}

	private void organizeProductPriceData(ProductData productData)
	{
		if (productData.getPrice() != null)
		{
			TmaProductOfferingPriceData compositePriceWithFlatPrices =
					getTmaPriceOrganizationService().obtainPopDataWithFlatPrices(productData.getPrice().getProductOfferingPrice());
			productData.getPrice().setProductOfferingPrice(compositePriceWithFlatPrices);
		}

		if (CollectionUtils.isEmpty(productData.getBundleTabs()))
		{
			return;
		}

		populatePricesInBundleTabs(productData);
	}

	private void populatePricesInBundleTabs(ProductData productData)
	{
		for (BundleTabData bundleTabData : productData.getBundleTabs())
		{
			if (bundleTabData.getParentBpo() == null || CollectionUtils.isEmpty(bundleTabData.getFrequencyTabs()))
			{
				continue;
			}

			for (FrequencyTabData frequencyTabData : bundleTabData.getFrequencyTabs())
			{
				if (CollectionUtils.isEmpty(frequencyTabData.getProducts()))
				{
					continue;
				}

				for (ProductData spoData : frequencyTabData.getProducts())
				{
					getTmaPriceOrganizationService().organizePopsForProduct(spoData);
				}

			}
		}
	}

	@SuppressWarnings("WeakerAccess")
	protected void sortVariantOptionData(final ProductData productData)
	{
		if (CollectionUtils.isNotEmpty(productData.getBaseOptions()))
		{
			for (final BaseOptionData baseOptionData : productData.getBaseOptions())
			{
				if (CollectionUtils.isNotEmpty(baseOptionData.getOptions()))
				{
					baseOptionData.getOptions().sort(variantSortStrategy);
				}
			}
		}

		if (CollectionUtils.isNotEmpty(productData.getVariantOptions()))
		{
			productData.getVariantOptions().sort(variantSortStrategy);
		}
	}

	@SuppressWarnings("WeakerAccess")
	protected List<Map<String, ImageData>> getGalleryImages(final ProductData productData)
	{
		final List<Map<String, ImageData>> galleryImages = new ArrayList<>();
		if (CollectionUtils.isNotEmpty(productData.getImages()))
		{
			final List<ImageData> images = new ArrayList<>();
			for (final ImageData image : productData.getImages())
			{
				if (ImageDataType.GALLERY.equals(image.getImageType()))
				{
					images.add(image);
				}
			}
			images.sort(Comparator.comparing(ImageData::getGalleryIndex));

			if (CollectionUtils.isEmpty(images))
			{
				return galleryImages;
			}

			int currentIndex = images.get(0).getGalleryIndex();
			Map<String, ImageData> formats = new HashMap<>();

			for (final ImageData image : images)
			{
				if (currentIndex != image.getGalleryIndex())
				{
					galleryImages.add(formats);
					formats = new HashMap<>();
					currentIndex = image.getGalleryIndex();
				}
				formats.put(image.getFormat(), image);
			}

			if (!formats.isEmpty())
			{
				galleryImages.add(formats);
			}

		}
		return galleryImages;
	}

	private String addReview(@PathVariable String productCode, ReviewForm form,
			RedirectAttributes redirectAttrs, TmaProductOfferingModel productModel)
	{
		final ReviewData review = new ReviewData();
		review.setHeadline(XSSFilterUtil.filter(form.getHeadline()));
		review.setComment(XSSFilterUtil.filter(form.getComment()));
		review.setRating(form.getRating());
		review.setAlias(XSSFilterUtil.filter(form.getAlias()));
		productFacade.postReview(productCode, review);
		GlobalMessages.addFlashMessage(redirectAttrs, GlobalMessages.CONF_MESSAGES_HOLDER, "review.confirmation.thank.you.title");

		return REDIRECT_PREFIX + productModelUrlResolver.resolve(productModel);
	}

	@SuppressWarnings("WeakerAccess")
	protected ReviewValidator getReviewValidator()
	{
		return reviewValidator;
	}

	@SuppressWarnings("WeakerAccess")
	protected AbstractPageModel getPageForProduct(final String productCode) throws CMSItemNotFoundException
	{
		return cmsPageService.getPageForProductCode(productCode);
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaProductOfferFacade getProductOfferFacade()
	{
		return productOfferFacade;
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaPoService getTmaPoService()
	{
		return tmaPoService;
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaPriceOrganizationService getTmaPriceOrganizationService()
	{
		return tmaPriceOrganizationService;
	}

	@InitBinder
	public void initBinder(final WebDataBinder binder)
	{
		binder.setDisallowedFields(DISALLOWED_FIELDS);
	}
}
