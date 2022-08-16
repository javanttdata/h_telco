<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntryNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="telcoYcommerce" uri="/WEB-INF/tld/addons/b2ctelcoaddon/ycommercetags.tld"%>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry"%>

<c:forEach items="${order.orderPrices}" var="orderPrice">
	<c:if
		test="${telcoYcommerce:doesPotentialPromotionExistForOrderEntryAndBillingTime(order, orderEntryNumber, orderPrice.billingTime)}">
		<order-entry:promotionsDisplay orderPriceBillingName="${orderPrice.billingTime.name}" orderEntryNumber="${orderEntryNumber}"
			productPromotions="${orderPrice.potentialProductPromotions}" />
	</c:if>
</c:forEach>

<c:forEach items="${order.orderPrices}" var="orderPrice">
	<c:if
		test="${telcoYcommerce:doesAppliedPromotionExistForOrderEntryAndBillingTime(order, orderEntryNumber, orderPrice.billingTime)}">
		<order-entry:promotionsDisplay orderPriceBillingName="${orderPrice.billingTime.name}" orderEntryNumber="${orderEntryNumber}"
			productPromotions="${orderPrice.appliedProductPromotions}" />
	</c:if>
</c:forEach>