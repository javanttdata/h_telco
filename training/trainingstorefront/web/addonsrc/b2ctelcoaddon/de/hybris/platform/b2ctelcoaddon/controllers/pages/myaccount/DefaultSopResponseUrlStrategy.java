/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.pages.myaccount;

/**
 * Default implementation of the SOP Response URL Strategy.
 *
 */
public class DefaultSopResponseUrlStrategy implements SopResponseUrlStrategy
{

	private String url;

	/**
	 * @return the spring-configured SOP Response URL
	 */
	@Override
	public String getUrl()
	{
		return url;
	}

	public void setUrl(final String url)
	{
		this.url = url;
	}

}
