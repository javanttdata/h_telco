<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="showDeliveryAddress" required="true" type="java.lang.Boolean"%>
<%@ attribute name="showPaymentInfo" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="multi-checkout-telco" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart"%>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/responsive/order"%>

<c:if test="${not empty cartData}">
	<div class="checkout-summary-headline hidden-xs">
		<spring:theme code="checkout.multi.order.summary" text="Order Summary" />
	</div>
</c:if>
<div class="checkout-order-summary">
	<multi-checkout-telco:deliveryCartItems cartData="${cartData}" showDeliveryAddress="${showDeliveryAddress}" />
	<c:forEach items="${cartData.pickupOrderGroups}" var="groupData">
		<multi-checkout:pickupCartItems cartData="${cartData}" groupData="${groupData}" showHead="true" />
	</c:forEach>
	<multi-checkout:paymentInfo cartData="${cartData}" paymentInfo="${cartData.paymentInfo}" showPaymentInfo="${showPaymentInfo}" />
	<br>
	<cart:cartTotals cartData="${cartData}" />
	<order:appliedVouchers order="${cartData}" />
	<cart:cartPromotions cartData="${cartData}" />
</div>
