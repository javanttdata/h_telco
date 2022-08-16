/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.forms;


import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


/**
 * Form for process type selection.
 *
 * @since 6.7
 */
public class TmaProcessTypeForm
{

	@NotNull(message = "{processType.name.invalid}")
	@Size(min = 1, max = 255, message = "{processType.name.invalid}")
	private String processTypeName;

	public String getProcessTypeName()
	{
		return processTypeName;
	}

	public void setProcessTypeName(final String processTypeName)
	{
		this.processTypeName = processTypeName;
	}
}
