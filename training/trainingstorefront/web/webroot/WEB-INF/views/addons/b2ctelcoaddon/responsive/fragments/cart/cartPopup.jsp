<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:theme code="text.addToCart" var="addToCartText" />
<spring:theme code="text.popupCartTitle" var="popupCartTitleText" />
<spring:url value="/cart" var="cartUrl" htmlEscape="false" />
<spring:url value="/cart/checkout" var="checkoutUrl" htmlEscape="false" />

<div class="mini-cart js-mini-cart">
	<div class="mini-cart-body">
		<c:choose>
			<c:when test="${numberShowing > 0 }">
				<div class="legend">
					<spring:theme code="popup.cart.showing" arguments="${numberShowing},${numberItemsInCart}" />
					<c:if test="${numberItemsInCart > numberShowing}">
						<a href="${cartUrl}">
							<spring:theme code="popup.cart.showall" text="Show All" />
						</a>
					</c:if>
				</div>

				<ol class="mini-cart-list">
					<c:forEach items="${entries}" var="entry" end="${numberShowing - 1}">
						<spring:url value="${entry.product.url}" var="entryProductUrl" htmlEscape="false" />
						<li class="mini-cart-item">
							<div class="thumb">
								<a href="${entryProductUrl}">
									<product:productPrimaryImage product="${entry.product}" format="cartIcon" />
								</a>
							</div>
							<div class="details">
								<a class="name" href="${entryProductUrl}">${ycommerce:encodeHTML(entry.product.name)}</a>

								<div class="qty">
									<spring:theme code="popup.cart.quantity" text="Quantity" />
									: ${entry.quantity}
								</div>

                                <order-entry:variantDetails product="${entry.product}"/>
								<c:if test="${not empty entry.deliveryPointOfService.name}">

									<div class="itemPickup">
										<span class="itemPickupLabel">
											<spring:theme code="popup.cart.pickup" text="Pick Up" />
										</span>
										&nbsp;${ycommerce:encodeHTML(entry.deliveryPointOfService.name)}
									</div>
								</c:if>
							</div>
							<div class="price">
								<c:choose>
									<c:when
										test="${entry.product.itemType eq 'ServicePlan' or entry.product.itemType eq 'ServiceAddOn' or entry.product.itemType eq 'SubscriptionProduct'}">
										<c:forEach items="${entry.orderEntryPrices}" var="orderEntryPrice">
											<c:if test="${orderEntryPrice.defaultPrice}">
												<format:price priceData="${orderEntryPrice.totalPrice}" />
											</c:if>
										</c:forEach>
										<br>
										<span class="prod-price-info">${ycommerce:encodeHTML(entry.product.subscriptionTerm.billingPlan.billingTime.name)} </span>
									</c:when>
									<c:otherwise>
										<format:price priceData="${entry.totalPrice}" />
									</c:otherwise>
								</c:choose>
							</div>
						</li>
					</c:forEach>
				</ol>


				<c:if test="${not empty lightboxBannerComponent && lightboxBannerComponent.visible}">
					<cms:component component="${lightboxBannerComponent}" evaluateRestriction="true" />
				</c:if>

				<div class="mini-cart-totals">
					<div class="value">
						<table class="prod_cart-total-table">
							<c:forEach items="${cartData.orderPrices}" var="entry" varStatus="loopCount">
								<tr>
									<td>${ycommerce:encodeHTML(entry.billingTime.name)}</td>
									<td class="prod-cart-total-total">
										<format:price priceData="${cartData.orderPrices[loopCount.count -1].totalPrice}" />
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>



				<a href="${cartUrl}" class="btn btn-primary btn-block mini-cart-checkout-button">
					<spring:theme code="checkout.checkout" text="Checkout" />
				</a>

				<a href="" class="btn btn-default btn-block js-mini-cart-close-button">
					<spring:theme code="cart.page.continue" text="Continue Shopping" />
				</a>
			</c:when>

			<c:otherwise>
				<c:if test="${empty numberItemsInCart or numberItemsInCart eq 0}">
					<div class="cart-modal-popup empty-popup-cart">
						<spring:theme code="popup.cart.empty" text="Your cart is empty " />
					</div>
				</c:if>
				<c:if test="${not empty lightboxBannerComponent && lightboxBannerComponent.visible}">
					<cms:component component="${lightboxBannerComponent}" evaluateRestriction="true" />
				</c:if>
				<button class="btn btn-block" disabled="disabled">
					<spring:theme code="checkout.checkout" text="Checkout" />
				</button>
				<a href="" class="btn btn-default btn-block js-mini-cart-close-button">
					<spring:theme text="Continue Shopping" code="cart.page.continue" />
				</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>


