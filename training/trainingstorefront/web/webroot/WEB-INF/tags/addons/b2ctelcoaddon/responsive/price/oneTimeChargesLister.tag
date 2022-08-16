<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="oneTimeCharges" required="true"
				  type="java.util.List<de.hybris.platform.subscriptionfacades.data.OneTimeChargeEntryData>" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:forEach items="${oneTimeCharges}" var="oneTimePrice" varStatus="oneTimePricesCounter">
	<c:if test="${not oneTimePricesCounter.first}">
		<br>
	</c:if>
	<spring:theme code="offer.price.startingFrom" text="Starting from"/><br>
	<span class="price"><format:price priceData="${oneTimePrice.price}"/></span>
	<div class="pay">${ycommerce:encodeHTML(oneTimePrice.billingTime.name)}</div>
</c:forEach>
