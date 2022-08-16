/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.cms;

import de.hybris.platform.addonsupport.controllers.cms.AbstractCMSAddOnComponentController;
import de.hybris.platform.b2ctelcoaddon.constants.B2ctelcoaddonWebConstants;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.model.ServiceUsageUpSellComponentModel;
import de.hybris.platform.b2ctelcofacades.subscription.TmaSubscribedProductFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaAccessType;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.servicelayer.util.ServicesUtil;
import de.hybris.platform.subscriptionfacades.exceptions.SubscriptionFacadeException;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Component controller that displays controller for up sell products of a subscription service usage.
 *
 * @since 6.7
 */
@Controller("ServiceUsageUpSellComponentController")
@RequestMapping(value = TelcoControllerConstants.Actions.Cms.SERVICE_USAGE_UPSELL_COMPONENT)
public class ServiceUsageUpSellComponentController extends AbstractCMSAddOnComponentController<ServiceUsageUpSellComponentModel>
{
	private static final Logger LOG = Logger.getLogger(ServiceUsageUpSellComponentController.class);

	@Resource(name = "tmaSubscribedProductFacade")
	private TmaSubscribedProductFacade tmaSubscribedProductFacade;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model, final ServiceUsageUpSellComponentModel component)
	{
		ServicesUtil.validateParameterNotNull(component, B2ctelcoaddonWebConstants.CMSCOMPONENT_NOTNULL);
		Set<ProductData> productDatas = new HashSet<>();
		final String billingSystemId = (String) request.getAttribute(B2ctelcoaddonWebConstants.BILLING_SYSTEM_ID);
		final String subscriberIdentity = (String) request.getAttribute(B2ctelcoaddonWebConstants.SUBSCRIBER_IDENTITY);

		try
		{
			final String accessType = getTmaSubscribedProductFacade().getSubscriptionAccessByPrincipalAndSubscriptionBase(
					billingSystemId,
					subscriberIdentity);
			if (TmaAccessType.OWNER.getCode().equalsIgnoreCase(accessType)
					|| TmaAccessType.ADMINISTRATOR.getCode().equalsIgnoreCase(accessType))
			{
				productDatas = getTmaSubscribedProductFacade().getServiceUsageUpSellProducts(subscriberIdentity,
						billingSystemId);
			}
		}
		catch (final SubscriptionFacadeException e)
		{
			LOG.error("Error while retrieving upsell products for service usage", e);
		}
		model.addAttribute(B2ctelcoaddonWebConstants.TITLE, component.getTitle());
		model.addAttribute(B2ctelcoaddonWebConstants.PRODUCT_ADDONS, productDatas);
	}

	protected TmaSubscribedProductFacade getTmaSubscribedProductFacade()
	{
		return tmaSubscribedProductFacade;
	}

	public void setTmaSubscribedProductFacade(final TmaSubscribedProductFacade tmaSubscribedProductFacade)
	{
		this.tmaSubscribedProductFacade = tmaSubscribedProductFacade;
	}


}
