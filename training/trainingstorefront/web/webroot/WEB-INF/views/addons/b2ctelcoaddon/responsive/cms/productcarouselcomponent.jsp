<%--
  ~ Copyright (c) 2020 SAP SE or an SAP affiliate company.  All rights reserved.
  --%>

<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>


<spring:htmlEscape defaultHtmlEscape="true"/>

<c:choose>
    <c:when test="${not empty productData}">
        <div class="carousel__component">
            <div class="carousel__component--headline">${fn:escapeXml(title)}</div>

            <c:choose>
                <c:when test="${component.popup}">
                    <div class="carousel__component--carousel js-owl-carousel js-owl-lazy-reference js-owl-carousel-reference">
                        <div id="quickViewTitle" class="quickView-header display-none">
                            <div class="headline">
                                <span class="headline-text"><spring:theme code="popup.quick.view.select"/></span>
                            </div>
                        </div>
                        <c:forEach items="${productData}" var="product">

                            <c:url value="${product.url}/quickView" var="productQuickViewUrl"/>
                            <div class="carousel__item">
                                <a href="${productQuickViewUrl}" class="js-reference-item">
                                    <div class="carousel__item--thumb">
                                        <product:productPrimaryReferenceImage product="${product}" format="product"/>
                                    </div>
                                    <div class="carousel__item--name">${fn:escapeXml(product.name)}</div>
                                    <div class="carousel__item--price">
                                        <c:set var="otcPriceValue" value="0"/>
                                        <c:set var="rcPriceValue" value="0"/>
                                        <c:set var="currencySymbol" value=""/>

                                        <c:forEach var="componentPop" items="${product.prices}">
                                            <c:if test="${componentPop.productOfferingPrice['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                                                <c:if test="${componentPop.productOfferingPrice.priceEvent.code eq 'paynow'}">
                                                    <c:set var="otcPriceValue"
                                                           value="${otcPriceValue + componentPop.productOfferingPrice.value}"/>
                                                    <c:set var="currencySymbol"
                                                           value="${componentPop.productOfferingPrice.currency.symbol}"/>
                                                </c:if>
                                            </c:if>

                                            <c:if test="${componentPop.productOfferingPrice['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
                                                <c:set var="billingTime"
                                                       value="${componentPop.productOfferingPrice.priceEvent.name}"/>
                                                <c:set var="cycleStart" value="${componentPop.productOfferingPrice.cycleStart}"/>

                                                <c:if test="${empty cycleStart or cycleStart eq 1 or cycleStart eq 0}">
                                                    <c:set var="rcPriceValue" value="${componentPop.productOfferingPrice.value}"/>
                                                    <c:set var="currencySymbol"
                                                           value="${componentPop.productOfferingPrice.currency.symbol}"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                        <spring:theme code="entry.payoncheckout" text="Pay On Checkout:" var="priceMessage"/>
                                        <c:set var="popValue" value="${otcPriceValue}"/>
                                        <c:if test="${rcPriceValue > 0}">
                                            <c:set var="priceMessage" value="${billingTime}"/>
                                            <c:set var="popValue" value="${rcPriceValue}"/>
                                        </c:if>

                                        <div>
                                            <price:price value="${popValue}" currencySymbol="${currencySymbol}"
                                                         displayFreeForZero="true"/>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="carousel__component--carousel js-owl-carousel js-owl-default">
                        <c:forEach items="${productData}" var="product">

                            <c:url value="${product.url}" var="productUrl"/>

                            <div class="carousel__item">
                                <a href="${productUrl}">
                                    <div class="carousel__item--thumb">
                                        <product:productPrimaryImage product="${product}" format="product"/>
                                    </div>
                                    <div class="carousel__item--name">${fn:escapeXml(product.name)}</div>
                                    <div class="carousel__item--price">
                                        <c:set var="otcPriceValue" value="0"/>
                                        <c:set var="rcPriceValue" value="0"/>
                                        <c:set var="currencySymbol" value=""/>

                                        <c:forEach var="componentPop" items="${product.prices}">
                                            <c:if test="${componentPop.productOfferingPrice['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                                                <c:if test="${componentPop.productOfferingPrice.priceEvent.code eq 'paynow'}">
                                                    <c:set var="otcPriceValue"
                                                           value="${otcPriceValue + componentPop.productOfferingPrice.value}"/>
                                                    <c:set var="currencySymbol"
                                                           value="${componentPop.productOfferingPrice.currency.symbol}"/>
                                                </c:if>
                                            </c:if>

                                            <c:if test="${componentPop.productOfferingPrice['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
                                                <c:set var="billingTime"
                                                       value="${componentPop.productOfferingPrice.priceEvent.name}"/>
                                                <c:set var="cycleStart" value="${componentPop.productOfferingPrice.cycleStart}"/>

                                                <c:if test="${empty cycleStart or cycleStart eq 1 or cycleStart eq 0}">
                                                    <c:set var="rcPriceValue" value="${componentPop.productOfferingPrice.value}"/>
                                                    <c:set var="currencySymbol"
                                                           value="${componentPop.productOfferingPrice.currency.symbol}"/>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                        <spring:theme code="entry.payoncheckout" text="Pay On Checkout:" var="priceMessage"/>
                                        <c:set var="popValue" value="${otcPriceValue}"/>
                                        <c:if test="${rcPriceValue > 0}">
                                            <c:set var="priceMessage" value="${billingTime}"/>
                                            <c:set var="popValue" value="${rcPriceValue}"/>
                                        </c:if>

                                        <div>
                                            <price:price value="${popValue}" currencySymbol="${currencySymbol}"
                                                         displayFreeForZero="true"/>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:when>

    <c:otherwise>
        <component:emptyComponent/>
    </c:otherwise>
</c:choose>

