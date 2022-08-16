/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.util;

import de.hybris.platform.commercefacades.order.data.OrderEntryData;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;


/**
 * Helper that contains cart data related utility methods
 */
public class CartHelper
{
	private CartHelper()
	{
		// Deliberately left empty.
	}

	public static List<OrderEntryData> removeEmptyEntries(final List<OrderEntryData> allEntries)
	{
		if (CollectionUtils.isEmpty(allEntries))
		{
			return Collections.emptyList();
		}

		final List<OrderEntryData> realEntries = new ArrayList<OrderEntryData>();
		for (final OrderEntryData entry : allEntries)
		{
			if (entry.getProduct() != null)
			{
				realEntries.add(entry);
			}
		}

		if (CollectionUtils.isEmpty(realEntries))
		{
			return Collections.emptyList();
		}
		else
		{
			return realEntries;
		}
	}
}
