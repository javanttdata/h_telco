/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.cms;

import de.hybris.platform.addonsupport.controllers.cms.AbstractCMSAddOnComponentController;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.util.ProductDataHelper;
import de.hybris.platform.b2ctelcoaddon.model.ProductReferencesAndClassificationsComponentModel;
import de.hybris.platform.b2ctelcofacades.data.TmaProductOfferingPriceData;
import de.hybris.platform.b2ctelcofacades.product.TelcoProductFacade;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.servicelayer.util.ServicesUtil;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Component controller that displays controller for the product references and feature compatible products.
 */
@Controller("ProductReferencesAndClassificationsComponentController")
@RequestMapping(value = TelcoControllerConstants.Actions.Cms.PRODUCT_REFERENCES_AND_CLASSIFICATIONS_COMPONENT)
public class ProductReferencesAndClassificationsComponentController extends
		AbstractCMSAddOnComponentController<ProductReferencesAndClassificationsComponentModel>
{
	protected static final List<ProductOption> PRODUCT_OPTIONS = Arrays.asList(ProductOption.BASIC, ProductOption.PRICE,
			ProductOption.SUMMARY);

	@Resource(name = "telcoProductFacade")
	private TelcoProductFacade telcoProductFacade;

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationService;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model,
			final ProductReferencesAndClassificationsComponentModel component)
	{
		ServicesUtil.validateParameterNotNull(component, "CMSComponent must not be null");

		final List<ProductData> referenceAndClassificationsProducts = telcoProductFacade
				.getProductReferencesAndFeatureCompatibleProductsForCode(ProductDataHelper.getCurrentProduct(request),
						component.getProductReferenceTypes(),
						PRODUCT_OPTIONS,
						component.getMaximumNumberProducts(),
						component.getClassAttributeAssignment());

		organizeProductPriceData(referenceAndClassificationsProducts);

		model.addAttribute("title", component.getTitle());

		model.addAttribute("productAccessories", referenceAndClassificationsProducts);
	}

	private void organizeProductPriceData(List<ProductData> productDatas)
	{
		productDatas.forEach(productData ->
		{
			if (productData.getPrice() != null)
			{
				TmaProductOfferingPriceData compositePriceWithFlatPrices =
						getTmaPriceOrganizationService().obtainPopDataWithFlatPrices(productData.getPrice().getProductOfferingPrice());
				productData.getPrice().setProductOfferingPrice(compositePriceWithFlatPrices);
			}
		});
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaPriceOrganizationService getTmaPriceOrganizationService()
	{
		return tmaPriceOrganizationService;
	}

	public TelcoProductFacade getTelcoProductFacade()
	{
		return telcoProductFacade;
	}
}
