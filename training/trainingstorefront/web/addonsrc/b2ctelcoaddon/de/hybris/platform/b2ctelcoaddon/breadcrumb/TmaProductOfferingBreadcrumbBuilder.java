/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.breadcrumb;

import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.impl.ProductBreadcrumbBuilder;
import de.hybris.platform.b2ctelcoservices.model.TmaPoVariantModel;
import de.hybris.platform.core.model.product.ProductModel;

/**
 * Breadcrumb builder which handles base product for {@link TmaPoVariantModel}.
 *
 * @since 1810
 */
public class TmaProductOfferingBreadcrumbBuilder extends ProductBreadcrumbBuilder
{
	@Override
	protected ProductModel getBaseProduct(ProductModel product)
	{
		if (product instanceof TmaPoVariantModel)
		{
			return getBaseProduct(((TmaPoVariantModel) product).getTmaBasePo());
		}
		return product;
	}
}
