package de.hybris.training.core.service;



import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.training.core.Dao.CustomerTrainingDao;

import javax.annotation.Resource;
import java.util.List;

public class CustomerServices {

    @Resource
    private CustomerTrainingDao customerTrainingDao;

    public List<CustomerModel> getCustomer(final String customerId)
    {
        List<CustomerModel> customerModels=customerTrainingDao.getCustomerByCode(customerId);
        return customerModels;
    }



}
