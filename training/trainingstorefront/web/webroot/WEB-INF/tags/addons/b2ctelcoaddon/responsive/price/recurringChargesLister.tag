<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="recurringCharges" required="true"
				  type="java.util.List<de.hybris.platform.subscriptionfacades.data.RecurringChargeEntryData>" %>
<%@ attribute name="billingTime" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:set var="recurringChargesSize" value="${fn:length(recurringCharges)}"/>
<c:if test="${not empty recurringCharges}">
	<c:forEach items="${recurringCharges}" var="recurringPrice">
		<c:set var="cycleStart" value="${recurringPrice.cycleStart}"/>
		<c:set var="cycleEnd" value="${recurringPrice.cycleEnd}"/>
		<c:choose>
			<c:when test="${cycleEnd == '-1'}">
				<c:if test="${recurringChargesSize gt 1}">
					<spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${cycleStart}"/>
				</c:if>
				<c:if test="${recurringChargesSize eq 1 and cycleStart gt 1}">
					<spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${cycleStart}"/>
				</c:if>
			</c:when>
			<c:otherwise>
				<spring:theme code="product.list.viewplans.price.interval" arguments="${cycleStart}, ${cycleEnd}"/>
			</c:otherwise>
		</c:choose>
		<spring:theme code="offer.price.startingFrom" text="Starting from"/><br>
		<span class="price"><format:price priceData="${recurringPrice.price}"/></span>
		<br>
	</c:forEach>
	<div class="pay">${ycommerce:encodeHTML(billingTime)}</div>
	<br>
</c:if>
