/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.filters;

import de.hybris.platform.b2ctelcoservices.compatibility.eligibility.TmaEligibilityContextService;
import de.hybris.platform.b2ctelcoservices.eligibility.data.TmaEligibilityContext;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.web.filter.OncePerRequestFilter;


/**
 * Filter responsible for updating the {@link TmaEligibilityContext} for the current user.
 *
 * @since 1810
 */
public class TmaEligibilityContextFilter extends OncePerRequestFilter
{
	private TmaEligibilityContextService eligibilityContextService;

	@Override
	protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
			FilterChain filterChain) throws ServletException, IOException
	{
		getEligibilityContextService().updateEligibilityContexts(false);
		filterChain.doFilter(httpServletRequest, httpServletResponse);
	}

	protected TmaEligibilityContextService getEligibilityContextService()
	{
		return eligibilityContextService;
	}

	@Required
	public void setEligibilityContextService(final TmaEligibilityContextService eligibilityContextService)
	{
		this.eligibilityContextService = eligibilityContextService;
	}
}
