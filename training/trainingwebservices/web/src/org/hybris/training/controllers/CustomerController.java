package org.hybris.training.controllers;


import de.hybris.platform.webservicescommons.mapping.DataMapper;
import de.hybris.platform.webservicescommons.swagger.ApiBaseSiteIdParam;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.Authorization;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping(value="/customer")
@Api(tags="Customer")
public class CustomerController {

    @Resource(name = "dataMapper")
    private DataMapper dataMapper;

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
    public void getCustomerProfile() {

    }

    @RequestMapping(value = "/updateCustomerProfile", method = RequestMethod.PUT)
    @ResponseBody
    @ApiOperation(nickname = "updateCustomerProfile",
            value = "Update a customer profile",
            notes = "Update an existing cutomer profile.",
            authorizations = {@Authorization(value = "oauth2_client_credentials")})
    @ApiBaseSiteIdParam
    public void updateCustomerProfile() {

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
}

