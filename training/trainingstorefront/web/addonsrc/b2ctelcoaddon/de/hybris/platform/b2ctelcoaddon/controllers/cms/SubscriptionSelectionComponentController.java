/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.cms;

import de.hybris.platform.addonsupport.controllers.cms.AbstractCMSAddOnComponentController;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.model.SubscriptionSelectionComponentModel;
import de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionSelectionData;
import de.hybris.platform.b2ctelcofacades.user.TmaCustomerFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.servicelayer.session.SessionService;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import static de.hybris.platform.b2ctelcoservices.constants.B2ctelcoservicesConstants.SELECTED_PROCESS_TYPE;


/**
 * Controller for CMS {@link SubscriptionSelectionComponentModel} component.
 *
 * @since 6.7
 */
@Controller("SubscriptionSelectionComponentController")
@RequestMapping(value = TelcoControllerConstants.Actions.Cms.SUBSCRIPTION_SELECTION_COMPONENT)
public class SubscriptionSelectionComponentController
		extends AbstractCMSAddOnComponentController<SubscriptionSelectionComponentModel>
{
	@Resource(name = "customerFacade")
	private TmaCustomerFacade customerFacade;

	@Resource(name = "sessionService")
	private SessionService sessionService;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model, final SubscriptionSelectionComponentModel component)
	{
		final String selectedProcess = getSessionService().getAttribute(SELECTED_PROCESS_TYPE);
		if (StringUtils.isNotEmpty(selectedProcess))
		{
			final Map<String, List<TmaSubscriptionSelectionData>> eligibleSubscriptionSelections = getCustomerFacade()
					.determineEligibleSubscriptionSelections(TmaProcessType.valueOf(selectedProcess));
			model.addAttribute("subscriptions", eligibleSubscriptionSelections);
		}

		model.addAttribute("processType", selectedProcess);
	}

	protected TmaCustomerFacade getCustomerFacade()
	{
		return customerFacade;
	}

	protected SessionService getSessionService()
	{
		return sessionService;
	}
}
