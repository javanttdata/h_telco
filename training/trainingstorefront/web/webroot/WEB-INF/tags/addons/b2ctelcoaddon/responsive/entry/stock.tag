<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:set var="entryStock" value="${ycommerce:encodeHTML(orderEntry.product.stock.stockLevelStatus.code)}" />

<div class="item__stock">
    <c:choose>
        <c:when test="${entryStock ne 'outOfStock'}">
            <span class="stock"><spring:theme code="product.variants.in.stock" text="In Stock"/></span>
        </c:when>
        <c:when test="${empty orderEntry.deliveryPointOfService}">
            <span class="out-of-stock"><spring:theme code="product.variants.out.of.stock" text="Out of Stock"/></span>
        </c:when>
    </c:choose>
</div>

