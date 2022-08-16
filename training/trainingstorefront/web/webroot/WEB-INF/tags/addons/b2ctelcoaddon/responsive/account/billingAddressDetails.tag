<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="billingAddress" required="true" type="de.hybris.platform.commercefacades.user.data.AddressData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:if test="${not empty billingAddress}">
	<div class="col-xs-12 col-sm-6 card">
		<h3><spring:theme code="text.account.paymentDetails.billingAddress" text="Billing address"/></h3>
		<ul class="pull-left">
			<li>
				<c:if test="${not empty billingAddress.title}">
					${ycommerce:encodeHTML(billingAddress.title)}&nbsp;
				</c:if>
					${ycommerce:encodeHTML(billingAddress.firstName)}&nbsp;
					${ycommerce:encodeHTML(billingAddress.lastName)}
			</li>
			<li>${ycommerce:encodeHTML(billingAddress.line1)}</li>
			<li>${ycommerce:encodeHTML(billingAddress.line2)}</li>
			<li>${ycommerce:encodeHTML(billingAddress.town)}</li>
			<li>${ycommerce:encodeHTML(billingAddress.postalCode)}</li>
			<li>${ycommerce:encodeHTML(billingAddress.country.name)}</li>
		</ul>
	</div>
</c:if>
