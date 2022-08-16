/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.constants;

/**
 * Global class for all B2ctelcoaddon web constants. You can add global constants for your extension into this class.
 */
public final class B2ctelcoaddonWebConstants
{
	private static final String EXTENSIONNAME = "b2ctelcoaddon";

	public static final String BREADCRUMBS_KEY = "breadcrumbs";

	public static final String SUPERCATEGORIES_KEY = "supercategories";

	public static final String MODEL_KEY_ADDITIONAL_BREADCRUMB = "additionalBreadcrumb";

	public static final String CONTINUE_URL = "session_continue_url";

	public static final String CART_RESTORATION = "cart_restoration";

	public static final String ANONYMOUS_CHECKOUT = "anonymous_checkout";

	public static final String URL_ENCODING_ATTRIBUTES = "encodingAttributes";

	public static final String LANGUAGE_ENCODING = "languageEncoding";

	public static final String CURRENCY_ENCODING = "currencyEncoding";

	//Subscription Constant
	public static final String TEXT_ACCOUNT_SUBSCRIPTION = "text.account.subscriptions";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM = "text.account.subscription.extendTerm";
	public static final String ACCOUNT_SUBSCRIPTION_EXTENDTERM_DEFAULT_MSG = "Extend Subscription by {1} {0}";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM_SUCCESS = "text.account.subscription.extendTerm.success";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_EXTENDTERM_UNABLE = "text.account.subscription.extendTerm.unable";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_REPLACEPAYMNETMETHOD_SUCCESS = "text.account.subscription.replacePaymentMethod.success";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_REPLACEPAYMNETMETHOD_UNABLE = "text.account.subscription.replacePaymentMethod.unable";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_CHANGEAUTORENEW_SUCCESS = "text.account.subscription.changeAutorenew.success";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_CHANGEAUTORENEW_UNABLE = "text.account.subscription.changeAutorenew.unable";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_SUBSCRIPTIONBREADCRUM = "text.account.subscription.subscriptionBreadcrumb";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_CHANGESTATE_SUCCESS = "text.account.subscription.changeState.success";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_CHANGESTATE_UNABLE = "text.account.subscription.changeState.unable";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_CANCEL_UNABLE = "text.account.subscription.cancel.unable";
	public static final String TEXT_ACCOUNT_SUBSCRIPTION_SUBSCRIPTIONBASE = "text.account.subscription.subscriptionBase";
	public static final String TEXT_BASKET_INFO_QUANTITY_NOITEMADDED = "basket.information.quantity.noItemsAdded.";
	public static final String TEXT_BASKET_INFO_QUANTITY_REDUCEDNUMITEMADDED = "basket.information.quantity.reducedNumberOfItemsAdded.";
	public static final String SUBSCRIPTION_DATA = "subscriptionData";
	public static final String METAROBOTS = "metaRobots";
	public static final String NOINDEX_NOFOLLOW = "no-index,no-follow";
	public static final String ERROR_MSG = "errorMsg";
	public static final String SUBINFOMAP = "subscriptionInfoMap";
	public static final String PAYMENTINFOMAP = "paymentInfoMap";
	public static final String EXTENSION_OPTIONS = "extensionOptions";
	public static final String PAYMENTINFOS = "paymentInfos";
	public static final String SUBSCRIPTION_PRODUCT_DATA = "subscriptionProductData";
	public static final String UPGRADABLE = "upgradable";
	public static final String UPSELLING_OPTION = "upsellingOptions";
	public static final String CART_DATA = "cartData";
	public static final String ACTION_VAL = "actionVal";
	public static final String SUBSCRIPTION_FACADE = "tmaSubscribedProductFacade";
	public static final String SUBSCRIBER_IDENTITY = "subscriberIdentity";
	public static final String SUBSCRIPTIONBASE_SERVICES_VALUE_MAP = "subscriptionBaseServicesWithValue";
	public static final String BILLING_SYSTEM_ID = "billingSystemId";
	public static final String CMSCOMPONENT_NOTNULL = "CMSComponent must not be null";
	public static final String TITLE = "title";
	public static final String PRODUCT_ADDONS = "productAddons";
	public static final String MODIFIED_CARTDATA = "modifiedCartData";
	public static final String UPGRADE_PREVIEWDATA = "upgradePreviewData";
	public static final String TAB_ID = "tabId";
	public static final String SUB_PROD_DATA = "subProdData";
	public static final String UPGRADE_DATA = "upgradeData";
	public static final String FORM_GLOBAL_ERROR = "form.global.error";
	public static final String DATE_FORMAT = "dd MMMM yyyy";
	public static final String BILLING_ACTIVITIES = "billingActivities";
	public static final String PRODUCT_DATA = "productdata";
	public static final String FILTER_PRODUCT_TYPES = EXTENSIONNAME + ".filterProductTypes";

	private B2ctelcoaddonWebConstants()
	{
		//empty to avoid instantiating this constant class
	}

	// implement here constants used by this extension
}
