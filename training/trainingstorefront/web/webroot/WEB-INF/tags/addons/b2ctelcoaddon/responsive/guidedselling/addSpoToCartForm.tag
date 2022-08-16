<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="processType" required="true" type="java.lang.String" %>
<%@ attribute name="subscriptionTermId" required="false" type="java.lang.String" %>
<%@ attribute name="parentBpoCode" required="false" type="java.lang.String" %>
<%@ attribute name="parentEntryNumber" required="false" type="java.lang.Integer" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/cart/add" var="addSpoToCartUrl" htmlEscape="false"/>
<spring:theme code="basket.add.to.basket" text="Add To Basket" var="addToBasketText"/>

<c:if test="${product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
	<form:form id="addToCartForm" class="add_to_cart_form" action="${addSpoToCartUrl}" method="post">
		<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(product.code)}"/>
		<input type="hidden" name="processType" value="${ycommerce:encodeHTML(processType)}"/>
		<input type="hidden" name="rootBpoCode" value="${ycommerce:encodeHTML(parentBpoCode)}"/>
		<input type="hidden" name="parentEntryNumber" value="${parentEntryNumber}"/>
		<c:if test="${not empty subscriptionTermId}">
			<input type="hidden" name="subscriptionTerm" value="${ycommerce:encodeHTML(subscriptionTermId)}"/>
		</c:if>
		<button class="btn btn-block btn-primary btn-dark-style js-enable-btn" title="${addToBasketText}">
				${addToBasketText}
		</button>
	</form:form>
</c:if>
<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock'}">
	<spring:theme code="text.addToCart.outOfStock" text="Out of Stock"/>
</c:if>
