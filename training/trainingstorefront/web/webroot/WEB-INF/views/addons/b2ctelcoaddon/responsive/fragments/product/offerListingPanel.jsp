<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling"%>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<%--@elvariable id="subscriptionInfo" type="de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionBaseData"--%>
<%--@elvariable id="offers" type="java.util.List<de.hybris.platform.b2ctelcofacades.data.TmaOfferData>"--%>

<div id="offer-listing-panel">
    <c:choose>
        <c:when test="${empty offers}">
            <h4 class="centerAligned"><br/><spring:theme code="offer.noOfferAvailable" text="No offer available."/></h4>
            <telco-product:deviceOnlyPricePanel product="${product}"/>
        </c:when>
        <c:otherwise>
            <table class="retention-offer-table">
                <tr>
                    <th><spring:theme code="offer.table.header.offering" text="Offering"/></th>
                    <th><spring:theme code="offer.table.header.devicePrice" text="Device Price"/></th>
                    <th><spring:theme code="offer.table.header.action" text="Action"/></th>
                </tr>
                <c:forEach var="offer" items="${offers}">
                    <c:set var="offerPriceData" value="${offer.product.price}"/>
                    <c:if test="${not empty offer.product.mainSpoPriceInBpo}">
                        <c:set var="offerPriceData" value="${offer.product.mainSpoPriceInBpo}"/>
                    </c:if>
                    <tr>
                        <td>
                            ${offer.parentBpo.name}
                        </td>
                        <td>
                            <spring:theme code="offer.price.startingFrom" text="Starting from"/><br/>

                            <c:set var="payNowPriceForSpo" value="0"/>
                            <c:set var="currencySymbol" value=""/>

                            <c:forEach var="componentPop" items="${offerPriceData.productOfferingPrice.children}">
                                <c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
                                    <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
                                    <c:if test="${componentPop.priceEvent.code eq 'paynow'}">
                                        <c:set var="payNowPriceForSpo" value="${payNowPriceForSpo + componentPop.value}"/>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <price:price value="${payNowPriceForSpo}" currencySymbol="${currencySymbol}"/>
                        </td>

                        <td>
                            <c:set var="subscriptionTermId" value="${offer.product.mainSpoPriceInBpo.subscriptionTerms[0].id}"/>
                            <guidedselling:addBpoToCartForm parentBpoCode="${offer.parentBpo.code}" spo1="${offer.product}"
                                                            processType="${processType}"
                                                            subscriberIdentity="${subscriptionInfo.subscriberIdentity}"
                                                            subscriberBillingId="${subscriptionInfo.billingSystemId}"
                                                            subscriptionTermId="${subscriptionTermId}"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>
