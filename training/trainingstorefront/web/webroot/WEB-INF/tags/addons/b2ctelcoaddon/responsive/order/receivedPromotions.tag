<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="telcoYcommerce" uri="/WEB-INF/tld/addons/b2ctelcoaddon/ycommercetags.tld" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:if test="${telcoYcommerce:doesAppliedPromotionExistForOrder(order)}">
	<div class="cartproline">
	 	<spring:theme code="basket.received.promotions" text="Received Promotions"/>
			<c:forEach items="${order.orderPrices}" var="orderPrice">
				<c:forEach items="${orderPrice.appliedOrderPromotions}" var="promotion">
					<div class="promotion">
						${ycommerce:encodeHTML(orderPrice.billingTime.name)}: ${ycommerce:encodeHTML(promotion.description)}
					</div>
				</c:forEach>
			</c:forEach>
	</div>
</c:if>