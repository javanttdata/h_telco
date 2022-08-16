<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<div class="order-total">
    <div class="row">
        <div class="col-xs-8 col-sm-8">
            <div class="totals">
                <spring:theme code="entry.payoncheckout" text="Pay On Checkout:"/>
            </div>
        </div>

        <div class="col-xs-4 col-sm-4 text-right">
            <div class="text-right totals">
                <format:price priceData="${order.subTotal}"/>
            </div>
        </div>

        <c:if test="${order.totalDiscounts.value > 0}">
            <div class="col-xs-8 col-sm-8">
                <div class="subtotals__item--state-discount">
                    <spring:theme code="text.account.order.discount" text="Discount:"/>
                </div>
            </div>
            <div class="col-xs-4 col-sm-4">
                <div class="text-right subtotals__item--state-discount">
                    <format:price priceData="${order.totalDiscounts}" displayNegationForDiscount="true"/>
                </div>
            </div>
        </c:if>

        <div class="col-xs-8 col-sm-8">
            <spring:theme code="text.account.order.shipping" text="Shipping:"/>
        </div>
        <structure:orderPriceWrapper>
            <format:price priceData="${order.deliveryCost}" displayFreeForZero="true"/>
        </structure:orderPriceWrapper>

        <c:if test="${order.net}">
            <div class="col-xs-8 col-sm-8">
                <spring:theme code="text.account.order.netTax" text="Tax:"/>
            </div>
            <structure:orderPriceWrapper>
                <format:price priceData="${order.totalTax}"/>
            </structure:orderPriceWrapper>
        </c:if>

        <div class="col-xs-8 col-sm-8">
            <div class="totals">
                <spring:theme code="text.account.order.orderTotals.payNow" text="Pay On Checkout Total"/>
            </div>
        </div>

        <c:choose>
            <c:when test="${order.net}">
                <div class="col-xs-4 col-sm-4">
                    <div class="text-right totals">
                        <format:price priceData="${order.totalPriceWithTax}"/>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="col-xs-4 col-sm-4 text-right">
                    <div class="totals">
                        <format:price priceData="${order.totalPrice}"/>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="account-orderdetail-orderTotalDiscount-section">
    <c:if test="${not order.net}">
        <div class="order-total__taxes">
            <spring:theme code="text.account.order.total.includesTax.payNowTax" argumentSeparator=";"
                          arguments="${order.totalTax.formattedValue}"/>
        </div>
        <br/>
    </c:if>
</div>
