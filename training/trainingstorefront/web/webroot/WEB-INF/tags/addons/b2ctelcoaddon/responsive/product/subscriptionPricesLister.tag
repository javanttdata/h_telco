<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="subscriptionData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>


<c:set var="otcPopsSize" value="0"/>
<c:set var="rcPopsSize" value="0"/>
<c:if test="${not empty subscriptionData.price.productOfferingPrice.children}">
    <c:forEach var="componentPop" items="${subscriptionData.price.productOfferingPrice.children}">

        <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
            <c:set var="otcPopsSize" value="${otcPopsSize + 1}"/>
        </c:if>

        <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
            <c:set var="rcPopsSize" value="${rcPopsSize + 1}"/>
        </c:if>

    </c:forEach>
</c:if>


<c:if test="${rcPopsSize > 0}">
    <c:forEach var="componentPop" items="${subscriptionData.price.productOfferingPrice.children}">

        <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
            <c:choose>
                <c:when test="${componentPop.cycleEnd == null}">
                    <c:if test="${rcPopsSize gt 1}">
                        <spring:theme code="product.list.viewplans.price.interval.unlimited"
                                      arguments="${componentPop.cycleStart}"/>
                    </c:if>
                    <c:if test="${rcPopsSize eq 1 and componentPop.cycleStart gt 1}">
                        <spring:theme code="product.list.viewplans.price.interval.unlimited"
                                      arguments="${componentPop.cycleStart}"/>
                    </c:if>
                    <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.isocode}"/>
                </c:when>
                <c:otherwise>
                    <spring:theme code="product.list.viewplans.price.interval"
                                  arguments="${componentPop.cycleStart}, ${componentPop.cycleEnd}"/>
                    <br>
                    <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.isocode}"/>
                </c:otherwise>
            </c:choose>
            <br>
        </c:if>

    </c:forEach>

    <div class="pay">${ycommerce:encodeHTML(subscriptionData.subscriptionTerm.billingPlan.billingTime.name)}</div>
</c:if>

<c:if test="${otcPopsSize > 0}">
    <c:if test="${rcPopsSize > 0}">
        <br>
    </c:if>

    <c:forEach var="componentPop" items="${subscriptionData.price.productOfferingPrice.children}">

        <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
            <spring:theme code="product.list.viewplans.price.onetime" arguments="${componentPop.name}"/>
            <price:price value="${componentPop.value}" currencySymbol="${componentPop.currency.isocode}"/>
            <div class="pay">${ycommerce:encodeHTML(oneTimePrice.billingTime.name)}</div>
            <br/>
        </c:if>

    </c:forEach>

</c:if>

