/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.myaccount;

/**
 * Silent Order Post Response URL Strategy.
 *
 * Used to determine the response (callback) URL for a SOP payment service request.
 */
public interface SopResponseUrlStrategy
{

	/**
	 * Get the URL for the SOP Response.
	 * 
	 * @return the implementation-specific SOP response URL.
	 */
	String getUrl();

}
