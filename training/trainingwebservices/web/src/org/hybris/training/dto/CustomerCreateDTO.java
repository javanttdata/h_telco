package org.hybris.training.dto;

import de.hybris.platform.jalo.c2l.Currency;
import de.hybris.training.core.constants.GeneratedTrainingCoreConstants;
import de.hybris.training.core.jalo.DefaultAddress;

public class CustomerCreateDTO {

    private String customerBirthdate;

    private String customerCpf;

    private Currency currency;

    private String customerId;

    private DefaultAddress defaultAddress;


    public CustomerCreateDTO(String customerBirthdate, String customerCpf, Currency currency, String customerId, DefaultAddress defaultAddress) {
        this.customerBirthdate = customerBirthdate;
        this.customerCpf = customerCpf;
        this.currency = currency;
        this.customerId = customerId;
        this.defaultAddress = defaultAddress;
    }

    public String getCustomerBirthdate() {
        return customerBirthdate;
    }

    public void setCustomerBirthdate(String customerBirthdate) {
        this.customerBirthdate = customerBirthdate;
    }

    public String getCustomerCpf() {
        return customerCpf;
    }

    public void setCustomerCpf(String customerCpf) {
        this.customerCpf = customerCpf;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public DefaultAddress getDefaultAddress() {
        return defaultAddress;
    }

    public void setDefaultAddress(DefaultAddress defaultAddress) {
        this.defaultAddress = defaultAddress;
    }
}


//{
//
//
//        "deactivationDate": "2022-08-05T12:54:08.004Z",
//
//
//        "defaultAddress": {
//        "apartment": "string",
//        "billingAddress": true,
//        "building": "string",
//        "cellphone": "string",
//        "companyName": "string",
//        "complement": "string",
//        "country": {
//        "isocode": "string",
//        "name": "string"
//        },
//        "defaultAddress": true,
//        "district": "string",
//        "email": "string",
//        "firstName": "string",
//        "formattedAddress": "string",
//        "id": "string",
//        "installationAddress": true,
//        "lastName": "string",
//        "line1": "string",
//        "line2": "string",
//        "phone": "string",
//        "postalCode": "string",
//        "referencePoint": "string",
//        "region": {
//        "countryIso": "string",
//        "isocode": "string",
//        "isocodeShort": "string",
//        "name": "string",
//        "role": "string"
//        },
//        "riskArea": true,
//        "shippingAddress": true,
//        "title": "string",
//        "titleCode": "string",
//        "town": "string",
//        "visibleInAddressBook": true
//        },
//        "displayUid": "string",
//        "email": "string",
//        "firstName": "string",
//        "identifications": [
//        {
//        "identificationNumber": "string",
//        "identificationType": "string"
//        }
//        ],
//        "language": {
//        "active": true,
//        "isocode": "string",
//        "name": "string",
//        "nativeName": "string"
//        },
//        "lastName": "string",
//        "mobilePhone": "string",
//        "mobilephone": "string",
//        "mothersName": "string",
//        "name": "string",
//        "nickname": "string",
//        "smsNotifications": true,
//        "title": "string",
//        "titleCode": "string",
//        "uid": "string",
//        "whatsappNotifications": true,
//        "rg": "string",
//        "passport": "string"
//        }