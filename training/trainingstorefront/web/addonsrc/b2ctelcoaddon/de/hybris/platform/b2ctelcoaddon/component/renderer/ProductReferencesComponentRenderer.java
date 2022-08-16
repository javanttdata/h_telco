/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */

package de.hybris.platform.b2ctelcoaddon.component.renderer;

import de.hybris.platform.acceleratorcms.model.components.ProductReferencesComponentModel;
import de.hybris.platform.addonsupport.renderer.impl.DefaultAddOnCMSComponentRenderer;
import de.hybris.platform.b2ctelcoaddon.clientservice.TmaPriceOrganizationService;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonConstants;
import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductReferenceData;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.subscriptionservices.model.BillingFrequencyModel;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import org.apache.commons.collections.CollectionUtils;


/**
 * Renderer for {@link ProductReferencesComponentModel}.
 *
 * @since 2011.
 */
public class ProductReferencesComponentRenderer<C extends ProductReferencesComponentModel>
		extends DefaultAddOnCMSComponentRenderer<C>
{
	private static final List<ProductOption> PRODUCT_OPTIONS = Arrays.asList(ProductOption.BASIC, ProductOption.PRICE);
	private static final String TITLE = "title";
	private static final String COMPONENT = "component";
	private static final String PRODUCT_REFERENCES = "productReferences";

	private ProductFacade productFacade;

	private TmaPriceOrganizationService priceOrganizationService;

	public ProductReferencesComponentRenderer(final ProductFacade productFacade,
			final TmaPriceOrganizationService priceOrganizationService)
	{
		this.productFacade = productFacade;
		this.priceOrganizationService = priceOrganizationService;
	}

	@Override
	protected Map<String, Object> getVariablesToExpose(final PageContext pageContext, final C component)
	{
		final Map<String, Object> model = super.getVariablesToExpose(pageContext, component);
		final ProductModel currentProduct = getRequestContextData((HttpServletRequest) pageContext.getRequest()).getProduct();
		if (currentProduct != null)
		{
			final List<ProductReferenceData> productReferences = productFacade.getProductReferencesForCode(currentProduct.getCode(),
					component.getProductReferenceTypes(), PRODUCT_OPTIONS, component.getMaximumNumberProducts());

			if (CollectionUtils.isNotEmpty(productReferences))
			{
				productReferences.forEach(
						productReferenceData -> getPriceOrganizationService().organizePopsForProduct(productReferenceData.getTarget()));
			}

			model.put(TITLE, component.getTitle());
			model.put(COMPONENT, component);
			model.put(PRODUCT_REFERENCES, productReferences);
			BillingFrequencyModel bf=new BillingFrequencyModel();
			bf.setCode("monthly");
		}
		return model;
	}

	@Override
	protected String getAddonUiExtensionName(final C component)
	{
		return B2ctelcoaddonConstants.EXTENSIONNAME;
	}

	protected ProductFacade getProductFacade()
	{
		return productFacade;
	}

	protected TmaPriceOrganizationService getPriceOrganizationService()
	{
		return priceOrganizationService;
	}
}
