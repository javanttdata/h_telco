/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.cms;

import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.util.ProductDataHelper;
import de.hybris.platform.b2ctelcoaddon.model.ProductReferencesAndClassificationsComponentModel;
import de.hybris.platform.b2ctelcoaddon.model.ProductReferencesAndClassificationsForDevicesComponentModel;
import de.hybris.platform.b2ctelcofacades.data.TmaProductOfferingPriceData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.servicelayer.util.ServicesUtil;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Component controller that handles product references, feature compatible and vendor compatible products.
 */
@Controller("ProductReferencesAndClassificationsForDevicesComponentController")
@RequestMapping(value = TelcoControllerConstants.Actions.Cms.PRODUCT_REFERENCES_AND_CLASSIFICATIONS_FOR_DEVICES_COMPONENT)
public class ProductReferencesAndClassificationsForDevicesComponentController extends
		ProductReferencesAndClassificationsComponentController
{
	private static final Logger LOG = LoggerFactory
			.getLogger(ProductReferencesAndClassificationsForDevicesComponentController.class);

	@Resource(name = "tmaPriceOrganizationClientService")
	private TmaPriceOrganizationService tmaPriceOrganizationService;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model,
			final ProductReferencesAndClassificationsComponentModel component)
	{
		ServicesUtil.validateParameterNotNull(component, "CMSComponent must not be null");

		if (component instanceof ProductReferencesAndClassificationsForDevicesComponentModel)
		{
			final ProductReferencesAndClassificationsForDevicesComponentModel prComponent = (ProductReferencesAndClassificationsForDevicesComponentModel) component;

			final List<ProductData> referenceAndClassificationsProducts = getTelcoProductFacade()
					.getProductReferencesAndCompatibleProducts(
							ProductDataHelper.getCurrentProduct(request), prComponent.getProductReferenceTypes(),
							ProductReferencesAndClassificationsComponentController.PRODUCT_OPTIONS,
							prComponent.getMaximumNumberProducts(),
							prComponent.getClassAttributeAssignment());

			organizeProductPriceData(referenceAndClassificationsProducts);

			model.addAttribute("title", prComponent.getTitle());

			model.addAttribute("productAccessories", referenceAndClassificationsProducts);
		}
		else
		{
			LOG.info("Unsupported CMSComponent type for item [" + component
					+ "]: expected 'ProductReferencesAndClassificationsForDevicesComponentModel', but was '"
					+ component.getClass().getSimpleName() + "'");
		}
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
}
