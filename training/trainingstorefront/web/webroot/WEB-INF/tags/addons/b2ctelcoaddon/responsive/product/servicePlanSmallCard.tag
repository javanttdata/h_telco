<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="productData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="${productData.url}" var="productDataUrl" htmlEscape="false"/>

<c:set var="billingTimeName" value="${ycommerce:encodeHTML(productData.subscriptionTerm.billingPlan.billingTime.name)}"/>
<c:set var="SPO" value="TmaSimpleProductOffering"/>
<c:set var="BPO" value="TmaBundledProductOffering"/>

<li class="grid_view product__list--items col-lg-3 col-md-4 col-sm-4">
    <div class="full-grid">
        <div class="prod-wrapper">
            <div class="prod-content">
                <strong class="product__list--name" href="${productDataUrl}" title="${ycommerce:encodeHTML(productData.name)}">
                    ${ycommerce:encodeHTML(productData.name)}
                </strong>
                <div class="account-section-header no-border">
                    <div class="account-section-header__subheadline">
                        ${ycommerce:sanitizeHTML(productData.description)}
                    </div>
                </div>
                <c:if test="${productData.price != null}">
                    <div class="product__listing--price">
                        <div class="product-price">

                            <c:set var="otcPriceValue" value="0"/>
                            <c:set var="rcPriceValue" value="0"/>
                            <c:set var="currencySymbol" value=""/>

                            <c:forEach var="componentPop" items="${productData.price.productOfferingPrice.children}">
                                <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                                    <c:if test="${componentPop.priceEvent.code eq 'paynow'}">
                                        <c:set var="otcPriceValue" value="${otcPriceValue + componentPop.value}"/>
                                        <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
                                    </c:if>
                                </c:if>

                                <c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
                                    <c:set var="cycleStart" value="${componentPop.cycleStart}"/>

                                    <c:if test="${empty cycleStart or cycleStart eq 1 or cycleStart eq 0}">
                                        <c:set var="rcPriceValue" value="${componentPop.value}"/>
                                        <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <c:set var="popValue" value="${otcPriceValue}"/>
                            <c:if test="${rcPriceValue > 0}">
                                <c:set var="popValue" value="${rcPriceValue}"/>
                            </c:if>

                            <price:price value="${popValue}" currencySymbol="${currencySymbol}" displayFreeForZero="true"/>

                        </div>
                    </div>
                </c:if>
            </div>
            <c:choose>
                <c:when test="${productData.price != null}">
                    <c:if test="${productData.itemType eq SPO}">
                        <guidedselling:addSpoToCartForm product="${productData}" processType="ACQUISITION"/>
                    </c:if>
                    <c:if test="${productData.itemType eq BPO}">
                        <guidedselling:addToBpoConfiguration product="${spo}"
                                                             parentBpoCode="${ycommerce:encodeHTML(productData.code)}"
                                                             processType="ACQUISITION"/>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <spring:theme code="servicePlans.spo.priceNotFound"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div id="addToCartTitle" class="display-none">
        <div class="add-to-cart-header">
            <div class="headline">
                <span class="headline-text"><spring:theme code="basket.added.to.basket"/></span>
            </div>
        </div>
    </div>
</li>
