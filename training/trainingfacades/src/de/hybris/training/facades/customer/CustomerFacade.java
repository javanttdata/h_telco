package de.hybris.training.facades.customer;

import de.hybris.platform.commercefacades.user.data.CustomerData;
import de.hybris.platform.core.model.user.CustomerModel;

import java.util.List;

public interface CustomerFacade
{
    public List<CustomerData> getCustomer(String customerId);

    void updateCustomerFacade(CustomerModel customerModel);
}
