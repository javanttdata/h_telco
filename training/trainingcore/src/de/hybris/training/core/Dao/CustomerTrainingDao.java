package de.hybris.training.core.Dao;

import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.servicelayer.internal.dao.Dao;

import java.util.List;

public interface CustomerTrainingDao extends Dao {
    List<CustomerModel> getCustomerByCode(String customerId);
}
