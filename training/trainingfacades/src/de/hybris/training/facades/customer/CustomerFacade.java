package de.hybris.training.facades.customer;

import de.hybris.platform.commercefacades.user.data.CustomerData;

import java.util.List;

public interface CustomerFacade
{
    public List<CustomerData> getCustomer(String customerId);
}
