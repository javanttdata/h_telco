<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="recurringCharges" required="true"
              type="java.util.List<de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderRecurringChargePriceData>" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:set var="recurringChargesSize" value="${fn:length(recurringCharges)}"/>
<c:if test="${not empty recurringCharges}">
    <c:forEach items="${recurringCharges}" var="recurringPrice">
        <c:set var="cycleStart" value="${recurringPrice.cycleStart}"/>
        <c:set var="cycleEnd" value="${recurringPrice.cycleEnd}"/>
        <c:set var="billingTime" value="${recurringPrice.billingTime.name}"/>
        <div class="pay">
                <c:choose>
                    <c:when test="${empty cycleEnd}">
                        <spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${cycleStart}"/>
                    </c:when>
                    <c:otherwise>
                        <spring:theme code="product.list.viewplans.price.interval" arguments="${cycleStart}, ${cycleEnd}"/>
                    </c:otherwise>
                </c:choose>
                <format:price priceData="${recurringPrice.dutyFreeAmount}" displayFreeForZero="false"/> &nbsp;
            <b>${ycommerce:encodeHTML(billingTime)}</b>
        </div>
    </c:forEach>
</c:if>
