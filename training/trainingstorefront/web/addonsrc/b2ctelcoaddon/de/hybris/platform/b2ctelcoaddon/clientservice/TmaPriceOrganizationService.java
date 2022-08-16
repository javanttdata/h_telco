/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.clientservice;

import de.hybris.platform.b2ctelcofacades.data.TmaComponentProdOfferPriceData;
import de.hybris.platform.b2ctelcofacades.data.TmaCompositeProdOfferPriceData;
import de.hybris.platform.b2ctelcofacades.data.TmaProductOfferingPriceData;
import de.hybris.platform.b2ctelcofacades.price.TmaPriceFacade;
import de.hybris.platform.commercefacades.product.data.ProductData;

import java.util.HashSet;
import java.util.List;
import java.util.Set;


/**
 * Addon service manipulating the price data by obtaining flat prices from a hierarchical structure or reorganizing it in
 * different ways.
 *
 * @since 2007
 */
public class TmaPriceOrganizationService
{
	private TmaPriceFacade tmaPriceFacade;

	public TmaPriceOrganizationService(final TmaPriceFacade tmaPriceFacade)
	{
		this.tmaPriceFacade = tmaPriceFacade;
	}

	/**
	 * Reorganizes the product offering price so that from a composite POP structure a composite POP with flat prices is
	 * obtained (component prices).
	 *
	 * @param complexPopData
	 * 		the POP data from which components are obtained
	 * @return the composite POP containing a list of component POPs
	 */
	public TmaProductOfferingPriceData obtainPopDataWithFlatPrices(final TmaProductOfferingPriceData complexPopData)
	{

		final TmaCompositeProdOfferPriceData result = new TmaCompositeProdOfferPriceData();
		final Set<TmaProductOfferingPriceData> children = new HashSet<>();
		result.setChildren(children);

		final List<TmaComponentProdOfferPriceData> componentPops =
				getTmaPriceFacade().getListOfPriceComponents(complexPopData, TmaComponentProdOfferPriceData.class);

		result.getChildren().addAll(componentPops);

		return result;
	}

	/**
	 * It organizes the POP information for the product data object so that the price, the main spo price in bpo and the
	 * additional prices are organized as a composite POP with all component price POPs in it.
	 *
	 * @param productData
	 * 		the product data
	 */
	public void organizePopsForProduct(final ProductData productData)
	{
		if (productData.getPrice() != null)
		{
			final TmaProductOfferingPriceData compositePriceWithFlatPrices =
					obtainPopDataWithFlatPrices(productData.getPrice().getProductOfferingPrice());
			productData.getPrice().setProductOfferingPrice(compositePriceWithFlatPrices);
		}

		if (productData.getMainSpoPriceInBpo() != null)
		{
			final TmaProductOfferingPriceData compositePriceWithFlatPrices = obtainPopDataWithFlatPrices(
					productData.getMainSpoPriceInBpo().getProductOfferingPrice());
			productData.getMainSpoPriceInBpo().setProductOfferingPrice(compositePriceWithFlatPrices);
		}

		if (productData.getAdditionalSpoPriceInBpo() != null)
		{
			final TmaProductOfferingPriceData compositePriceWithFlatPrices =
					obtainPopDataWithFlatPrices(
							productData.getAdditionalSpoPriceInBpo().getProductOfferingPrice());
			productData.getAdditionalSpoPriceInBpo().setProductOfferingPrice(compositePriceWithFlatPrices);
		}
	}

	@SuppressWarnings("WeakerAccess")
	protected TmaPriceFacade getTmaPriceFacade()
	{
		return tmaPriceFacade;
	}
}
