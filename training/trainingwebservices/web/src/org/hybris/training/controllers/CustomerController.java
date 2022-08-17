package org.hybris.training.controllers;


import de.hybris.platform.commercewebservicescommons.dto.Customer.CustomerDataListWSDTO;
import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.webservicescommons.mapping.DataMapper;
import de.hybris.platform.webservicescommons.swagger.ApiBaseSiteIdParam;
import de.hybris.training.facades.customer.CustomerFacade;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.Authorization;
import org.anchor.queues.data.CustomerDataList;
import org.apache.log4j.Logger;
//import org.hybris.training.dto.CustomerCreateDTO;
import org.hybris.training.dto.CustomerCreateDTO;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

import static org.hybris.training.controllers.SampleController.DEFAULT_FIELD_SET;

@Controller
@RequestMapping(value="/customer")
@Api(tags="Customer")
public class CustomerController {

    private static final Logger LOGGER= Logger.getLogger(CustomerController.class);

    @Resource(name = "dataMapper")
    private DataMapper dataMapper;

    @Resource(name="customerTrainingFacade")
    private CustomerFacade customerFacade;

    @RequestMapping(value = "/registerCustomerProfile", method = RequestMethod.POST)
    @ResponseBody
    @ApiOperation(nickname = "registerCustomer",
            value = "Register a customer",
            notes = "Register a new customer.",
            authorizations = {@Authorization(value = "oauth2_client_credentials")})
    @ApiBaseSiteIdParam
    public void registerCustomerProfile() {

    }

    @RequestMapping(value = "/getCustomerProfile", method = RequestMethod.GET)
    @ResponseBody
    @ApiOperation(nickname = "getCustomerProfile",
            value = "Get a customer profile",
            notes = "Get an existing customer profile.",
            authorizations = {@Authorization(value = "oauth2_client_credentials")})

    @ApiBaseSiteIdParam
    public CustomerDataListWSDTO getCustomer(@ApiParam(value="customerId", required = true)

    @PathVariable
    final String customerId, @ApiParam(value="Response configuaration. This is the list of filelds that should be returned in the response body", allowableValues="BASIC,DEFAULT,FULL")
    @RequestParam(defaultValue=DEFAULT_FIELD_SET) final String fields)
    {
        LOGGER.info("Student is "+customerId);
        final CustomerDataList customerDataList=new CustomerDataList();
        customerDataList.setCustomer(customerFacade.getCustomer(customerId));
        return dataMapper.map(customerDataList, CustomerDataListWSDTO.class, fields);
    }

    @RequestMapping(value = "/updateCustomerProfile", method = RequestMethod.PUT)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    @ApiOperation(nickname = "updateCustomerProfile",
            value = "Update a customer profile",
            notes = "Update an existing customer profile by ID.",
            authorizations = {@Authorization(value = "oauth2_client_credentials")})
    @ApiBaseSiteIdParam
    public void updateCustomer(@RequestBody CustomerCreateDTO customerCreateDTO){
        CustomerModel customerModel = new CustomerModel();
        convertToData(customerCreateDTO, customerModel);
        customerFacade.updateCustomerFacade(customerModel);
    }



    @RequestMapping(value = "/deleteCustomerProfile", method = RequestMethod.DELETE)
    @ResponseBody
    @ApiOperation(nickname = "deleteCustomerProfile",
            value = "Delete a customer profile",
            notes = "Delete an existing cutomer profile.",
            authorizations = {@Authorization(value = "oauth2_client_credentials")})
    @ApiBaseSiteIdParam
    public void deleteCustomerProfile() {

    }

    private CustomerModel convertToData(CustomerCreateDTO customerCreateDTO, CustomerModel customerModel) {
        customerModel.setCustomerID(customerCreateDTO.getCustomerId());

        return customerModel;
    }
}

