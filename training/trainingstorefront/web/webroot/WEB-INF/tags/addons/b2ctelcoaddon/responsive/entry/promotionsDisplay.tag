<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderPriceBillingName" required="true" type="java.lang.String" %>
<%@ attribute name="orderEntryNumber" required="true" type="java.lang.Integer" %>
<%@ attribute name="productPromotions" required="true" type="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<ul class="cart-promotions">
	<li class="">${ycommerce:encodeHTML(orderPriceBillingName)}:</li>
	<c:forEach items="${productPromotions}" var="promotion">
		<c:set var="displayed" value="false" />
		<c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
			<c:if test="${not displayed and consumedEntry.orderEntryNumber == orderEntryNumber and not empty promotion.description}">
				<c:set var="displayed" value="true" />
				<li class="cart-promotions-potential"><span>${ycommerce:sanitizeHTML(promotion.description)}</span></li>
			</c:if>
		</c:forEach>
	</c:forEach>
</ul>