package de.hybris.training.facades.populators;

import de.hybris.platform.commercefacades.Customer.data.CustomerData;
import de.hybris.platform.commercefacades.address.data.AddressData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.core.model.c2l.CountryModel;
import de.hybris.platform.core.model.user.AddressModel;
import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.servicelayer.model.ModelService;
import de.hybris.platform.storelocator.jalo.PointOfService;

public class CustomerReversePopulator implements Populator<CustomerData, CustomerModel> {

    private ModelService modelService;

    @Override
    public void populate(CustomerData source, CustomerModel target) throws ConversionException {
        target.setFirstName(source.getFirstName());
        target.setLastName(source.getLastName());
        target.setName(source.getName());
        target.setNickname(source.getNickname());
        target.setUid(source.getUid());
        target.setCustomerID(source.getCustomerId());
       // target.setAddress(converterModeltoData(source.getAddress()));

       // target.setDisplayuid(Boolean.valueOf(source.getDisplayUid()));
        // target.setEmail(source.getContactEmail());
       // target.setDeactivationDate(String.valueOf(source.getDeactivationDate()));
        target.setIdentifications(target.getIdentifications());
//        target.setTitle(String.valueOf(source.getTitle()));
        target.setTitleCode(source.getTitleCode());

        target.setBirthdate(source.getBirthdate());
        target.setCpf(source.getCpf());
        target.setRg(source.getRg());
        target.setMothersName(source.getMothersName());
        target.setPassport(source.getPassport());

        target.setMobilephone(source.getMobilephone());

        target.setWhatsappNotifications(source.getWhatsappNotifications());
        target.setSmsNotifications(source.getSmsNotifications());

     
//        target.setAddress(populateToAddresModel(source.getAddress()));
    }

//    private AddressModel populateToAddresModel(AddressData address) {
//        AddressModel addressModel = modelService.create(AddressModel.class);
//        addressModel.setBillingAddress(address.isBillingAddress());
//        addressModel.setBuilding(address.getBuilding());
//        addressModel.setCellphone(address.getCellphone());
//        addressModel.setCountry(populateToCountryModel(address.getCountry()));
//        addressModel.setOwner(modelService.create(PointOfService.class));
//
//        return addressModel;
//    }

//    private CountryModel populateToCountryModel(CountryForm country) {
//        CountryModel countryModel = modelService.create(CountryModel.class);
//        countryModel.setName(country.getName());
//        countryModel.setIsocode(country.getIsocode());
//        return countryModel;
//    }

    public ModelService getModelService() {
        return modelService;
    }

    public void setModelService(ModelService modelService) {
        this.modelService = modelService;
    }
}
