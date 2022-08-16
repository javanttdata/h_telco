<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="compositePop" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaCompositeProdOfferPriceData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<%--
  ~ Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
  --%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:if test="${not empty compositePop.children}">

    <c:set var="numberOfRcs" value="0"/>
    <c:forEach items="${compositePop.children}" var="componentPop" varStatus="rcPricesCounter">
        <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
            <c:set var="numberOfRcs" value="${numberOfRcs + 1}"/>
        </c:if>
    </c:forEach>

    <c:forEach items="${compositePop.children}" var="componentPop" varStatus="rcPricesCounter">

        <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
            <c:set var="cycleStart" value="${componentPop.cycleStart}"/>
            <c:set var="cycleEnd" value="${componentPop.cycleEnd}"/>
            <c:set var="billingTime" value="${componentPop.priceEvent.name}"/>


            <c:choose>
                <c:when test="${empty cycleEnd or cycleEnd == '-1'}">
                    <c:if test="${numberOfRcs gt 1}">
                        <spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${cycleStart}"/>
                    </c:if>
                    <c:if test="${numberOfRcs eq 1 and cycleStart gt 1}">
                        <spring:theme code="product.list.viewplans.price.interval.unlimited" arguments="${cycleStart}"/>
                    </c:if>
                </c:when>

                <c:otherwise>
                    <spring:theme code="product.list.viewplans.price.interval" arguments="${cycleStart}, ${cycleEnd}"/>
                </c:otherwise>
            </c:choose>

            <br>
            <div class="pay">${ycommerce:encodeHTML(billingTime)}</div>
            <span class="price">
                <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.symbol}"/>
            </span>
            <br>
        </c:if>

    </c:forEach>

</c:if>
