/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.misc;

import de.hybris.platform.acceleratorcms.model.components.MiniCartComponentModel;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.AbstractController;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcofacades.order.TmaCartFacade;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.cms2.servicelayer.services.CMSComponentService;
import de.hybris.platform.commercefacades.order.CartFacade;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.OrderEntryData;
import de.hybris.platform.commercefacades.product.data.PriceData;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Controller for MiniCart functionality which is not specific to a page.
 */
@Controller
@Scope("tenant")
public class MiniCartController extends AbstractController
{
	/**
	 * We use this suffix pattern because of an issue with Spring 3.1 where a Uri value is incorrectly extracted if it
	 * contains on or more '.' characters. Please see https://jira.springsource.org/browse/SPR-6164 for a discussion on
	 * the issue and future resolution.
	 */
	private static final String TOTAL_DISPLAY_PATH_VARIABLE_PATTERN = "{totalDisplay:.*}";
	private static final String COMPONENT_UID_PATH_VARIABLE_PATTERN = "{componentUid:.*}";

	private static final String ENTRIES = "entries";
	private static final String NUMBER_ITEMS_IN_CART = "numberItemsInCart";
	private static final String NUMBER_SHOWING = "numberShowing";
	private static final String LIGHTBOX_BANNER_COMPONENT = "lightboxBannerComponent";
	private static final String SUB_TOTAL = "subTotal";
	private static final String TOTAL_PRICE = "totalPrice";
	private static final String TOTAL_DISPLAY = "totalDisplay";
	private static final String TOTAL_ITEMS = "totalItems";
	private static final String TOTAL_NO_DELIVERY = "totalNoDelivery";
	private static final String CART_DATA = "cartData";

	@Resource(name = "cartFacade")
	private CartFacade cartFacade;

	@Resource(name = "cmsComponentService")
	private CMSComponentService cmsComponentService;

	@RequestMapping(value = "/cart/miniCart/" + TOTAL_DISPLAY_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String getMiniCart(@PathVariable final String totalDisplay, final Model model)
	{
		final CartData cartData = getCartFacade().getMiniCart();
		model.addAttribute(TOTAL_PRICE, cartData.getTotalPrice());
		model.addAttribute(SUB_TOTAL, cartData.getSubTotal());
		model.addAttribute(TOTAL_NO_DELIVERY, getTotalPriceWithoutDelivery(cartData));
		model.addAttribute(TOTAL_ITEMS, cartData.getTotalUnitCount());
		model.addAttribute(TOTAL_DISPLAY, totalDisplay);
		return TelcoControllerConstants.Views.Fragments.Cart.MINI_CART_PANEL;
	}

	@RequestMapping(value = "/cart/rollover/" + COMPONENT_UID_PATH_VARIABLE_PATTERN, method = RequestMethod.GET)
	public String rolloverMiniCartPopup(@PathVariable final String componentUid, final Model model) throws CMSItemNotFoundException
	{
		final CartData cartData = getCartFacade().getMiniCart();
		model.addAttribute(CART_DATA, cartData);

		final MiniCartComponentModel component = cmsComponentService.getSimpleCMSComponent(componentUid);
		model.addAttribute(LIGHTBOX_BANNER_COMPONENT, component.getLightboxBannerComponent());

		final List<OrderEntryData> entries = cartData.getEntries();
		if (entries != null)
		{
			Collections.reverse(entries);
			model.addAttribute(ENTRIES, entries);
			model.addAttribute(NUMBER_ITEMS_IN_CART, cartData.getTotalItems());
			model.addAttribute(NUMBER_SHOWING, getShownProductCount(entries.size(), component.getShownProductCount()));
		}
		return TelcoControllerConstants.Views.Fragments.Cart.CART_POPUP;
	}

	/**
	 * Returns the product count to be shown in the cart popup for the case where there are too many items in the cart
	 * and not all of them will be displayed.
	 *
	 * @param entriesSize
	 * 		total entries count
	 * @param componentShownProductCount
	 * 		configurable product count to be shown
	 * @return the product count to be displayed
	 */
	protected int getShownProductCount(final int entriesSize, final int componentShownProductCount)
	{
		return entriesSize < componentShownProductCount ? entriesSize : componentShownProductCount;
	}

	/**
	 * Returns the total price without the delivery cost.
	 *
	 * @param cartData
	 * 		to retrieve information from
	 * @return the total price without delivery cost
	 */
	protected PriceData getTotalPriceWithoutDelivery(final CartData cartData)
	{
		final PriceData deliveryCost = cartData.getDeliveryCost();
		if (deliveryCost == null)
		{
			return cartData.getTotalPrice();
		}

		final BigDecimal totalPriceWithoutDeliveryValue = cartData.getTotalPrice().getValue().subtract(deliveryCost.getValue());
		deliveryCost.setValue(totalPriceWithoutDeliveryValue);
		return deliveryCost;
	}

	protected TmaCartFacade getCartFacade()
	{
		return (TmaCartFacade) cartFacade;
	}
}
