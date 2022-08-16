/*
 * Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
 */
package de.hybris.platform.b2ctelcoaddon.forms.validation;




import de.hybris.platform.acceleratorstorefrontcommons.forms.SopPaymentDetailsForm;
import de.hybris.platform.commercefacades.i18n.I18NFacade;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import java.util.Calendar;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


/**
 *
 * Subscription Billing Gateway (SBG) Silent Order Post (SOP) Payment Details Validator.
 *
 */

public class SbgSopPaymentDetailsValidator implements Validator
{
	private static final Logger LOG = Logger.getLogger(SbgSopPaymentDetailsValidator.class);
	private I18NFacade i18NFacade;

	@Override
	public boolean supports(final Class<?> aClass)
	{
		return SopPaymentDetailsForm.class.equals(aClass);
	}

	@Override
	public void validate(final Object object, final Errors errors)
	{
		final SopPaymentDetailsForm form = (SopPaymentDetailsForm) object;

		final Calendar start = parseDate(form.getCard_startMonth(), form.getCard_startYear());
		final Calendar expiration = parseDate(form.getCard_expirationMonth(), form.getCard_expirationYear());
		final Calendar current = Calendar.getInstance();

		if (start != null)
		{
			if (start.after(current))
			{
				errors.rejectValue("startMonth", "payment.startDate.past.invalid");
			}

			if (expiration != null)
			{
				if (start.after(expiration))
				{
					errors.rejectValue("startMonth", "payment.startDate.invalid");
				}
			}
		}

		if (expiration != null)
		{
			if (expiration.before(current))
			{
				errors.rejectValue("expiryMonth", "payment.expiryDate.future.invalid");
			}
		}

		if (!form.isUseDeliveryAddress())
		{
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_firstName", "address.firstName.invalid");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_lastName", "address.lastName.invalid");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_street1", "address.line1.invalid");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_city", "address.townCity.invalid");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_postalCode", "address.postcode.invalid");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billTo_country", "address.country.invalid");
		}
		validateRegion(form, errors);
	}

	/**
	 * @param form
	 * @param errors
	 */
	private void validateRegion(final SopPaymentDetailsForm form, final Errors errors)
	{
		try
		{
			getI18NFacade().getRegion(form.getBillTo_country(), form.getBillTo_state());
		}
		catch (final IllegalArgumentException e)
		{
			LOG.info(e);
			errors.rejectValue("billTo_state", "address.province.invalid");
		}
	}

	protected Calendar parseDate(final String month, final String year)
	{
		if (StringUtils.isNotBlank(month) && StringUtils.isNotBlank(year))
		{
			final Integer yearInt = getIntegerForString(year);
			final Integer monthInt = getIntegerForString(month);

			if (yearInt != null && monthInt != null)
			{
				final Calendar date = getCalendarResetTime();
				date.set(Calendar.YEAR, yearInt.intValue());
				date.set(Calendar.MONTH, monthInt.intValue() - 1);
				date.set(Calendar.DAY_OF_MONTH, 1);
				return date;
			}
		}
		return null;
	}

	protected Calendar getCalendarResetTime()
	{
		final Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar;
	}

	/**
	 * Common method to convert a String to an Integer.
	 *
	 * @param value
	 *           - the String value to be converted.
	 * @return - an Integer object.
	 */
	protected Integer getIntegerForString(final String value)
	{
		if (StringUtils.isNotEmpty(value))
		{
			try
			{
				return Integer.valueOf(value);
			}
			catch (final NumberFormatException e)
			{
				LOG.warn(String.format("String value '%s' cannot be converted to Integer", YSanitizer.sanitize(value)), e);
			}
		}

		return null;
	}

	/**
	 * @return the i18NFacade
	 */
	@Required
	protected I18NFacade getI18NFacade()
	{
		return i18NFacade;
	}

	/**
	 * @param i18nFacade
	 *           the i18NFacade to set
	 */
	public void setI18NFacade(final I18NFacade i18nFacade)
	{
		i18NFacade = i18nFacade;
	}
}
