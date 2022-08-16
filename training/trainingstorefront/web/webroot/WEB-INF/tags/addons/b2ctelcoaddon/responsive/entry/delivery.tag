<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:set var="entryStock" value="${ycommerce:encodeHTML(orderEntry.product.stock.stockLevelStatus.code)}" />
<c:set var="delPointOfServiceName" value="${ycommerce:encodeHTML(orderEntry.deliveryPointOfService.name)}" />

<c:if test="${orderEntry.product.purchasable}">
	<div class="item__delivery hidden-xs hidden-sm">
		<c:if test="${entryStock ne 'outOfStock'}">
			<c:if test="${empty orderEntry.deliveryPointOfService or not orderEntry.product.availableForPickup}">
				<span class="item__delivery--label">
					<spring:theme code="basket.page.shipping.ship" text="Ship" />
				</span>
			</c:if>
		</c:if>
		<c:if test="${not empty delPointOfServiceName}">
			<span class="item__delivery--label">
				<spring:theme code="basket.page.shipping.pickup" text="Pickup" />
			</span>
			<c:if test="${orderEntry.product.availableForPickup}">
				<div class="item__delivery--store">${delPointOfServiceName}</div>
			</c:if>
		</c:if>
	</div>
</c:if>