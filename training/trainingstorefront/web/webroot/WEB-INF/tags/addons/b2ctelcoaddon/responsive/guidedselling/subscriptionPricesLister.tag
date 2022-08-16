<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptionData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:theme code="offer.price.startingFrom" text="Starting from" var="startingFromText"/>

<c:if test="${not empty subscriptionData.mainSpoPriceInBpo}">
    <spring:theme code="product.payNow" text="Pay Now" var="billingTimeText"/>

    <c:set var="currencySymbol" value=""/>

    <c:set var="otcPopsSize" value="0"/>
    <c:set var="rcPopsSize" value="0"/>
    <c:if test="${not empty subscriptionData.mainSpoPriceInBpo.productOfferingPrice.children}">
        <c:forEach var="componentPop" items="${subscriptionData.mainSpoPriceInBpo.productOfferingPrice.children}">

            <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>

            <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                <c:set var="otcPopsSize" value="${otcPopsSize + 1}"/>
            </c:if>

            <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
                <c:set var="rcPopsSize" value="${rcPopsSize + 1}"/>
            </c:if>

        </c:forEach>
    </c:if>

    <c:if test="${rcPopsSize == 0 and otcPopsSize == 0}">
        ${startingFromText}
        <br>

        <price:price value="0" currencySymbol="${currencySymbol}"/>
        <br>
        ${billingTimeText}
        <br>
    </c:if>
    <price:recurringPopLister compositePop="${subscriptionData.mainSpoPriceInBpo.productOfferingPrice}"/>
    <price:oneTimePopLister compositePop="${subscriptionData.mainSpoPriceInBpo.productOfferingPrice}"/>
</c:if>

<br>

<c:choose>
    <c:when test="${not empty subscriptionData.additionalSpoPriceInBpo}">

        <c:set var="currencySymbol" value=""/>

        <c:set var="otcPopsSize" value="0"/>
        <c:set var="rcPopsSize" value="0"/>
        <c:if test="${not empty subscriptionData.additionalSpoPriceInBpo.productOfferingPrice.children}">
            <c:forEach var="componentPop"
                       items="${subscriptionData.additionalSpoPriceInBpo.productOfferingPrice.children}">

                <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
                <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                    <c:set var="otcPopsSize" value="${otcPopsSize + 1}"/>
                </c:if>

                <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
                    <c:set var="rcPopsSize" value="${rcPopsSize + 1}"/>
                </c:if>

            </c:forEach>
        </c:if>


        <c:if test="${rcPopsSize == 0 and otcPopsSize == 0}">
            ${startingFromText}
            <br>
            <price:price value="0" currencySymbol="${currencySymbol}"/>
            <br>
            ${billingTimeText}
            <br>
        </c:if>
        <price:recurringPopLister compositePop="${subscriptionData.additionalSpoPriceInBpo.productOfferingPrice}"/>
        <price:oneTimePopLister compositePop="${subscriptionData.additionalSpoPriceInBpo.productOfferingPrice}"/>
    </c:when>

    <c:otherwise>
        <price:recurringPopLister compositePop="${subscriptionData.price.productOfferingPrice}"/>
        <price:oneTimePopLister compositePop="${subscriptionData.price.productOfferingPrice}"/>
    </c:otherwise>
</c:choose>

