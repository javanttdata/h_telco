/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package org.hybris.training.constants;

/**
 * Global class for all Trainingwebservices constants. You can add global constants for your extension into this class.
 */
@SuppressWarnings({"deprecation","squid:CallToDeprecatedMethod"})
public final class TrainingwebservicesConstants extends GeneratedTrainingwebservicesConstants
{
	public static final String EXTENSIONNAME = "trainingwebservices";
	public static final String AUTHORIZATION_SCOPE_PROPERTY = EXTENSIONNAME + ".oauth.scope";
	public static final String LICENSE_URL_PROPERTY = EXTENSIONNAME + ".license.url";
	public static final String TERMS_OF_SERVICE_URL_PROPERTY = EXTENSIONNAME + ".terms.of.service.url";
	public static final String LICENSE_PROPERTY = EXTENSIONNAME + ".licence";
	public static final String DOCUMENTATION_DESC_PROPERTY = EXTENSIONNAME + ".documentation.desc";
	public static final String DOCUMENTATION_TITLE_PROPERTY = EXTENSIONNAME + ".documentation.title";
	public static final String API_VERSION = "1.0.0";

	public static final String AUTHORIZATION_URL = "/authorizationserver/oauth/token";
    @SuppressWarnings("squid:S2068")
	public static final String PASSWORD_AUTHORIZATION_NAME = "oauth2_password";
	public static final String CLIENT_CREDENTIAL_AUTHORIZATION_NAME = "oauth2_client_credentials";

	public static final String SAMPLE_MAP_STRING_KEY = "StringKey";
	public static final String SAMPLE_MAP_STRING_VALUE = "StringValue";
	public static final String SAMPLE_MAP_INTEGER_KEY = "integerKey";
	public static final int SAMPLE_MAP_INTEGER_VALUE = 10001;

	public static final String SAMPLE_LIST_STRING_VALUE = "new String";
	public static final double SAMPLE_LIST_DOUBLE_VALUE = 0.123d;

	public static final String HOST = "trainingwebservices.host";
	public static final String HOST_DEFAULT = "hostname";

	private TrainingwebservicesConstants()
	{
		//empty to avoid instantiating this constant class
	}

	// implement here constants used by this extension
}
