/*
 * ----------------------------------------------------------------
 * --- WARNING: THIS FILE IS GENERATED AND WILL BE OVERWRITTEN! ---
 * --- Generated at 16 de ago de 2022 10:35:44                  ---
 * ----------------------------------------------------------------
 *  
 * Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.training.core.jalo;

import de.hybris.platform.jalo.GenericItem;
import de.hybris.platform.jalo.Item;
import de.hybris.platform.jalo.Item.AttributeMode;
import de.hybris.platform.jalo.JaloBusinessException;
import de.hybris.platform.jalo.JaloSystemException;
import de.hybris.platform.jalo.SessionContext;
import de.hybris.platform.jalo.c2l.C2LItem;
import de.hybris.platform.jalo.c2l.Country;
import de.hybris.platform.jalo.c2l.Currency;
import de.hybris.platform.jalo.c2l.Language;
import de.hybris.platform.jalo.c2l.Region;
import de.hybris.platform.jalo.extension.Extension;
import de.hybris.platform.jalo.type.ComposedType;
import de.hybris.platform.jalo.type.JaloGenericCreationException;
import de.hybris.platform.jalo.user.Address;
import de.hybris.platform.jalo.user.Customer;
import de.hybris.platform.jalo.user.User;
import de.hybris.training.core.constants.TrainingCoreConstants;
import de.hybris.training.core.jalo.ApparelProduct;
import de.hybris.training.core.jalo.ApparelSizeVariantProduct;
import de.hybris.training.core.jalo.ApparelStyleVariantProduct;
import de.hybris.training.core.jalo.DefaultAddress;
import de.hybris.training.core.jalo.ElectronicsColorVariantProduct;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Generated class for type <code>TrainingCoreManager</code>.
 */
@SuppressWarnings({"deprecation","unused","cast"})
public abstract class GeneratedTrainingCoreManager extends Extension
{
	protected static final Map<String, Map<String, AttributeMode>> DEFAULT_INITIAL_ATTRIBUTES;
	static
	{
		final Map<String, Map<String, AttributeMode>> ttmp = new HashMap();
		Map<String, AttributeMode> tmp = new HashMap<String, AttributeMode>();
		tmp.put("currencyname", AttributeMode.INITIAL);
		ttmp.put("de.hybris.platform.jalo.c2l.Currency", Collections.unmodifiableMap(tmp));
		tmp = new HashMap<String, AttributeMode>();
		tmp.put("nativename", AttributeMode.INITIAL);
		ttmp.put("de.hybris.platform.jalo.c2l.Language", Collections.unmodifiableMap(tmp));
		tmp = new HashMap<String, AttributeMode>();
		tmp.put("countryiso", AttributeMode.INITIAL);
		tmp.put("role", AttributeMode.INITIAL);
		ttmp.put("de.hybris.platform.jalo.c2l.Region", Collections.unmodifiableMap(tmp));
		tmp = new HashMap<String, AttributeMode>();
		tmp.put("address", AttributeMode.INITIAL);
		tmp.put("language", AttributeMode.INITIAL);
		tmp.put("currency", AttributeMode.INITIAL);
		tmp.put("defaultAddress", AttributeMode.INITIAL);
		tmp.put("smsNotifications", AttributeMode.INITIAL);
		tmp.put("displayuid", AttributeMode.INITIAL);
		tmp.put("whatsappNotifications", AttributeMode.INITIAL);
		tmp.put("cpf", AttributeMode.INITIAL);
		tmp.put("mobilephone", AttributeMode.INITIAL);
		tmp.put("mothersName", AttributeMode.INITIAL);
		tmp.put("nickname", AttributeMode.INITIAL);
		tmp.put("titleCode", AttributeMode.INITIAL);
		tmp.put("rg", AttributeMode.INITIAL);
		tmp.put("passport", AttributeMode.INITIAL);
		tmp.put("birthdate", AttributeMode.INITIAL);
		tmp.put("firstName", AttributeMode.INITIAL);
		tmp.put("lastName", AttributeMode.INITIAL);
		tmp.put("country", AttributeMode.INITIAL);
		tmp.put("region", AttributeMode.INITIAL);
		ttmp.put("de.hybris.platform.jalo.user.Customer", Collections.unmodifiableMap(tmp));
		tmp = new HashMap<String, AttributeMode>();
		tmp.put("apartment", AttributeMode.INITIAL);
		tmp.put("companyName", AttributeMode.INITIAL);
		tmp.put("complement", AttributeMode.INITIAL);
		tmp.put("defaultAddress", AttributeMode.INITIAL);
		tmp.put("phone", AttributeMode.INITIAL);
		tmp.put("referencePoint", AttributeMode.INITIAL);
		tmp.put("riskArea", AttributeMode.INITIAL);
		tmp.put("titleCode", AttributeMode.INITIAL);
		tmp.put("formattedAddress", AttributeMode.INITIAL);
		ttmp.put("de.hybris.platform.jalo.user.Address", Collections.unmodifiableMap(tmp));
		DEFAULT_INITIAL_ATTRIBUTES = ttmp;
	}
	@Override
	public Map<String, AttributeMode> getDefaultAttributeModes(final Class<? extends Item> itemClass)
	{
		Map<String, AttributeMode> ret = new HashMap<>();
		final Map<String, AttributeMode> attr = DEFAULT_INITIAL_ATTRIBUTES.get(itemClass.getName());
		if (attr != null)
		{
			ret.putAll(attr);
		}
		return ret;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.address</code> attribute.
	 * @return the address - User address.
	 */
	public Address getAddress(final SessionContext ctx, final Customer item)
	{
		return (Address)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.ADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.address</code> attribute.
	 * @return the address - User address.
	 */
	public Address getAddress(final Customer item)
	{
		return getAddress( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.address</code> attribute. 
	 * @param value the address - User address.
	 */
	public void setAddress(final SessionContext ctx, final Customer item, final Address value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.ADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.address</code> attribute. 
	 * @param value the address - User address.
	 */
	public void setAddress(final Customer item, final Address value)
	{
		setAddress( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.apartment</code> attribute.
	 * @return the apartment - Company name.
	 */
	public String getApartment(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.APARTMENT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.apartment</code> attribute.
	 * @return the apartment - Company name.
	 */
	public String getApartment(final Address item)
	{
		return getApartment( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.apartment</code> attribute. 
	 * @param value the apartment - Company name.
	 */
	public void setApartment(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.APARTMENT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.apartment</code> attribute. 
	 * @param value the apartment - Company name.
	 */
	public void setApartment(final Address item, final String value)
	{
		setApartment( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.birthdate</code> attribute.
	 * @return the birthdate - User's passport info.
	 */
	public String getBirthdate(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.BIRTHDATE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.birthdate</code> attribute.
	 * @return the birthdate - User's passport info.
	 */
	public String getBirthdate(final Customer item)
	{
		return getBirthdate( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.birthdate</code> attribute. 
	 * @param value the birthdate - User's passport info.
	 */
	public void setBirthdate(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.BIRTHDATE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.birthdate</code> attribute. 
	 * @param value the birthdate - User's passport info.
	 */
	public void setBirthdate(final Customer item, final String value)
	{
		setBirthdate( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.companyName</code> attribute.
	 * @return the companyName - Company name.
	 */
	public String getCompanyName(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.COMPANYNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.companyName</code> attribute.
	 * @return the companyName - Company name.
	 */
	public String getCompanyName(final Address item)
	{
		return getCompanyName( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.companyName</code> attribute. 
	 * @param value the companyName - Company name.
	 */
	public void setCompanyName(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.COMPANYNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.companyName</code> attribute. 
	 * @param value the companyName - Company name.
	 */
	public void setCompanyName(final Address item, final String value)
	{
		setCompanyName( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.complement</code> attribute.
	 * @return the complement - Address complement.
	 */
	public String getComplement(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.COMPLEMENT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.complement</code> attribute.
	 * @return the complement - Address complement.
	 */
	public String getComplement(final Address item)
	{
		return getComplement( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.complement</code> attribute. 
	 * @param value the complement - Address complement.
	 */
	public void setComplement(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.COMPLEMENT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.complement</code> attribute. 
	 * @param value the complement - Address complement.
	 */
	public void setComplement(final Address item, final String value)
	{
		setComplement( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.country</code> attribute.
	 * @return the country - User's country info.
	 */
	public Country getCountry(final SessionContext ctx, final Customer item)
	{
		return (Country)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.COUNTRY);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.country</code> attribute.
	 * @return the country - User's country info.
	 */
	public Country getCountry(final Customer item)
	{
		return getCountry( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.country</code> attribute. 
	 * @param value the country - User's country info.
	 */
	public void setCountry(final SessionContext ctx, final Customer item, final Country value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.COUNTRY,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.country</code> attribute. 
	 * @param value the country - User's country info.
	 */
	public void setCountry(final Customer item, final Country value)
	{
		setCountry( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Region.countryiso</code> attribute.
	 * @return the countryiso - Region name.
	 */
	public String getCountryiso(final SessionContext ctx, final Region item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Region.COUNTRYISO);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Region.countryiso</code> attribute.
	 * @return the countryiso - Region name.
	 */
	public String getCountryiso(final Region item)
	{
		return getCountryiso( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Region.countryiso</code> attribute. 
	 * @param value the countryiso - Region name.
	 */
	public void setCountryiso(final SessionContext ctx, final Region item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Region.COUNTRYISO,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Region.countryiso</code> attribute. 
	 * @param value the countryiso - Region name.
	 */
	public void setCountryiso(final Region item, final String value)
	{
		setCountryiso( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.cpf</code> attribute.
	 * @return the cpf - CPF info.
	 */
	public String getCpf(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.CPF);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.cpf</code> attribute.
	 * @return the cpf - CPF info.
	 */
	public String getCpf(final Customer item)
	{
		return getCpf( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.cpf</code> attribute. 
	 * @param value the cpf - CPF info.
	 */
	public void setCpf(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.CPF,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.cpf</code> attribute. 
	 * @param value the cpf - CPF info.
	 */
	public void setCpf(final Customer item, final String value)
	{
		setCpf( getSession().getSessionContext(), item, value );
	}
	
	public ApparelProduct createApparelProduct(final SessionContext ctx, final Map attributeValues)
	{
		try
		{
			ComposedType type = getTenant().getJaloConnection().getTypeManager().getComposedType( TrainingCoreConstants.TC.APPARELPRODUCT );
			return (ApparelProduct)type.newInstance( ctx, attributeValues );
		}
		catch( JaloGenericCreationException e)
		{
			final Throwable cause = e.getCause();
			throw (cause instanceof RuntimeException ?
			(RuntimeException)cause
			:
			new JaloSystemException( cause, cause.getMessage(), e.getErrorCode() ) );
		}
		catch( JaloBusinessException e )
		{
			throw new JaloSystemException( e ,"error creating ApparelProduct : "+e.getMessage(), 0 );
		}
	}
	
	public ApparelProduct createApparelProduct(final Map attributeValues)
	{
		return createApparelProduct( getSession().getSessionContext(), attributeValues );
	}
	
	public ApparelSizeVariantProduct createApparelSizeVariantProduct(final SessionContext ctx, final Map attributeValues)
	{
		try
		{
			ComposedType type = getTenant().getJaloConnection().getTypeManager().getComposedType( TrainingCoreConstants.TC.APPARELSIZEVARIANTPRODUCT );
			return (ApparelSizeVariantProduct)type.newInstance( ctx, attributeValues );
		}
		catch( JaloGenericCreationException e)
		{
			final Throwable cause = e.getCause();
			throw (cause instanceof RuntimeException ?
			(RuntimeException)cause
			:
			new JaloSystemException( cause, cause.getMessage(), e.getErrorCode() ) );
		}
		catch( JaloBusinessException e )
		{
			throw new JaloSystemException( e ,"error creating ApparelSizeVariantProduct : "+e.getMessage(), 0 );
		}
	}
	
	public ApparelSizeVariantProduct createApparelSizeVariantProduct(final Map attributeValues)
	{
		return createApparelSizeVariantProduct( getSession().getSessionContext(), attributeValues );
	}
	
	public ApparelStyleVariantProduct createApparelStyleVariantProduct(final SessionContext ctx, final Map attributeValues)
	{
		try
		{
			ComposedType type = getTenant().getJaloConnection().getTypeManager().getComposedType( TrainingCoreConstants.TC.APPARELSTYLEVARIANTPRODUCT );
			return (ApparelStyleVariantProduct)type.newInstance( ctx, attributeValues );
		}
		catch( JaloGenericCreationException e)
		{
			final Throwable cause = e.getCause();
			throw (cause instanceof RuntimeException ?
			(RuntimeException)cause
			:
			new JaloSystemException( cause, cause.getMessage(), e.getErrorCode() ) );
		}
		catch( JaloBusinessException e )
		{
			throw new JaloSystemException( e ,"error creating ApparelStyleVariantProduct : "+e.getMessage(), 0 );
		}
	}
	
	public ApparelStyleVariantProduct createApparelStyleVariantProduct(final Map attributeValues)
	{
		return createApparelStyleVariantProduct( getSession().getSessionContext(), attributeValues );
	}
	
	public DefaultAddress createDefaultAddress(final SessionContext ctx, final Map attributeValues)
	{
		try
		{
			ComposedType type = getTenant().getJaloConnection().getTypeManager().getComposedType( TrainingCoreConstants.TC.DEFAULTADDRESS );
			return (DefaultAddress)type.newInstance( ctx, attributeValues );
		}
		catch( JaloGenericCreationException e)
		{
			final Throwable cause = e.getCause();
			throw (cause instanceof RuntimeException ?
			(RuntimeException)cause
			:
			new JaloSystemException( cause, cause.getMessage(), e.getErrorCode() ) );
		}
		catch( JaloBusinessException e )
		{
			throw new JaloSystemException( e ,"error creating DefaultAddress : "+e.getMessage(), 0 );
		}
	}
	
	public DefaultAddress createDefaultAddress(final Map attributeValues)
	{
		return createDefaultAddress( getSession().getSessionContext(), attributeValues );
	}
	
	public ElectronicsColorVariantProduct createElectronicsColorVariantProduct(final SessionContext ctx, final Map attributeValues)
	{
		try
		{
			ComposedType type = getTenant().getJaloConnection().getTypeManager().getComposedType( TrainingCoreConstants.TC.ELECTRONICSCOLORVARIANTPRODUCT );
			return (ElectronicsColorVariantProduct)type.newInstance( ctx, attributeValues );
		}
		catch( JaloGenericCreationException e)
		{
			final Throwable cause = e.getCause();
			throw (cause instanceof RuntimeException ?
			(RuntimeException)cause
			:
			new JaloSystemException( cause, cause.getMessage(), e.getErrorCode() ) );
		}
		catch( JaloBusinessException e )
		{
			throw new JaloSystemException( e ,"error creating ElectronicsColorVariantProduct : "+e.getMessage(), 0 );
		}
	}
	
	public ElectronicsColorVariantProduct createElectronicsColorVariantProduct(final Map attributeValues)
	{
		return createElectronicsColorVariantProduct( getSession().getSessionContext(), attributeValues );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.currency</code> attribute.
	 * @return the currency - User's currency info.
	 */
	public Currency getCurrency(final SessionContext ctx, final Customer item)
	{
		return (Currency)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.CURRENCY);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.currency</code> attribute.
	 * @return the currency - User's currency info.
	 */
	public Currency getCurrency(final Customer item)
	{
		return getCurrency( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.currency</code> attribute. 
	 * @param value the currency - User's currency info.
	 */
	public void setCurrency(final SessionContext ctx, final Customer item, final Currency value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.CURRENCY,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.currency</code> attribute. 
	 * @param value the currency - User's currency info.
	 */
	public void setCurrency(final Customer item, final Currency value)
	{
		setCurrency( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Currency.currencyname</code> attribute.
	 * @return the currencyname - Currency name (EX dollar).
	 */
	public String getCurrencyname(final SessionContext ctx, final Currency item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Currency.CURRENCYNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Currency.currencyname</code> attribute.
	 * @return the currencyname - Currency name (EX dollar).
	 */
	public String getCurrencyname(final Currency item)
	{
		return getCurrencyname( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Currency.currencyname</code> attribute. 
	 * @param value the currencyname - Currency name (EX dollar).
	 */
	public void setCurrencyname(final SessionContext ctx, final Currency item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Currency.CURRENCYNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Currency.currencyname</code> attribute. 
	 * @param value the currencyname - Currency name (EX dollar).
	 */
	public void setCurrencyname(final Currency item, final String value)
	{
		setCurrencyname( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.defaultAddress</code> attribute.
	 * @return the defaultAddress - Apartment number.
	 */
	public DefaultAddress getDefaultAddress(final SessionContext ctx, final Customer item)
	{
		return (DefaultAddress)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.DEFAULTADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.defaultAddress</code> attribute.
	 * @return the defaultAddress - Apartment number.
	 */
	public DefaultAddress getDefaultAddress(final Customer item)
	{
		return getDefaultAddress( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final SessionContext ctx, final Customer item, final DefaultAddress value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.DEFAULTADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final Customer item, final DefaultAddress value)
	{
		setDefaultAddress( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.defaultAddress</code> attribute.
	 * @return the defaultAddress - Default address (y/n).
	 */
	public Boolean isDefaultAddress(final SessionContext ctx, final Address item)
	{
		return (Boolean)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.DEFAULTADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.defaultAddress</code> attribute.
	 * @return the defaultAddress - Default address (y/n).
	 */
	public Boolean isDefaultAddress(final Address item)
	{
		return isDefaultAddress( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.defaultAddress</code> attribute. 
	 * @return the defaultAddress - Default address (y/n).
	 */
	public boolean isDefaultAddressAsPrimitive(final SessionContext ctx, final Address item)
	{
		Boolean value = isDefaultAddress( ctx,item );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.defaultAddress</code> attribute. 
	 * @return the defaultAddress - Default address (y/n).
	 */
	public boolean isDefaultAddressAsPrimitive(final Address item)
	{
		return isDefaultAddressAsPrimitive( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Default address (y/n).
	 */
	public void setDefaultAddress(final SessionContext ctx, final Address item, final Boolean value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.DEFAULTADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Default address (y/n).
	 */
	public void setDefaultAddress(final Address item, final Boolean value)
	{
		setDefaultAddress( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Default address (y/n).
	 */
	public void setDefaultAddress(final SessionContext ctx, final Address item, final boolean value)
	{
		setDefaultAddress( ctx, item, Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Default address (y/n).
	 */
	public void setDefaultAddress(final Address item, final boolean value)
	{
		setDefaultAddress( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.displayuid</code> attribute.
	 * @return the displayuid - UID preferences.
	 */
	public String getDisplayuid(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.DISPLAYUID);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.displayuid</code> attribute.
	 * @return the displayuid - UID preferences.
	 */
	public String getDisplayuid(final Customer item)
	{
		return getDisplayuid( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.displayuid</code> attribute. 
	 * @param value the displayuid - UID preferences.
	 */
	public void setDisplayuid(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.DISPLAYUID,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.displayuid</code> attribute. 
	 * @param value the displayuid - UID preferences.
	 */
	public void setDisplayuid(final Customer item, final String value)
	{
		setDisplayuid( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.firstName</code> attribute.
	 * @return the firstName - User's passport info.
	 */
	public String getFirstName(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.FIRSTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.firstName</code> attribute.
	 * @return the firstName - User's passport info.
	 */
	public String getFirstName(final Customer item)
	{
		return getFirstName( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.firstName</code> attribute. 
	 * @param value the firstName - User's passport info.
	 */
	public void setFirstName(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.FIRSTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.firstName</code> attribute. 
	 * @param value the firstName - User's passport info.
	 */
	public void setFirstName(final Customer item, final String value)
	{
		setFirstName( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.formattedAddress</code> attribute.
	 * @return the formattedAddress - Title code.
	 */
	public String getFormattedAddress(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.FORMATTEDADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.formattedAddress</code> attribute.
	 * @return the formattedAddress - Title code.
	 */
	public String getFormattedAddress(final Address item)
	{
		return getFormattedAddress( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.formattedAddress</code> attribute. 
	 * @param value the formattedAddress - Title code.
	 */
	public void setFormattedAddress(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.FORMATTEDADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.formattedAddress</code> attribute. 
	 * @param value the formattedAddress - Title code.
	 */
	public void setFormattedAddress(final Address item, final String value)
	{
		setFormattedAddress( getSession().getSessionContext(), item, value );
	}
	
	@Override
	public String getName()
	{
		return TrainingCoreConstants.EXTENSIONNAME;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.language</code> attribute.
	 * @return the language - User's language info.
	 */
	public Language getLanguage(final SessionContext ctx, final Customer item)
	{
		return (Language)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.LANGUAGE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.language</code> attribute.
	 * @return the language - User's language info.
	 */
	public Language getLanguage(final Customer item)
	{
		return getLanguage( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.language</code> attribute. 
	 * @param value the language - User's language info.
	 */
	public void setLanguage(final SessionContext ctx, final Customer item, final Language value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.LANGUAGE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.language</code> attribute. 
	 * @param value the language - User's language info.
	 */
	public void setLanguage(final Customer item, final Language value)
	{
		setLanguage( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.lastName</code> attribute.
	 * @return the lastName - User's passport info.
	 */
	public String getLastName(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.LASTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.lastName</code> attribute.
	 * @return the lastName - User's passport info.
	 */
	public String getLastName(final Customer item)
	{
		return getLastName( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.lastName</code> attribute. 
	 * @param value the lastName - User's passport info.
	 */
	public void setLastName(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.LASTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.lastName</code> attribute. 
	 * @param value the lastName - User's passport info.
	 */
	public void setLastName(final Customer item, final String value)
	{
		setLastName( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.mobilephone</code> attribute.
	 * @return the mobilephone - Mobile phone info.
	 */
	public String getMobilephone(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.MOBILEPHONE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.mobilephone</code> attribute.
	 * @return the mobilephone - Mobile phone info.
	 */
	public String getMobilephone(final Customer item)
	{
		return getMobilephone( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.mobilephone</code> attribute. 
	 * @param value the mobilephone - Mobile phone info.
	 */
	public void setMobilephone(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.MOBILEPHONE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.mobilephone</code> attribute. 
	 * @param value the mobilephone - Mobile phone info.
	 */
	public void setMobilephone(final Customer item, final String value)
	{
		setMobilephone( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.mothersName</code> attribute.
	 * @return the mothersName - User's mother's name.
	 */
	public String getMothersName(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.MOTHERSNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.mothersName</code> attribute.
	 * @return the mothersName - User's mother's name.
	 */
	public String getMothersName(final Customer item)
	{
		return getMothersName( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.mothersName</code> attribute. 
	 * @param value the mothersName - User's mother's name.
	 */
	public void setMothersName(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.MOTHERSNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.mothersName</code> attribute. 
	 * @param value the mothersName - User's mother's name.
	 */
	public void setMothersName(final Customer item, final String value)
	{
		setMothersName( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Language.nativename</code> attribute.
	 * @return the nativename - Native name.
	 */
	public String getNativename(final SessionContext ctx, final Language item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Language.NATIVENAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Language.nativename</code> attribute.
	 * @return the nativename - Native name.
	 */
	public String getNativename(final Language item)
	{
		return getNativename( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Language.nativename</code> attribute. 
	 * @param value the nativename - Native name.
	 */
	public void setNativename(final SessionContext ctx, final Language item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Language.NATIVENAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Language.nativename</code> attribute. 
	 * @param value the nativename - Native name.
	 */
	public void setNativename(final Language item, final String value)
	{
		setNativename( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.nickname</code> attribute.
	 * @return the nickname - User's nickname.
	 */
	public String getNickname(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.NICKNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.nickname</code> attribute.
	 * @return the nickname - User's nickname.
	 */
	public String getNickname(final Customer item)
	{
		return getNickname( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.nickname</code> attribute. 
	 * @param value the nickname - User's nickname.
	 */
	public void setNickname(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.NICKNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.nickname</code> attribute. 
	 * @param value the nickname - User's nickname.
	 */
	public void setNickname(final Customer item, final String value)
	{
		setNickname( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.passport</code> attribute.
	 * @return the passport - User's passport info.
	 */
	public String getPassport(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.PASSPORT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.passport</code> attribute.
	 * @return the passport - User's passport info.
	 */
	public String getPassport(final Customer item)
	{
		return getPassport( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.passport</code> attribute. 
	 * @param value the passport - User's passport info.
	 */
	public void setPassport(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.PASSPORT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.passport</code> attribute. 
	 * @param value the passport - User's passport info.
	 */
	public void setPassport(final Customer item, final String value)
	{
		setPassport( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.phone</code> attribute.
	 * @return the phone - Phone info.
	 */
	public String getPhone(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.PHONE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.phone</code> attribute.
	 * @return the phone - Phone info.
	 */
	public String getPhone(final Address item)
	{
		return getPhone( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.phone</code> attribute. 
	 * @param value the phone - Phone info.
	 */
	public void setPhone(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.PHONE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.phone</code> attribute. 
	 * @param value the phone - Phone info.
	 */
	public void setPhone(final Address item, final String value)
	{
		setPhone( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.referencePoint</code> attribute.
	 * @return the referencePoint - Reference point for address.
	 */
	public String getReferencePoint(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.REFERENCEPOINT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.referencePoint</code> attribute.
	 * @return the referencePoint - Reference point for address.
	 */
	public String getReferencePoint(final Address item)
	{
		return getReferencePoint( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.referencePoint</code> attribute. 
	 * @param value the referencePoint - Reference point for address.
	 */
	public void setReferencePoint(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.REFERENCEPOINT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.referencePoint</code> attribute. 
	 * @param value the referencePoint - Reference point for address.
	 */
	public void setReferencePoint(final Address item, final String value)
	{
		setReferencePoint( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.region</code> attribute.
	 * @return the region - User's country info.
	 */
	public Region getRegion(final SessionContext ctx, final Customer item)
	{
		return (Region)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.REGION);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.region</code> attribute.
	 * @return the region - User's country info.
	 */
	public Region getRegion(final Customer item)
	{
		return getRegion( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.region</code> attribute. 
	 * @param value the region - User's country info.
	 */
	public void setRegion(final SessionContext ctx, final Customer item, final Region value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.REGION,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.region</code> attribute. 
	 * @param value the region - User's country info.
	 */
	public void setRegion(final Customer item, final Region value)
	{
		setRegion( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.rg</code> attribute.
	 * @return the rg - User's RG.
	 */
	public String getRg(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.RG);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.rg</code> attribute.
	 * @return the rg - User's RG.
	 */
	public String getRg(final Customer item)
	{
		return getRg( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.rg</code> attribute. 
	 * @param value the rg - User's RG.
	 */
	public void setRg(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.RG,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.rg</code> attribute. 
	 * @param value the rg - User's RG.
	 */
	public void setRg(final Customer item, final String value)
	{
		setRg( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.riskArea</code> attribute.
	 * @return the riskArea - Risk area (y/n).
	 */
	public Boolean isRiskArea(final SessionContext ctx, final Address item)
	{
		return (Boolean)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.RISKAREA);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.riskArea</code> attribute.
	 * @return the riskArea - Risk area (y/n).
	 */
	public Boolean isRiskArea(final Address item)
	{
		return isRiskArea( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.riskArea</code> attribute. 
	 * @return the riskArea - Risk area (y/n).
	 */
	public boolean isRiskAreaAsPrimitive(final SessionContext ctx, final Address item)
	{
		Boolean value = isRiskArea( ctx,item );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.riskArea</code> attribute. 
	 * @return the riskArea - Risk area (y/n).
	 */
	public boolean isRiskAreaAsPrimitive(final Address item)
	{
		return isRiskAreaAsPrimitive( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.riskArea</code> attribute. 
	 * @param value the riskArea - Risk area (y/n).
	 */
	public void setRiskArea(final SessionContext ctx, final Address item, final Boolean value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.RISKAREA,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.riskArea</code> attribute. 
	 * @param value the riskArea - Risk area (y/n).
	 */
	public void setRiskArea(final Address item, final Boolean value)
	{
		setRiskArea( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.riskArea</code> attribute. 
	 * @param value the riskArea - Risk area (y/n).
	 */
	public void setRiskArea(final SessionContext ctx, final Address item, final boolean value)
	{
		setRiskArea( ctx, item, Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.riskArea</code> attribute. 
	 * @param value the riskArea - Risk area (y/n).
	 */
	public void setRiskArea(final Address item, final boolean value)
	{
		setRiskArea( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Region.role</code> attribute.
	 * @return the role - Role.
	 */
	public String getRole(final SessionContext ctx, final Region item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Region.ROLE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Region.role</code> attribute.
	 * @return the role - Role.
	 */
	public String getRole(final Region item)
	{
		return getRole( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Region.role</code> attribute. 
	 * @param value the role - Role.
	 */
	public void setRole(final SessionContext ctx, final Region item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Region.ROLE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Region.role</code> attribute. 
	 * @param value the role - Role.
	 */
	public void setRole(final Region item, final String value)
	{
		setRole( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.smsNotifications</code> attribute.
	 * @return the smsNotifications - SMS notification preferences.
	 */
	public Boolean isSmsNotifications(final SessionContext ctx, final Customer item)
	{
		return (Boolean)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.SMSNOTIFICATIONS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.smsNotifications</code> attribute.
	 * @return the smsNotifications - SMS notification preferences.
	 */
	public Boolean isSmsNotifications(final Customer item)
	{
		return isSmsNotifications( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.smsNotifications</code> attribute. 
	 * @return the smsNotifications - SMS notification preferences.
	 */
	public boolean isSmsNotificationsAsPrimitive(final SessionContext ctx, final Customer item)
	{
		Boolean value = isSmsNotifications( ctx,item );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.smsNotifications</code> attribute. 
	 * @return the smsNotifications - SMS notification preferences.
	 */
	public boolean isSmsNotificationsAsPrimitive(final Customer item)
	{
		return isSmsNotificationsAsPrimitive( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.smsNotifications</code> attribute. 
	 * @param value the smsNotifications - SMS notification preferences.
	 */
	public void setSmsNotifications(final SessionContext ctx, final Customer item, final Boolean value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.SMSNOTIFICATIONS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.smsNotifications</code> attribute. 
	 * @param value the smsNotifications - SMS notification preferences.
	 */
	public void setSmsNotifications(final Customer item, final Boolean value)
	{
		setSmsNotifications( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.smsNotifications</code> attribute. 
	 * @param value the smsNotifications - SMS notification preferences.
	 */
	public void setSmsNotifications(final SessionContext ctx, final Customer item, final boolean value)
	{
		setSmsNotifications( ctx, item, Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.smsNotifications</code> attribute. 
	 * @param value the smsNotifications - SMS notification preferences.
	 */
	public void setSmsNotifications(final Customer item, final boolean value)
	{
		setSmsNotifications( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.titleCode</code> attribute.
	 * @return the titleCode - User's title code.
	 */
	public String getTitleCode(final SessionContext ctx, final Customer item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.TITLECODE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.titleCode</code> attribute.
	 * @return the titleCode - User's title code.
	 */
	public String getTitleCode(final Customer item)
	{
		return getTitleCode( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.titleCode</code> attribute. 
	 * @param value the titleCode - User's title code.
	 */
	public void setTitleCode(final SessionContext ctx, final Customer item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.TITLECODE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.titleCode</code> attribute. 
	 * @param value the titleCode - User's title code.
	 */
	public void setTitleCode(final Customer item, final String value)
	{
		setTitleCode( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.titleCode</code> attribute.
	 * @return the titleCode - Title code.
	 */
	public String getTitleCode(final SessionContext ctx, final Address item)
	{
		return (String)item.getProperty( ctx, TrainingCoreConstants.Attributes.Address.TITLECODE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Address.titleCode</code> attribute.
	 * @return the titleCode - Title code.
	 */
	public String getTitleCode(final Address item)
	{
		return getTitleCode( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.titleCode</code> attribute. 
	 * @param value the titleCode - Title code.
	 */
	public void setTitleCode(final SessionContext ctx, final Address item, final String value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Address.TITLECODE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Address.titleCode</code> attribute. 
	 * @param value the titleCode - Title code.
	 */
	public void setTitleCode(final Address item, final String value)
	{
		setTitleCode( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.whatsappNotifications</code> attribute.
	 * @return the whatsappNotifications - Whatsapp notification preferences.
	 */
	public Boolean isWhatsappNotifications(final SessionContext ctx, final Customer item)
	{
		return (Boolean)item.getProperty( ctx, TrainingCoreConstants.Attributes.Customer.WHATSAPPNOTIFICATIONS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.whatsappNotifications</code> attribute.
	 * @return the whatsappNotifications - Whatsapp notification preferences.
	 */
	public Boolean isWhatsappNotifications(final Customer item)
	{
		return isWhatsappNotifications( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @return the whatsappNotifications - Whatsapp notification preferences.
	 */
	public boolean isWhatsappNotificationsAsPrimitive(final SessionContext ctx, final Customer item)
	{
		Boolean value = isWhatsappNotifications( ctx,item );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @return the whatsappNotifications - Whatsapp notification preferences.
	 */
	public boolean isWhatsappNotificationsAsPrimitive(final Customer item)
	{
		return isWhatsappNotificationsAsPrimitive( getSession().getSessionContext(), item );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @param value the whatsappNotifications - Whatsapp notification preferences.
	 */
	public void setWhatsappNotifications(final SessionContext ctx, final Customer item, final Boolean value)
	{
		item.setProperty(ctx, TrainingCoreConstants.Attributes.Customer.WHATSAPPNOTIFICATIONS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @param value the whatsappNotifications - Whatsapp notification preferences.
	 */
	public void setWhatsappNotifications(final Customer item, final Boolean value)
	{
		setWhatsappNotifications( getSession().getSessionContext(), item, value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @param value the whatsappNotifications - Whatsapp notification preferences.
	 */
	public void setWhatsappNotifications(final SessionContext ctx, final Customer item, final boolean value)
	{
		setWhatsappNotifications( ctx, item, Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>Customer.whatsappNotifications</code> attribute. 
	 * @param value the whatsappNotifications - Whatsapp notification preferences.
	 */
	public void setWhatsappNotifications(final Customer item, final boolean value)
	{
		setWhatsappNotifications( getSession().getSessionContext(), item, value );
	}
	
}
