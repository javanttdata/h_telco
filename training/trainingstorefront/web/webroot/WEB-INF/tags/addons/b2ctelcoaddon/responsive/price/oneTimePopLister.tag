<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="compositePop" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaCompositeProdOfferPriceData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<%--
  ~ Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
  --%>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:forEach items="${compositePop.children}" var="componentPop" varStatus="oneTimePricesCounter">

    <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
        <span class="price">
            <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.symbol}"/>
        </span>
        <div class="pay">${ycommerce:encodeHTML(componentPop.priceEvent.name)}</div>
        <br>
    </c:if>

</c:forEach>
