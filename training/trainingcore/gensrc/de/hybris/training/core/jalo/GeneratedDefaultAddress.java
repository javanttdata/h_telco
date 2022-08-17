/*
 * ----------------------------------------------------------------
 * --- WARNING: THIS FILE IS GENERATED AND WILL BE OVERWRITTEN! ---
 * --- Generated at 17 de ago de 2022 10:47:59                  ---
 * ----------------------------------------------------------------
 *  
 * Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.training.core.jalo;

import de.hybris.platform.jalo.GenericItem;
import de.hybris.platform.jalo.Item.AttributeMode;
import de.hybris.platform.jalo.SessionContext;
import de.hybris.platform.jalo.c2l.Country;
import de.hybris.platform.jalo.c2l.Region;
import de.hybris.training.core.constants.TrainingCoreConstants;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Generated class for type {@link de.hybris.platform.jalo.GenericItem DefaultAddress}.
 */
@SuppressWarnings({"deprecation","unused","cast"})
public abstract class GeneratedDefaultAddress extends GenericItem
{
	/** Qualifier of the <code>DefaultAddress.apartment</code> attribute **/
	public static final String APARTMENT = "apartment";
	/** Qualifier of the <code>DefaultAddress.billingAddress</code> attribute **/
	public static final String BILLINGADDRESS = "billingAddress";
	/** Qualifier of the <code>DefaultAddress.building</code> attribute **/
	public static final String BUILDING = "building";
	/** Qualifier of the <code>DefaultAddress.companyName</code> attribute **/
	public static final String COMPANYNAME = "companyName";
	/** Qualifier of the <code>DefaultAddress.complement</code> attribute **/
	public static final String COMPLEMENT = "complement";
	/** Qualifier of the <code>DefaultAddress.country</code> attribute **/
	public static final String COUNTRY = "country";
	/** Qualifier of the <code>DefaultAddress.defaultAddress</code> attribute **/
	public static final String DEFAULTADDRESS = "defaultAddress";
	/** Qualifier of the <code>DefaultAddress.district</code> attribute **/
	public static final String DISTRICT = "district";
	/** Qualifier of the <code>DefaultAddress.email</code> attribute **/
	public static final String EMAIL = "email";
	/** Qualifier of the <code>DefaultAddress.firstName</code> attribute **/
	public static final String FIRSTNAME = "firstName";
	/** Qualifier of the <code>DefaultAddress.lastName</code> attribute **/
	public static final String LASTNAME = "lastName";
	/** Qualifier of the <code>DefaultAddress.formattedAddress</code> attribute **/
	public static final String FORMATTEDADDRESS = "formattedAddress";
	/** Qualifier of the <code>DefaultAddress.id</code> attribute **/
	public static final String ID = "id";
	/** Qualifier of the <code>DefaultAddress.installationAddress</code> attribute **/
	public static final String INSTALLATIONADDRESS = "installationAddress";
	/** Qualifier of the <code>DefaultAddress.line1</code> attribute **/
	public static final String LINE1 = "line1";
	/** Qualifier of the <code>DefaultAddress.line2</code> attribute **/
	public static final String LINE2 = "line2";
	/** Qualifier of the <code>DefaultAddress.postalCode</code> attribute **/
	public static final String POSTALCODE = "postalCode";
	/** Qualifier of the <code>DefaultAddress.referencePoint</code> attribute **/
	public static final String REFERENCEPOINT = "referencePoint";
	/** Qualifier of the <code>DefaultAddress.region</code> attribute **/
	public static final String REGION = "region";
	/** Qualifier of the <code>DefaultAddress.riskArea</code> attribute **/
	public static final String RISKAREA = "riskArea";
	/** Qualifier of the <code>DefaultAddress.shippingAddress</code> attribute **/
	public static final String SHIPPINGADDRESS = "shippingAddress";
	/** Qualifier of the <code>DefaultAddress.town</code> attribute **/
	public static final String TOWN = "town";
	/** Qualifier of the <code>DefaultAddress.visibleInAddressBook</code> attribute **/
	public static final String VISIBLEINADDRESSBOOK = "visibleInAddressBook";
	protected static final Map<String, AttributeMode> DEFAULT_INITIAL_ATTRIBUTES;
	static
	{
		final Map<String, AttributeMode> tmp = new HashMap<String, AttributeMode>();
		tmp.put(APARTMENT, AttributeMode.INITIAL);
		tmp.put(BILLINGADDRESS, AttributeMode.INITIAL);
		tmp.put(BUILDING, AttributeMode.INITIAL);
		tmp.put(COMPANYNAME, AttributeMode.INITIAL);
		tmp.put(COMPLEMENT, AttributeMode.INITIAL);
		tmp.put(COUNTRY, AttributeMode.INITIAL);
		tmp.put(DEFAULTADDRESS, AttributeMode.INITIAL);
		tmp.put(DISTRICT, AttributeMode.INITIAL);
		tmp.put(EMAIL, AttributeMode.INITIAL);
		tmp.put(FIRSTNAME, AttributeMode.INITIAL);
		tmp.put(LASTNAME, AttributeMode.INITIAL);
		tmp.put(FORMATTEDADDRESS, AttributeMode.INITIAL);
		tmp.put(ID, AttributeMode.INITIAL);
		tmp.put(INSTALLATIONADDRESS, AttributeMode.INITIAL);
		tmp.put(LINE1, AttributeMode.INITIAL);
		tmp.put(LINE2, AttributeMode.INITIAL);
		tmp.put(POSTALCODE, AttributeMode.INITIAL);
		tmp.put(REFERENCEPOINT, AttributeMode.INITIAL);
		tmp.put(REGION, AttributeMode.INITIAL);
		tmp.put(RISKAREA, AttributeMode.INITIAL);
		tmp.put(SHIPPINGADDRESS, AttributeMode.INITIAL);
		tmp.put(TOWN, AttributeMode.INITIAL);
		tmp.put(VISIBLEINADDRESSBOOK, AttributeMode.INITIAL);
		DEFAULT_INITIAL_ATTRIBUTES = Collections.unmodifiableMap(tmp);
	}
	@Override
	protected Map<String, AttributeMode> getDefaultAttributeModes()
	{
		return DEFAULT_INITIAL_ATTRIBUTES;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.apartment</code> attribute.
	 * @return the apartment - Apartment number.
	 */
	public String getApartment(final SessionContext ctx)
	{
		return (String)getProperty( ctx, APARTMENT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.apartment</code> attribute.
	 * @return the apartment - Apartment number.
	 */
	public String getApartment()
	{
		return getApartment( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.apartment</code> attribute. 
	 * @param value the apartment - Apartment number.
	 */
	public void setApartment(final SessionContext ctx, final String value)
	{
		setProperty(ctx, APARTMENT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.apartment</code> attribute. 
	 * @param value the apartment - Apartment number.
	 */
	public void setApartment(final String value)
	{
		setApartment( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.billingAddress</code> attribute.
	 * @return the billingAddress - Billing address number.
	 */
	public String getBillingAddress(final SessionContext ctx)
	{
		return (String)getProperty( ctx, BILLINGADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.billingAddress</code> attribute.
	 * @return the billingAddress - Billing address number.
	 */
	public String getBillingAddress()
	{
		return getBillingAddress( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.billingAddress</code> attribute. 
	 * @param value the billingAddress - Billing address number.
	 */
	public void setBillingAddress(final SessionContext ctx, final String value)
	{
		setProperty(ctx, BILLINGADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.billingAddress</code> attribute. 
	 * @param value the billingAddress - Billing address number.
	 */
	public void setBillingAddress(final String value)
	{
		setBillingAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.building</code> attribute.
	 * @return the building - Building number.
	 */
	public String getBuilding(final SessionContext ctx)
	{
		return (String)getProperty( ctx, BUILDING);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.building</code> attribute.
	 * @return the building - Building number.
	 */
	public String getBuilding()
	{
		return getBuilding( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.building</code> attribute. 
	 * @param value the building - Building number.
	 */
	public void setBuilding(final SessionContext ctx, final String value)
	{
		setProperty(ctx, BUILDING,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.building</code> attribute. 
	 * @param value the building - Building number.
	 */
	public void setBuilding(final String value)
	{
		setBuilding( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.companyName</code> attribute.
	 * @return the companyName - Company name.
	 */
	public String getCompanyName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, COMPANYNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.companyName</code> attribute.
	 * @return the companyName - Company name.
	 */
	public String getCompanyName()
	{
		return getCompanyName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.companyName</code> attribute. 
	 * @param value the companyName - Company name.
	 */
	public void setCompanyName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, COMPANYNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.companyName</code> attribute. 
	 * @param value the companyName - Company name.
	 */
	public void setCompanyName(final String value)
	{
		setCompanyName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.complement</code> attribute.
	 * @return the complement - Complement for address.
	 */
	public String getComplement(final SessionContext ctx)
	{
		return (String)getProperty( ctx, COMPLEMENT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.complement</code> attribute.
	 * @return the complement - Complement for address.
	 */
	public String getComplement()
	{
		return getComplement( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.complement</code> attribute. 
	 * @param value the complement - Complement for address.
	 */
	public void setComplement(final SessionContext ctx, final String value)
	{
		setProperty(ctx, COMPLEMENT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.complement</code> attribute. 
	 * @param value the complement - Complement for address.
	 */
	public void setComplement(final String value)
	{
		setComplement( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.country</code> attribute.
	 * @return the country - Country information.
	 */
	public Country getCountry(final SessionContext ctx)
	{
		return (Country)getProperty( ctx, COUNTRY);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.country</code> attribute.
	 * @return the country - Country information.
	 */
	public Country getCountry()
	{
		return getCountry( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.country</code> attribute. 
	 * @param value the country - Country information.
	 */
	public void setCountry(final SessionContext ctx, final Country value)
	{
		setProperty(ctx, COUNTRY,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.country</code> attribute. 
	 * @param value the country - Country information.
	 */
	public void setCountry(final Country value)
	{
		setCountry( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.defaultAddress</code> attribute.
	 * @return the defaultAddress - Apartment number.
	 */
	public Boolean isDefaultAddress(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, DEFAULTADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.defaultAddress</code> attribute.
	 * @return the defaultAddress - Apartment number.
	 */
	public Boolean isDefaultAddress()
	{
		return isDefaultAddress( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @return the defaultAddress - Apartment number.
	 */
	public boolean isDefaultAddressAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isDefaultAddress( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @return the defaultAddress - Apartment number.
	 */
	public boolean isDefaultAddressAsPrimitive()
	{
		return isDefaultAddressAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, DEFAULTADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final Boolean value)
	{
		setDefaultAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final SessionContext ctx, final boolean value)
	{
		setDefaultAddress( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.defaultAddress</code> attribute. 
	 * @param value the defaultAddress - Apartment number.
	 */
	public void setDefaultAddress(final boolean value)
	{
		setDefaultAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.district</code> attribute.
	 * @return the district - Apartment number.
	 */
	public String getDistrict(final SessionContext ctx)
	{
		return (String)getProperty( ctx, DISTRICT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.district</code> attribute.
	 * @return the district - Apartment number.
	 */
	public String getDistrict()
	{
		return getDistrict( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.district</code> attribute. 
	 * @param value the district - Apartment number.
	 */
	public void setDistrict(final SessionContext ctx, final String value)
	{
		setProperty(ctx, DISTRICT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.district</code> attribute. 
	 * @param value the district - Apartment number.
	 */
	public void setDistrict(final String value)
	{
		setDistrict( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.email</code> attribute.
	 * @return the email - Apartment number.
	 */
	public String getEmail(final SessionContext ctx)
	{
		return (String)getProperty( ctx, EMAIL);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.email</code> attribute.
	 * @return the email - Apartment number.
	 */
	public String getEmail()
	{
		return getEmail( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.email</code> attribute. 
	 * @param value the email - Apartment number.
	 */
	public void setEmail(final SessionContext ctx, final String value)
	{
		setProperty(ctx, EMAIL,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.email</code> attribute. 
	 * @param value the email - Apartment number.
	 */
	public void setEmail(final String value)
	{
		setEmail( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.firstName</code> attribute.
	 * @return the firstName - Apartment number.
	 */
	public String getFirstName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, FIRSTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.firstName</code> attribute.
	 * @return the firstName - Apartment number.
	 */
	public String getFirstName()
	{
		return getFirstName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.firstName</code> attribute. 
	 * @param value the firstName - Apartment number.
	 */
	public void setFirstName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, FIRSTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.firstName</code> attribute. 
	 * @param value the firstName - Apartment number.
	 */
	public void setFirstName(final String value)
	{
		setFirstName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.formattedAddress</code> attribute.
	 * @return the formattedAddress - Apartment number.
	 */
	public String getFormattedAddress(final SessionContext ctx)
	{
		return (String)getProperty( ctx, FORMATTEDADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.formattedAddress</code> attribute.
	 * @return the formattedAddress - Apartment number.
	 */
	public String getFormattedAddress()
	{
		return getFormattedAddress( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.formattedAddress</code> attribute. 
	 * @param value the formattedAddress - Apartment number.
	 */
	public void setFormattedAddress(final SessionContext ctx, final String value)
	{
		setProperty(ctx, FORMATTEDADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.formattedAddress</code> attribute. 
	 * @param value the formattedAddress - Apartment number.
	 */
	public void setFormattedAddress(final String value)
	{
		setFormattedAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.id</code> attribute.
	 * @return the id - Apartment number.
	 */
	public String getId(final SessionContext ctx)
	{
		return (String)getProperty( ctx, ID);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.id</code> attribute.
	 * @return the id - Apartment number.
	 */
	public String getId()
	{
		return getId( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.id</code> attribute. 
	 * @param value the id - Apartment number.
	 */
	public void setId(final SessionContext ctx, final String value)
	{
		setProperty(ctx, ID,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.id</code> attribute. 
	 * @param value the id - Apartment number.
	 */
	public void setId(final String value)
	{
		setId( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.installationAddress</code> attribute.
	 * @return the installationAddress - Apartment number.
	 */
	public Boolean isInstallationAddress(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, INSTALLATIONADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.installationAddress</code> attribute.
	 * @return the installationAddress - Apartment number.
	 */
	public Boolean isInstallationAddress()
	{
		return isInstallationAddress( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @return the installationAddress - Apartment number.
	 */
	public boolean isInstallationAddressAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isInstallationAddress( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @return the installationAddress - Apartment number.
	 */
	public boolean isInstallationAddressAsPrimitive()
	{
		return isInstallationAddressAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @param value the installationAddress - Apartment number.
	 */
	public void setInstallationAddress(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, INSTALLATIONADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @param value the installationAddress - Apartment number.
	 */
	public void setInstallationAddress(final Boolean value)
	{
		setInstallationAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @param value the installationAddress - Apartment number.
	 */
	public void setInstallationAddress(final SessionContext ctx, final boolean value)
	{
		setInstallationAddress( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.installationAddress</code> attribute. 
	 * @param value the installationAddress - Apartment number.
	 */
	public void setInstallationAddress(final boolean value)
	{
		setInstallationAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.lastName</code> attribute.
	 * @return the lastName - Apartment number.
	 */
	public String getLastName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, LASTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.lastName</code> attribute.
	 * @return the lastName - Apartment number.
	 */
	public String getLastName()
	{
		return getLastName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.lastName</code> attribute. 
	 * @param value the lastName - Apartment number.
	 */
	public void setLastName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, LASTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.lastName</code> attribute. 
	 * @param value the lastName - Apartment number.
	 */
	public void setLastName(final String value)
	{
		setLastName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.line1</code> attribute.
	 * @return the line1 - Apartment number.
	 */
	public String getLine1(final SessionContext ctx)
	{
		return (String)getProperty( ctx, LINE1);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.line1</code> attribute.
	 * @return the line1 - Apartment number.
	 */
	public String getLine1()
	{
		return getLine1( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.line1</code> attribute. 
	 * @param value the line1 - Apartment number.
	 */
	public void setLine1(final SessionContext ctx, final String value)
	{
		setProperty(ctx, LINE1,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.line1</code> attribute. 
	 * @param value the line1 - Apartment number.
	 */
	public void setLine1(final String value)
	{
		setLine1( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.line2</code> attribute.
	 * @return the line2 - Apartment number.
	 */
	public String getLine2(final SessionContext ctx)
	{
		return (String)getProperty( ctx, LINE2);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.line2</code> attribute.
	 * @return the line2 - Apartment number.
	 */
	public String getLine2()
	{
		return getLine2( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.line2</code> attribute. 
	 * @param value the line2 - Apartment number.
	 */
	public void setLine2(final SessionContext ctx, final String value)
	{
		setProperty(ctx, LINE2,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.line2</code> attribute. 
	 * @param value the line2 - Apartment number.
	 */
	public void setLine2(final String value)
	{
		setLine2( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.postalCode</code> attribute.
	 * @return the postalCode - Apartment number.
	 */
	public String getPostalCode(final SessionContext ctx)
	{
		return (String)getProperty( ctx, POSTALCODE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.postalCode</code> attribute.
	 * @return the postalCode - Apartment number.
	 */
	public String getPostalCode()
	{
		return getPostalCode( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.postalCode</code> attribute. 
	 * @param value the postalCode - Apartment number.
	 */
	public void setPostalCode(final SessionContext ctx, final String value)
	{
		setProperty(ctx, POSTALCODE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.postalCode</code> attribute. 
	 * @param value the postalCode - Apartment number.
	 */
	public void setPostalCode(final String value)
	{
		setPostalCode( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.referencePoint</code> attribute.
	 * @return the referencePoint - Apartment number.
	 */
	public String getReferencePoint(final SessionContext ctx)
	{
		return (String)getProperty( ctx, REFERENCEPOINT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.referencePoint</code> attribute.
	 * @return the referencePoint - Apartment number.
	 */
	public String getReferencePoint()
	{
		return getReferencePoint( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.referencePoint</code> attribute. 
	 * @param value the referencePoint - Apartment number.
	 */
	public void setReferencePoint(final SessionContext ctx, final String value)
	{
		setProperty(ctx, REFERENCEPOINT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.referencePoint</code> attribute. 
	 * @param value the referencePoint - Apartment number.
	 */
	public void setReferencePoint(final String value)
	{
		setReferencePoint( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.region</code> attribute.
	 * @return the region - Apartment number.
	 */
	public Region getRegion(final SessionContext ctx)
	{
		return (Region)getProperty( ctx, REGION);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.region</code> attribute.
	 * @return the region - Apartment number.
	 */
	public Region getRegion()
	{
		return getRegion( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.region</code> attribute. 
	 * @param value the region - Apartment number.
	 */
	public void setRegion(final SessionContext ctx, final Region value)
	{
		setProperty(ctx, REGION,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.region</code> attribute. 
	 * @param value the region - Apartment number.
	 */
	public void setRegion(final Region value)
	{
		setRegion( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.riskArea</code> attribute.
	 * @return the riskArea - Apartment number.
	 */
	public Boolean isRiskArea(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, RISKAREA);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.riskArea</code> attribute.
	 * @return the riskArea - Apartment number.
	 */
	public Boolean isRiskArea()
	{
		return isRiskArea( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @return the riskArea - Apartment number.
	 */
	public boolean isRiskAreaAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isRiskArea( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @return the riskArea - Apartment number.
	 */
	public boolean isRiskAreaAsPrimitive()
	{
		return isRiskAreaAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @param value the riskArea - Apartment number.
	 */
	public void setRiskArea(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, RISKAREA,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @param value the riskArea - Apartment number.
	 */
	public void setRiskArea(final Boolean value)
	{
		setRiskArea( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @param value the riskArea - Apartment number.
	 */
	public void setRiskArea(final SessionContext ctx, final boolean value)
	{
		setRiskArea( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.riskArea</code> attribute. 
	 * @param value the riskArea - Apartment number.
	 */
	public void setRiskArea(final boolean value)
	{
		setRiskArea( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.shippingAddress</code> attribute.
	 * @return the shippingAddress - Apartment number.
	 */
	public Boolean isShippingAddress(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, SHIPPINGADDRESS);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.shippingAddress</code> attribute.
	 * @return the shippingAddress - Apartment number.
	 */
	public Boolean isShippingAddress()
	{
		return isShippingAddress( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @return the shippingAddress - Apartment number.
	 */
	public boolean isShippingAddressAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isShippingAddress( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @return the shippingAddress - Apartment number.
	 */
	public boolean isShippingAddressAsPrimitive()
	{
		return isShippingAddressAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @param value the shippingAddress - Apartment number.
	 */
	public void setShippingAddress(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, SHIPPINGADDRESS,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @param value the shippingAddress - Apartment number.
	 */
	public void setShippingAddress(final Boolean value)
	{
		setShippingAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @param value the shippingAddress - Apartment number.
	 */
	public void setShippingAddress(final SessionContext ctx, final boolean value)
	{
		setShippingAddress( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.shippingAddress</code> attribute. 
	 * @param value the shippingAddress - Apartment number.
	 */
	public void setShippingAddress(final boolean value)
	{
		setShippingAddress( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.town</code> attribute.
	 * @return the town - Apartment number.
	 */
	public String getTown(final SessionContext ctx)
	{
		return (String)getProperty( ctx, TOWN);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.town</code> attribute.
	 * @return the town - Apartment number.
	 */
	public String getTown()
	{
		return getTown( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.town</code> attribute. 
	 * @param value the town - Apartment number.
	 */
	public void setTown(final SessionContext ctx, final String value)
	{
		setProperty(ctx, TOWN,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.town</code> attribute. 
	 * @param value the town - Apartment number.
	 */
	public void setTown(final String value)
	{
		setTown( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.visibleInAddressBook</code> attribute.
	 * @return the visibleInAddressBook - Apartment number.
	 */
	public Boolean isVisibleInAddressBook(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, VISIBLEINADDRESSBOOK);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.visibleInAddressBook</code> attribute.
	 * @return the visibleInAddressBook - Apartment number.
	 */
	public Boolean isVisibleInAddressBook()
	{
		return isVisibleInAddressBook( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @return the visibleInAddressBook - Apartment number.
	 */
	public boolean isVisibleInAddressBookAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isVisibleInAddressBook( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @return the visibleInAddressBook - Apartment number.
	 */
	public boolean isVisibleInAddressBookAsPrimitive()
	{
		return isVisibleInAddressBookAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @param value the visibleInAddressBook - Apartment number.
	 */
	public void setVisibleInAddressBook(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, VISIBLEINADDRESSBOOK,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @param value the visibleInAddressBook - Apartment number.
	 */
	public void setVisibleInAddressBook(final Boolean value)
	{
		setVisibleInAddressBook( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @param value the visibleInAddressBook - Apartment number.
	 */
	public void setVisibleInAddressBook(final SessionContext ctx, final boolean value)
	{
		setVisibleInAddressBook( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>DefaultAddress.visibleInAddressBook</code> attribute. 
	 * @param value the visibleInAddressBook - Apartment number.
	 */
	public void setVisibleInAddressBook(final boolean value)
	{
		setVisibleInAddressBook( getSession().getSessionContext(), value );
	}
	
}
