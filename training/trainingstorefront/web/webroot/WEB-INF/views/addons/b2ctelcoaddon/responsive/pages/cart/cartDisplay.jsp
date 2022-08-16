<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:set var="allEntriesCount" value="${fn:length(cartData.entries)}" />

<div class="cart-header border">
	<div class="row">
		<div class="col-xs-12 col-sm-5">
			<h1 class="cart-headline">
				<spring:theme code="text.cart" text="Cart" />
				<c:if test="${not empty cartData.code}">
					<span class="cart__id--label">
						<spring:theme code="basket.page.cartIdShort" />
						<span class="cart__id">${ycommerce:encodeHTML(cartData.code)}</span>
					</span>
				</c:if>
			</h1>
		</div>

	</div>
</div>
<c:if test="${not empty cartData.invalidMessages}">
	<cart:cartNotificationHeader cartData="${cartData}" />
</c:if>
<c:if test="${not empty cartData.entries}">

	<spring:url value="/cart/checkout" var="checkoutUrl" scope="session" htmlEscape="false" />
	<spring:url value="${continueUrl}" var="continueShoppingUrl" scope="session" htmlEscape="false" />
	<c:set var="showTax" value="false" />

	<div class="row">
		<div class="col-xs-12 pull-right cart-actions--print">
			<div class="cart__actions border">
				<div class="row">
					<div class="col-sm-4 col-md-3 pull-right">
						<button class="btn btn-primary btn-block btn--continue-checkout js-continue-checkout-button" data-checkout-url="${checkoutUrl}">
							<spring:theme code="checkout.checkout" text="Checkout" />
						</button>
					</div>
					<div class="col-sm-4 col-md-3 pull-right">
						<button class="btn btn-default btn-block btn--continue-shopping js-continue-shopping-button" data-continue-shopping-url="${continueShoppingUrl}">
							<spring:theme code="cart.page.continue" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class=" col-xs-12 col-md-3 pull-left"></div>

		<div class="col-sm-12 col-md-4 col-md-push-5">
			<div class="js-cart-top-totals cart__top--totals">
				<c:choose>
					<c:when test="${allEntriesCount > 1 or allEntriesCount == 0}">
						<spring:theme code="basket.page.totals.total.items" arguments="${allEntriesCount}" />
					</c:when>
					<c:otherwise>
						<spring:theme code="basket.page.totals.total.items.one" arguments="${allEntriesCount}" />
					</c:otherwise>
				</c:choose>

			</div>
		</div>
	</div>

	<cart:cartItems cartData="${cartData}" />
	<cart:cartNotification cartData="${cartData}" />
</c:if>

