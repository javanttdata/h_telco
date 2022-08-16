/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package org.hybris.training;

import org.apache.log4j.Logger;


/**
 * Simple test class to demonstrate how to include utility classes to your webmodule.
 */
public class TrainingwebservicesWebHelper
{
	/** Edit the local|project.properties to change logging behavior (properties log4j.*). */
	@SuppressWarnings("unused")
	private static final Logger LOG = Logger.getLogger(TrainingwebservicesWebHelper.class.getName());

	private TrainingwebservicesWebHelper()
	{
	}

	public static final String getTestOutput()
	{
		return "testoutput";
	}
}
