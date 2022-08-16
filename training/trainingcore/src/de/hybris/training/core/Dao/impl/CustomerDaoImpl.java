package de.hybris.training.core.Dao.impl;

import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.servicelayer.internal.dao.AbstractItemDao;
import de.hybris.platform.servicelayer.search.SearchResult;
import de.hybris.platform.servicelayer.util.ServicesUtil;
import de.hybris.training.core.Dao.CustomerTrainingDao;
import org.apache.log4j.Logger;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerDaoImpl extends AbstractItemDao implements CustomerTrainingDao {

    private static final Logger LOGGER= Logger.getLogger(CustomerDaoImpl.class);
    private static final String CUSTOMER_QUERY = "SELECT{" +CustomerModel.PK+ "}FROM{"+CustomerModel._TYPECODE+ "}WHERE{" +CustomerModel.CUSTOMERID+ "}=?code";

    @Override
    public List<CustomerModel> getCustomerByCode(String customerId)
    {
        ServicesUtil.validateParameterNotNull(customerId, "Customer ID must not be null");
        final Map<String, Object> params = new HashMap<>();
        params.put("code", customerId);
        LOGGER.info(getFlexibleSearchService().search(CUSTOMER_QUERY, params).getClass());
        final SearchResult<CustomerModel> customer= getFlexibleSearchService().search(CUSTOMER_QUERY,params);
        return customer.getResult()==null ? Collections.emptyList(): customer.getResult();
    }
}
