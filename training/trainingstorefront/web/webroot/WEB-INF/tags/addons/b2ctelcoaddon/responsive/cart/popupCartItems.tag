<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="entry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ attribute name="quantity" required="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="${product.url}" var="entryProductUrl" htmlEscape="false"/>
<c:set var="deliveryPointName" value="${ycommerce:encodeHTML(entry.deliveryPointOfService.name)}"/>

<div class="add-to-cart-item">
	<div class="thumb">
		<a href="${entryProductUrl}"> <product:productPrimaryImage product="${entry.product}" format="cartIcon"/></a>
	</div>
	<div class="details">
		<a class="name" href="${entryProductUrl}">${ycommerce:encodeHTML(product.name)}</a>
		<div class="qty">
			<span>
				<spring:theme code="popup.cart.quantity.added" text="Quantity Added:"/>
			</span>&nbsp;
			${quantity}
		</div>

		<order-entry:variantDetails product="${product}"/>

		<c:if test="${not empty deliveryPointName}">
			<div class="itemPickup">
				<span class="itemPickupLabel">
					<spring:theme code="popup.cart.pickup" text="Pick Up"/>
				</span>&nbsp;${deliveryPointName}
			</div>
		</c:if>
			<div class="add-to-cart-totals">
				<table class="prod_cart-total-table">
						<spring:theme code="product.payNow" text="Pay Now" var="billingTimeText"/>
						<c:choose>
							<c:when test="${entry.product.itemType eq 'Product'}">
								<tr>
									<c:if test="${not empty entry.basePrice.value}">
										<td class="prod_price_info">${billingTimeText}</td>
										<td class="prod_cart-total-total">
											${fn:substring(fn:escapeXml(entry.basePrice.formattedValue), 0, 1)}
											<fmt:formatNumber type="number" minFractionDigits="2" value="${entry.basePrice.value * quantity}"/>
										</td>
									</c:if>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<c:if test="${not empty entry.totalPrice.value and entry.totalPrice.value ne '0.0'}">
										<td class="prod_price_info">${billingTimeText}</td>
										<td class="prod_cart-total-total">
											<format:price priceData="${entry.totalPrice}"/>
										</td>
									</c:if>
								</tr>
							</c:otherwise>
						</c:choose>
				</table>
			</div>
	</div>
</div>
