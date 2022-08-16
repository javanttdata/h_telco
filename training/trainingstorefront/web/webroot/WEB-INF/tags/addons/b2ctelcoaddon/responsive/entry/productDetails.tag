<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ attribute name="showStock" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>

<c:set var="product" value="${orderEntry.product}"/>
<spring:url value="${product.url}" var="productUrl"/>

<div class="item__info">
    <a href="${productUrl}"><span class="item__name">${ycommerce:encodeHTML(product.name)}</span></a>
    <order-entry:variantDetails product="${product}"/>

    <c:if test="${showStock}">
        <order-entry:stock orderEntry="${orderEntry}"/>
    </c:if>
    <order-entry:promotions orderEntryNumber="${orderEntry.entryNumber}" order="${order}"/>
</div>
