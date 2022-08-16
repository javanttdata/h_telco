/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package org.hybris.training.facades;

import de.hybris.platform.core.servicelayer.data.SearchPageData;

import java.util.List;

import org.hybris.training.data.UserData;
import org.hybris.training.dto.SampleWsDTO;
import org.hybris.training.dto.TestMapWsDTO;


public interface SampleFacades
{
	SampleWsDTO getSampleWsDTO(final String value);

	UserData getUser(String id);

	List<UserData> getUsers();

	SearchPageData<UserData> getUsers(SearchPageData<?> params);

	TestMapWsDTO getMap();
}
