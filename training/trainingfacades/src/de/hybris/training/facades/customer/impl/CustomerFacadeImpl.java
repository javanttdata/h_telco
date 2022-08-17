package de.hybris.training.facades.customer.impl;

import de.hybris.platform.commercefacades.user.data.CustomerData;
import de.hybris.platform.converters.Converters;
import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.training.core.service.CustomerServices;
import de.hybris.training.facades.customer.CustomerFacade;

import java.util.List;

public class CustomerFacadeImpl implements CustomerFacade {

    private CustomerServices customerServices;
    private Converter<CustomerModel, CustomerData> customerConverter;


    @Override
    public List<CustomerData> getCustomer(String customerId) {

        final List<CustomerModel> customerModels = customerServices.getCustomer(customerId);
        return Converters.convertAll(customerModels, getCustomerConverter());
    }

    @Override
    public void updateCustomerFacade(CustomerModel customerModel) {
        customerServices.updateCustomerService(customerModel);

    }

    public CustomerServices getCustomerServices(){

        return customerServices;
    }

    public void setCustomerServices(final CustomerServices customerServices){
        this.customerServices = customerServices;
    }

    public Converter<CustomerModel, CustomerData> getCustomerConverter(){
        return customerConverter;
    }

    public void setCustomerConverter(final Converter<CustomerModel, CustomerData> customerConverter){
        this.customerConverter = customerConverter;
    }
}
