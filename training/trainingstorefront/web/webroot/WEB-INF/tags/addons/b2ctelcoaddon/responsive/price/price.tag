<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="value" required="true" type="java.lang.Double" %>
<%@ attribute name="currencySymbol" required="true" type="java.lang.String" %>
<%@ attribute name="displayFreeForZero" required="false" type="java.lang.Boolean" %>
<%@ attribute name="displayNegationForDiscount" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<%--
  ~ Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
  --%>

<spring:htmlEscape defaultHtmlEscape="true" />

<%--
 Tag to render a currency formatted price.
 Includes the currency symbol for the specific currency.
--%>
<c:set value="${fn:escapeXml(value.toString())}" var="priceValue"/>
<c:set value="${fn:escapeXml(currencySymbol)}" var="currency"/>
<c:choose>
    <c:when test="${value > 0}">
        <c:if test="${displayNegationForDiscount}">
            -
        </c:if>
        ${currency}${priceValue}
    </c:when>
    <c:otherwise>
        <c:if test="${displayFreeForZero}">
            <spring:theme code="text.free" text="FREE"/>
        </c:if>
        <c:if test="${not displayFreeForZero}">
            ${currency}${priceValue}
        </c:if>
    </c:otherwise>
</c:choose>
