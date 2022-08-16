<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="consignmentCode" required="true" type="java.lang.String" %>
<%@ attribute name="orderData" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>
<%@ attribute name="inProgress" required="false" type="java.lang.Boolean" %>
<%@ attribute name="consignment" required="true" type="de.hybris.platform.commercefacades.order.data.ConsignmentData" %>
<%@ taglib prefix="telco-order" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/order" %>

<div class="product-item-list-holder fulfilment-states-${consignmentCode}">
	<telco-order:accountOrderDetailsItem orderData="${orderData}" consignment="${consignment}" inProgress="${inProgress}"/>
</div>