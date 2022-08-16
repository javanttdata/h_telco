<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ attribute name="processType" required="true" type="java.lang.String"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/cart/add" var="sbgAddToCart" htmlEscape="false" />

<form:form id="addToCartForm" class="add_to_cart_form" action="${sbgAddToCart}" method="post">
	<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(product.code)}" />
	<input type="hidden" name="processType" value="${processType}" />
	<button type="submit" class="btn btn-block btn-primary btn-dark-style js-enable-btn" disabled="disabled">
		<spring:theme code="basket.add.to.basket" text="Add To Cart" />
	</button>
</form:form>
