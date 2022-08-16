<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="telcoYcommerce" uri="/WEB-INF/tld/ycommercetags.tld" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:if test="${telcoYcommerce:doesAppliedPromotionExistForOrder(cartData)}">
	<div class="cartproline">
		<spring:theme code="basket.received.promotions" text="Received Promotions" />
		<c:forEach items="${cartData.orderPrices}" var="orderPrice">
			<c:forEach items="${orderPrice.appliedOrderPromotions}" var="promotion">
				<div class="promotion">${ycommerce:encodeHTML(orderPrice.billingTime.name)} :
					${ycommerce:sanitizeHTML(promotion.description)}
				</div>
			</c:forEach>
		</c:forEach>
	</div>
</c:if>
