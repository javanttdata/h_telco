/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.controllers.cms;

import de.hybris.platform.addonsupport.controllers.cms.AbstractCMSAddOnComponentController;
import de.hybris.platform.b2ctelcoaddon.controllers.TelcoControllerConstants;
import de.hybris.platform.b2ctelcoaddon.forms.TmaProcessTypeForm;
import de.hybris.platform.b2ctelcoaddon.model.TmaProcessTypeListingComponentModel;
import de.hybris.platform.b2ctelcofacades.purchaseflow.TmaProcessTypeFacade;
import de.hybris.platform.b2ctelcofacades.user.TmaCustomerFacade;
import de.hybris.platform.b2ctelcoservices.enums.TmaProcessType;
import de.hybris.platform.servicelayer.session.SessionService;

import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import static de.hybris.platform.b2ctelcoservices.constants.B2ctelcoservicesConstants.SELECTED_PROCESS_TYPE;


/**
 * Controller for CMS {@link TmaProcessTypeListingComponentModel} component
 *
 * @since 6.7
 */
@Controller("TmaProcessTypeListingComponentController")
@RequestMapping(value = TelcoControllerConstants.Actions.Cms.TMA_PROCESSTYPE_LISTING_COMPONENT)
public class TmaProcessTypeListingComponentController
		extends AbstractCMSAddOnComponentController<TmaProcessTypeListingComponentModel>
{
	private static final String PROCESS_TYPES = "processTypes";
	private static final String TMA_PROCESS_TYPE_FORM = "tmaProcessTypeForm";

	@Resource(name = "tmaProcessTypeFacade")
	private TmaProcessTypeFacade tmaProcessTypeFacade;

	@Resource(name = "sessionService")
	private SessionService sessionService;

	@Resource(name = "customerFacade")
	private TmaCustomerFacade tmaCustomerFacade;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model,
			final TmaProcessTypeListingComponentModel component)
	{
		addValidProcessTypes(model, component);

		final String selectedProcessType = getSessionService().getAttribute(SELECTED_PROCESS_TYPE);
		model.addAttribute(SELECTED_PROCESS_TYPE, selectedProcessType);

		final TmaProcessTypeForm tmaProcessTypeForm = new TmaProcessTypeForm();
		tmaProcessTypeForm.setProcessTypeName(selectedProcessType);
		model.addAttribute(TMA_PROCESS_TYPE_FORM, tmaProcessTypeForm);
	}

	private void addValidProcessTypes(final Model model, final TmaProcessTypeListingComponentModel component)
	{
		final Set<TmaProcessType> configuredProcessTypes = component.getProcessTypes();
		final Set<TmaProcessType> eligibleProcessTypes = getTmaCustomerFacade().retrieveEligibleProcessTypes();

		final Set<TmaProcessType> validProcessTypes = configuredProcessTypes.stream()
				.filter(processType -> eligibleProcessTypes.contains(processType)).collect(Collectors.toSet());

		model.addAttribute(PROCESS_TYPES, getTmaProcessTypeFacade().getProcessTypeNamesFromEnums(validProcessTypes));
	}

	protected TmaCustomerFacade getTmaCustomerFacade()
	{
		return tmaCustomerFacade;
	}

	protected SessionService getSessionService()
	{
		return sessionService;
	}

	protected TmaProcessTypeFacade getTmaProcessTypeFacade()
	{
		return tmaProcessTypeFacade;
	}
}
