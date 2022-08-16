/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.forms;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;


/**
 * Validation form for Deleting a bundle.
 */
public class DeleteBundleForm
{
	@NotNull(message = "{basket.error.groupno.notNull}")
	@Min(value = 0, message = "{basket.error.groupno.invalid}")
	@Digits(fraction = 0, integer = 10, message = "{basket.error.groupno.invalid}")
	private int entryNumber;
	private int groupNumber;

	public int getEntryNumber()
	{
		return entryNumber;
	}

	public void setEntryNumber(final int entryNumber)
	{
		this.entryNumber = entryNumber;
	}

	public int getGroupNumber()
	{
		return groupNumber;
	}

	public void setGroupNumber(final int groupNumber)
	{
		this.groupNumber = groupNumber;
	}
}
