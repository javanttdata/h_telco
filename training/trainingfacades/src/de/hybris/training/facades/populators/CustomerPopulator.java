package de.hybris.training.facades.populators;


import de.hybris.platform.commercefacades.Currency.data.CurrencyData;
import de.hybris.platform.commercefacades.Customer.data.CustomerData;
import de.hybris.platform.commercefacades.Language.data.LanguageData;
import de.hybris.platform.commercefacades.address.data.AddressData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.core.model.c2l.LanguageModel;
import de.hybris.platform.core.model.user.AddressModel;
import de.hybris.platform.core.model.user.CustomerModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;

public class CustomerPopulator  implements Populator<CustomerModel, CustomerData> {

    @Override
    public void populate(final CustomerModel source, final CustomerData target)
            throws ConversionException
    {
        target.setFirstName(source.getFirstName());
        target.setLastName(source.getLastName());
        target.setName(source.getName());
        target.setNickname(source.getNickname());

        target.setUid(source.getUid());
        target.setCustomerId(source.getCustomerID());
        target.setAddress(converterModeltoData(source.getAddress()));

        target.setDisplayUid(Boolean.valueOf(source.getDisplayuid()));
        target.setEmail(source.getContactEmail());
        target.setDeactivationDate(String.valueOf(source.getDeactivationDate()));
        target.setIdentifications(target.getIdentifications());
        //target.setTitle(String.valueOf(source.getTitle()));
        target.setTitleCode(source.getTitleCode());

        target.setBirthdate(source.getBirthdate());
        target.setCpf(source.getCpf());
        target.setRg(source.getRg());
        target.setMothersName(source.getMothersName());
        target.setPassport(source.getPassport());

        target.setMobilephone(source.getMobilephone());

        target.setWhatsappNotifications(source.getWhatsappNotifications());
        target.setSmsNotifications(source.getSmsNotifications());

        target.setAddress(converterModeltoData(source.getAddress()));
        target.setLanguage(converterModeltoData((source.getLanguage())));

    }

    private AddressData converterModeltoData(AddressModel addressModel) {
        AddressData addressData = new AddressData();
        return addressData;
    }

    private LanguageData converterModeltoData(LanguageModel languageModel) {
        LanguageData languageData = new LanguageData();
        return languageData;
    }


}
