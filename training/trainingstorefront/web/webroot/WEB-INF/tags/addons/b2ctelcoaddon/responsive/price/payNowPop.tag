<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="priceData" required="true" type="de.hybris.platform.commercefacades.product.data.PriceData" %>
<%@ attribute name="value" required="false" type="java.lang.Double" %>
<%@ attribute name="currency" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<%--
  ~ Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
  --%>
<c:set var="payNowPriceForSpo" value="0"/>
<c:set var="currencySymbol" value=""/>

<c:if test="${priceData.productOfferingPrice['class'].simpleName eq 'TmaCompositeProdOfferPriceData'}">
    <c:forEach var="componentPop" items="${priceData.productOfferingPrice.children}">

        <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
            <c:if test="${componentPop.priceEvent.code eq 'paynow'}">
                <c:set var="payNowPriceForSpo" value="${payNowPriceForSpo + componentPop.value}"/>
                <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
            </c:if>
        </c:if>
    </c:forEach>
</c:if>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:if test="${not empty priceData}">
    <c:set var="currency" value="${priceData.currencyIso}"/>

    <spring:theme code="product.payNow" text="Pay Now" var="billingTimeText"/>
    <c:if test="${empty priceData.productOfferingPrice}">
        <spring:theme code="text.free" text="FREE"/>
    </c:if>
    <c:if test="${not empty priceData.productOfferingPrice}">
        <c:choose>
            <c:when test="${payNowPriceForSpo > 0}">
                ${currency} ${payNowPriceForSpo}
            </c:when>
            <c:otherwise>
                <spring:theme code="text.free" text="FREE"/>
            </c:otherwise>
        </c:choose>
    </c:if>
</c:if>
