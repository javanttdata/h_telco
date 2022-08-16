<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ attribute name="consignmentEntry" required="false" type="de.hybris.platform.commercefacades.order.data.ConsignmentEntryData" %>
<%@ attribute name="showStock" required="false" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry"%>

<c:set var="shouldShowStock" value="${(empty showStock) ? true : showStock}" />

<li class="item__list--item">
	<order-entry:productImage orderEntry="${orderEntry}"/>
   	<order-entry:productDetails orderEntry="${orderEntry}" order="${order}" showStock="${shouldShowStock}" />
	<order-entry:quantity orderEntry="${orderEntry}" consignmentEntryQuantity="${consignmentEntry.quantity}"/>
	<order-entry:delivery orderEntry="${orderEntry}"/>
	<order-entry:price orderEntry="${orderEntry}"/>
</li>
