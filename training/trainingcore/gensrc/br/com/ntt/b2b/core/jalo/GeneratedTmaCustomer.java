/*
 * ----------------------------------------------------------------
 * --- WARNING: THIS FILE IS GENERATED AND WILL BE OVERWRITTEN! ---
 * --- Generated at 15 de ago de 2022 09:06:16                  ---
 * ----------------------------------------------------------------
 *  
 * Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved.
 */
package br.com.ntt.b2b.core.jalo;

import de.hybris.platform.jalo.Item.AttributeMode;
import de.hybris.platform.jalo.SessionContext;
import de.hybris.platform.jalo.user.Customer;
import de.hybris.training.core.constants.TrainingCoreConstants;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Generated class for type {@link br.com.ntt.b2b.core.jalo.TmaCustomer TmaCustomer}.
 */
@SuppressWarnings({"deprecation","unused","cast"})
public abstract class GeneratedTmaCustomer extends Customer
{
	/** Qualifier of the <code>TmaCustomer.birthdate</code> attribute **/
	public static final String BIRTHDATE = "birthdate";
	/** Qualifier of the <code>TmaCustomer.cpf</code> attribute **/
	public static final String CPF = "cpf";
	/** Qualifier of the <code>TmaCustomer.firstName</code> attribute **/
	public static final String FIRSTNAME = "firstName";
	/** Qualifier of the <code>TmaCustomer.lastName</code> attribute **/
	public static final String LASTNAME = "lastName";
	/** Qualifier of the <code>TmaCustomer.mobilePhone</code> attribute **/
	public static final String MOBILEPHONE = "mobilePhone";
	/** Qualifier of the <code>TmaCustomer.mothersName</code> attribute **/
	public static final String MOTHERSNAME = "mothersName";
	/** Qualifier of the <code>TmaCustomer.nickname</code> attribute **/
	public static final String NICKNAME = "nickname";
	/** Qualifier of the <code>TmaCustomer.telefone1</code> attribute **/
	public static final String TELEFONE1 = "telefone1";
	/** Qualifier of the <code>TmaCustomer.telefone2</code> attribute **/
	public static final String TELEFONE2 = "telefone2";
	/** Qualifier of the <code>TmaCustomer.rg</code> attribute **/
	public static final String RG = "rg";
	/** Qualifier of the <code>TmaCustomer.whatsAppNotification</code> attribute **/
	public static final String WHATSAPPNOTIFICATION = "whatsAppNotification";
	/** Qualifier of the <code>TmaCustomer.passport</code> attribute **/
	public static final String PASSPORT = "passport";
	protected static final Map<String, AttributeMode> DEFAULT_INITIAL_ATTRIBUTES;
	static
	{
		final Map<String, AttributeMode> tmp = new HashMap<String, AttributeMode>(Customer.DEFAULT_INITIAL_ATTRIBUTES);
		tmp.put(BIRTHDATE, AttributeMode.INITIAL);
		tmp.put(CPF, AttributeMode.INITIAL);
		tmp.put(FIRSTNAME, AttributeMode.INITIAL);
		tmp.put(LASTNAME, AttributeMode.INITIAL);
		tmp.put(MOBILEPHONE, AttributeMode.INITIAL);
		tmp.put(MOTHERSNAME, AttributeMode.INITIAL);
		tmp.put(NICKNAME, AttributeMode.INITIAL);
		tmp.put(TELEFONE1, AttributeMode.INITIAL);
		tmp.put(TELEFONE2, AttributeMode.INITIAL);
		tmp.put(RG, AttributeMode.INITIAL);
		tmp.put(WHATSAPPNOTIFICATION, AttributeMode.INITIAL);
		tmp.put(PASSPORT, AttributeMode.INITIAL);
		DEFAULT_INITIAL_ATTRIBUTES = Collections.unmodifiableMap(tmp);
	}
	@Override
	protected Map<String, AttributeMode> getDefaultAttributeModes()
	{
		return DEFAULT_INITIAL_ATTRIBUTES;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.birthdate</code> attribute.
	 * @return the birthdate - Attribute birthdate typeof String.
	 */
	public String getBirthdate(final SessionContext ctx)
	{
		return (String)getProperty( ctx, BIRTHDATE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.birthdate</code> attribute.
	 * @return the birthdate - Attribute birthdate typeof String.
	 */
	public String getBirthdate()
	{
		return getBirthdate( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.birthdate</code> attribute. 
	 * @param value the birthdate - Attribute birthdate typeof String.
	 */
	public void setBirthdate(final SessionContext ctx, final String value)
	{
		setProperty(ctx, BIRTHDATE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.birthdate</code> attribute. 
	 * @param value the birthdate - Attribute birthdate typeof String.
	 */
	public void setBirthdate(final String value)
	{
		setBirthdate( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.cpf</code> attribute.
	 * @return the cpf - Attribute CPF typeof String.
	 */
	public String getCpf(final SessionContext ctx)
	{
		return (String)getProperty( ctx, CPF);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.cpf</code> attribute.
	 * @return the cpf - Attribute CPF typeof String.
	 */
	public String getCpf()
	{
		return getCpf( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.cpf</code> attribute. 
	 * @param value the cpf - Attribute CPF typeof String.
	 */
	public void setCpf(final SessionContext ctx, final String value)
	{
		setProperty(ctx, CPF,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.cpf</code> attribute. 
	 * @param value the cpf - Attribute CPF typeof String.
	 */
	public void setCpf(final String value)
	{
		setCpf( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.firstName</code> attribute.
	 * @return the firstName - Attribute firstName typeof String.
	 */
	public String getFirstName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, FIRSTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.firstName</code> attribute.
	 * @return the firstName - Attribute firstName typeof String.
	 */
	public String getFirstName()
	{
		return getFirstName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.firstName</code> attribute. 
	 * @param value the firstName - Attribute firstName typeof String.
	 */
	public void setFirstName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, FIRSTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.firstName</code> attribute. 
	 * @param value the firstName - Attribute firstName typeof String.
	 */
	public void setFirstName(final String value)
	{
		setFirstName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.lastName</code> attribute.
	 * @return the lastName - Attribute lastName typeof String.
	 */
	public String getLastName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, LASTNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.lastName</code> attribute.
	 * @return the lastName - Attribute lastName typeof String.
	 */
	public String getLastName()
	{
		return getLastName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.lastName</code> attribute. 
	 * @param value the lastName - Attribute lastName typeof String.
	 */
	public void setLastName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, LASTNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.lastName</code> attribute. 
	 * @param value the lastName - Attribute lastName typeof String.
	 */
	public void setLastName(final String value)
	{
		setLastName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.mobilePhone</code> attribute.
	 * @return the mobilePhone - Attribute mobilePhone typeof String.
	 */
	public String getMobilePhone(final SessionContext ctx)
	{
		return (String)getProperty( ctx, MOBILEPHONE);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.mobilePhone</code> attribute.
	 * @return the mobilePhone - Attribute mobilePhone typeof String.
	 */
	public String getMobilePhone()
	{
		return getMobilePhone( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.mobilePhone</code> attribute. 
	 * @param value the mobilePhone - Attribute mobilePhone typeof String.
	 */
	public void setMobilePhone(final SessionContext ctx, final String value)
	{
		setProperty(ctx, MOBILEPHONE,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.mobilePhone</code> attribute. 
	 * @param value the mobilePhone - Attribute mobilePhone typeof String.
	 */
	public void setMobilePhone(final String value)
	{
		setMobilePhone( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.mothersName</code> attribute.
	 * @return the mothersName - Attribute mothersName typeof String.
	 */
	public String getMothersName(final SessionContext ctx)
	{
		return (String)getProperty( ctx, MOTHERSNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.mothersName</code> attribute.
	 * @return the mothersName - Attribute mothersName typeof String.
	 */
	public String getMothersName()
	{
		return getMothersName( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.mothersName</code> attribute. 
	 * @param value the mothersName - Attribute mothersName typeof String.
	 */
	public void setMothersName(final SessionContext ctx, final String value)
	{
		setProperty(ctx, MOTHERSNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.mothersName</code> attribute. 
	 * @param value the mothersName - Attribute mothersName typeof String.
	 */
	public void setMothersName(final String value)
	{
		setMothersName( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.nickname</code> attribute.
	 * @return the nickname - Attribute nickname typeof String.
	 */
	public String getNickname(final SessionContext ctx)
	{
		return (String)getProperty( ctx, NICKNAME);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.nickname</code> attribute.
	 * @return the nickname - Attribute nickname typeof String.
	 */
	public String getNickname()
	{
		return getNickname( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.nickname</code> attribute. 
	 * @param value the nickname - Attribute nickname typeof String.
	 */
	public void setNickname(final SessionContext ctx, final String value)
	{
		setProperty(ctx, NICKNAME,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.nickname</code> attribute. 
	 * @param value the nickname - Attribute nickname typeof String.
	 */
	public void setNickname(final String value)
	{
		setNickname( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.passport</code> attribute.
	 * @return the passport - Attribute Passport typeof String.
	 */
	public String getPassport(final SessionContext ctx)
	{
		return (String)getProperty( ctx, PASSPORT);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.passport</code> attribute.
	 * @return the passport - Attribute Passport typeof String.
	 */
	public String getPassport()
	{
		return getPassport( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.passport</code> attribute. 
	 * @param value the passport - Attribute Passport typeof String.
	 */
	public void setPassport(final SessionContext ctx, final String value)
	{
		setProperty(ctx, PASSPORT,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.passport</code> attribute. 
	 * @param value the passport - Attribute Passport typeof String.
	 */
	public void setPassport(final String value)
	{
		setPassport( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.rg</code> attribute.
	 * @return the rg - Atribute RG typeof String.
	 */
	public String getRg(final SessionContext ctx)
	{
		return (String)getProperty( ctx, RG);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.rg</code> attribute.
	 * @return the rg - Atribute RG typeof String.
	 */
	public String getRg()
	{
		return getRg( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.rg</code> attribute. 
	 * @param value the rg - Atribute RG typeof String.
	 */
	public void setRg(final SessionContext ctx, final String value)
	{
		setProperty(ctx, RG,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.rg</code> attribute. 
	 * @param value the rg - Atribute RG typeof String.
	 */
	public void setRg(final String value)
	{
		setRg( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.telefone1</code> attribute.
	 * @return the telefone1 - Attribute telefone1 typeof String.
	 */
	public String getTelefone1(final SessionContext ctx)
	{
		return (String)getProperty( ctx, TELEFONE1);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.telefone1</code> attribute.
	 * @return the telefone1 - Attribute telefone1 typeof String.
	 */
	public String getTelefone1()
	{
		return getTelefone1( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.telefone1</code> attribute. 
	 * @param value the telefone1 - Attribute telefone1 typeof String.
	 */
	public void setTelefone1(final SessionContext ctx, final String value)
	{
		setProperty(ctx, TELEFONE1,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.telefone1</code> attribute. 
	 * @param value the telefone1 - Attribute telefone1 typeof String.
	 */
	public void setTelefone1(final String value)
	{
		setTelefone1( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.telefone2</code> attribute.
	 * @return the telefone2 - Attribute telefone2 typeof String.
	 */
	public String getTelefone2(final SessionContext ctx)
	{
		return (String)getProperty( ctx, TELEFONE2);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.telefone2</code> attribute.
	 * @return the telefone2 - Attribute telefone2 typeof String.
	 */
	public String getTelefone2()
	{
		return getTelefone2( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.telefone2</code> attribute. 
	 * @param value the telefone2 - Attribute telefone2 typeof String.
	 */
	public void setTelefone2(final SessionContext ctx, final String value)
	{
		setProperty(ctx, TELEFONE2,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.telefone2</code> attribute. 
	 * @param value the telefone2 - Attribute telefone2 typeof String.
	 */
	public void setTelefone2(final String value)
	{
		setTelefone2( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.whatsAppNotification</code> attribute.
	 * @return the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public Boolean isWhatsAppNotification(final SessionContext ctx)
	{
		return (Boolean)getProperty( ctx, WHATSAPPNOTIFICATION);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.whatsAppNotification</code> attribute.
	 * @return the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public Boolean isWhatsAppNotification()
	{
		return isWhatsAppNotification( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @return the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public boolean isWhatsAppNotificationAsPrimitive(final SessionContext ctx)
	{
		Boolean value = isWhatsAppNotification( ctx );
		return value != null ? value.booleanValue() : false;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @return the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public boolean isWhatsAppNotificationAsPrimitive()
	{
		return isWhatsAppNotificationAsPrimitive( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @param value the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public void setWhatsAppNotification(final SessionContext ctx, final Boolean value)
	{
		setProperty(ctx, WHATSAPPNOTIFICATION,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @param value the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public void setWhatsAppNotification(final Boolean value)
	{
		setWhatsAppNotification( getSession().getSessionContext(), value );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @param value the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public void setWhatsAppNotification(final SessionContext ctx, final boolean value)
	{
		setWhatsAppNotification( ctx,Boolean.valueOf( value ) );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>TmaCustomer.whatsAppNotification</code> attribute. 
	 * @param value the whatsAppNotification - Attribute whatsAppNotification typeof Boolean.
	 */
	public void setWhatsAppNotification(final boolean value)
	{
		setWhatsAppNotification( getSession().getSessionContext(), value );
	}
	
}
