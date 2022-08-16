<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ attribute name="showTaxEstimate" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<spring:htmlEscape defaultHtmlEscape="true" />

<c:if test="${cartData.net && showTaxEstimate}">

	<tr id="country-wrapper-div">
		<td>
			<spring:theme code="basket.page.totals.deliverycountry" text="Delivery destination:"/>
		</td>
		<td id="estimated-country">
			<select id="countryIso">
				<option value="" disabled="disabled" selected="selected">
					<spring:theme code="address.selectCountry" text="Country"/>
				</option>
				<c:forEach var="country" items="${supportedCountries}">
					<option value="${ycommerce:encodeHTML(country.isocode)}">${ycommerce:encodeHTML(country.name)}</option>
				</c:forEach>
			</select>
		</td>
	</tr>

	<tr id="zip-code-wrapper-div">
		<td>
			<spring:theme code="basket.page.totals.estimatedZip" text="Zip code:"/>
		</td>
		<td>
			<div class="control-group">
				<div class="controls">
					<input id="zipCode" value="" class="zipInput"/>
				</div>
			</div>
			<button id="estimate-taxes-button" class="right" type="button">
				<spring:theme code="basket.page.totals.estimatetaxesbutton" text="Estimate tax"/>
			</button>
		</td>
	</tr>


	<tr class="hidden estimated-totals">
		<td>
			<spring:theme code="basket.page.totals.estimatedtotaltax"/>
		</td>
		<td id="estimated-total-tax" class="hidden estimated-totals">
			<format:price priceData="${cartData.totalTax}"/>
		</td>
	</tr>

	<tr class="total hidden estimated-totals">
		<td>
			<spring:theme code="basket.page.totals.estimatedtotal"/>
		</td>
		<td id="estimated-total-price" class="total hidden estimated-totals">
			<format:price priceData="${cartData.totalPrice}"/>
		</td>
	</tr>
</c:if>

