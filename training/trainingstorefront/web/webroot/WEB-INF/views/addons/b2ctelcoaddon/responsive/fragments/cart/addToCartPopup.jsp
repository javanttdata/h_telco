<%@ page trimDirectiveWhitespaces="true" contentType="application/json" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/cart" var="cartUrl" htmlEscape="false" />

{"cartData": {
"total": "${cartData.totalPrice.value}",
"products": [
<c:forEach items="${cartData.entries}" var="cartEntry" varStatus="status">
	{
		"sku":		"${ycommerce:encodeHTML(cartEntry.product.code)}",
		"name": 	"<c:out value='${ycommerce:encodeHTML(cartEntry.product.name)}' />",
		"qty": 		"${cartEntry.quantity}",
		"price": 	"${cartEntry.basePrice.value}",
		"categories": [
		<c:forEach items="${cartEntry.product.categories}" var="category" varStatus="categoryStatus">
			"<c:out value='${ycommerce:encodeHTML(category.name)}' />"<c:if test="${not categoryStatus.last}">,</c:if>
		</c:forEach>
		]
	}<c:if test="${not status.last}">,</c:if>
</c:forEach>
]
},

"cartAnalyticsData":{"cartCode" : "${cartCode}","productPostPrice":"${entry.basePrice.value}","productName":"<c:out value='${ycommerce:encodeHTML(product.name)}' />"}
,
"addToCartLayer":"<spring:escapeBody javaScriptEscape="true" htmlEscape="false">
	<spring:htmlEscape defaultHtmlEscape="true">
	<spring:theme code="text.addToCart" var="addToCartText"/>
		<div id="addToCartLayer" class="add-to-cart">
            <div class="cart_popup_error_msg">
                <spring:theme code="${errorMsg}" />
            </div>
            <c:choose>
                <c:when test="${modifiedCartData ne null}">
                    <c:forEach items="${modifiedCartData}" var="modification">
                        <c:set var="product" value="${modification.entry.product}" />
                        <c:set var="entry" value="${modification.entry}" />
                        <c:set var="quantity" value="${modification.quantityAdded}" />
                        <cart:popupCartItems entry="${entry}" product="${product}" quantity="${quantity}"/>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <cart:popupCartItems entry="${entry}" product="${product}" quantity="${quantity}"/>
                </c:otherwise>
            </c:choose>
                <a href="${cartUrl}" class="btn btn-primary btn-block add-to-cart-button">
	                  <spring:theme code="checkout.checkout"  text="Checkout"/>
                </a>
                <a href="" class="btn btn-default btn-block js-mini-cart-close-button">
                <spring:theme code="cart.page.continue" text="Continue Shopping"/>
                </a>
		</div>
	</spring:htmlEscape>
</spring:escapeBody>"
}
