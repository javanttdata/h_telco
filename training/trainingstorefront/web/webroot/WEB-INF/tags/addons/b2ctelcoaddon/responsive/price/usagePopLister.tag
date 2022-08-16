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

    <c:set var="numberOfUcs" value="0"/>
    <c:forEach items="${compositePop.children}" var="componentPop" varStatus="ucPricesCounter">
        <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
            <c:set var="numberOfUcs" value="${numberOfUcs + 1}"/>
        </c:if>
    </c:forEach>

    <c:forEach items="${compositePop.children}" var="componentPop">

        <c:if test="${componentPop['class'].simpleName eq 'TmaUsageProdOfferPriceChargeData'}">
            <c:set var="tierStart" value="${componentPop.tierStart}"/>
            <c:set var="tierEnd" value="${componentPop.tierEnd}"/>
            <c:set var="usageUnit" value="${componentPop.usageUnit.name}"/>
            <c:set var="singleUc" value="0"/>

            <c:choose>
                <c:when test="${empty tierEnd or tierEnd == '-1'}">

                    <c:choose>
                        <c:when test="${(numberOfUcs gt 1) or (numberOfUcs eq 1 and tierStart gt 1)}">
                            <spring:theme code="product.list.viewplans.price.tier.unlimited" arguments="${tierStart}, ${usageUnit}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="singleUc" value="1"/>
                        </c:otherwise>
                    </c:choose>

                </c:when>

                <c:otherwise>
                    <spring:theme code="product.list.viewplans.price.tier"
                                  arguments="${tierStart}, ${tierEnd}, ${usageUnit}"/>
                </c:otherwise>
            </c:choose>

            <br>
            <span class="price">
                <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.symbol}"/>
                <c:if test="${singleUc eq 1}">
                    <c:set var="emptyValue" value=""/>
                    <spring:theme code="product.list.viewplans.overageUsageChargeEntry" arguments="${emptyValue}, ${usageUnit}"/>
                </c:if>
            </span>
            <br/>
        </c:if>

    </c:forEach>

</c:if>
