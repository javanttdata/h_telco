/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.forms;

import java.util.List;


/**
 * Payment Subscriptions Form object.
 *
 */
public class PaymentSubscriptionsForm
{
	List<String> subscriptionsToChange;
	String newPaymentMethodId;

	public List<String> getSubscriptionsToChange()
	{
		return subscriptionsToChange;
	}

	public void setSubscriptionsToChange(final List<String> subscriptionsToChange)
	{
		this.subscriptionsToChange = subscriptionsToChange;
	}

	public String getNewPaymentMethodId()
	{
		return newPaymentMethodId;
	}

	public void setNewPaymentMethodId(final String newPaymentMethodId)
	{
		this.newPaymentMethodId = newPaymentMethodId;
	}
}
