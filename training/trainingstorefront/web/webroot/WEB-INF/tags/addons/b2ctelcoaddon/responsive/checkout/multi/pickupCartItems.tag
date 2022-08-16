<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="groupData" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryGroupData"%>
<%@ attribute name="showPotentialPromotions" required="false" type="java.lang.Boolean"%>
<%@ attribute name="showHead" required="false" type="java.lang.Boolean"%>
<%@ attribute name="index" required="true" type="java.lang.Integer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<table class="pickup-cart-items">
	<c:if test="${showHead}">
		<thead>
			<tr>
				<td colspan="4">
					<spring:theme code="text.checkout.pickup.in.store" text="Pickup in Store" />
				</td>
			</tr>
		</thead>
	</c:if>
	<tbody>
		<c:if test="${showHead}">
			<tr class="address">
				<td colspan="4">
					<div class="storeName">${ycommerce:encodeHTML(groupData.deliveryPointOfService.name)}</div>
					${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.formattedAddress)}
				</td>
			</tr>
		</c:if>
		<c:forEach items="${groupData.entries}" var="entry">
			<spring:url value="${entry.product.url}" var="productUrl"  htmlEscape="false"/>
			<tr>
				<td rowspan="2" class="thumb">
					<a href="${productUrl}">
						<product:productPrimaryImage product="${entry.product}" format="thumbnail" />
					</a>
				</td>
				<td colspan="3" class="desc">
					<div class="name">
						<a href="${productUrl}">${ycommerce:encodeHTML(entry.product.name)}</a>
					</div>
					<c:forEach items="${entry.product.baseOptions}" var="option">
						<c:if test="${option.selected.url eq productUrl}">
							<c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
								<dl>
									<dt>${ycommerce:encodeHTML(selectedOption.name)}:</dt>
									<dd>${ycommerce:encodeHTML(selectedOption.value)}</dd>
								</dl>
							</c:forEach>
						</c:if>
					</c:forEach>
					<c:if
						test="${ycommerce:doesPotentialPromotionExistForOrderEntryOrOrderEntryGroup(cartData, entry) && showPotentialPromotions}">
						<c:set var="promotions" value="${cartData.potentialProductPromotions}" />
					</c:if>
					<c:if test="${ycommerce:doesAppliedPromotionExistForOrderEntryOrOrderEntryGroup(cartData, entry)}">
						<c:set var="promotions" value="${cartData.appliedProductPromotions}" />
					</c:if>
					<c:set var="displayed" value="false" />
					<c:if test="${not empty promotions.consumedEntries}">
						<c:forEach items="${promotions.consumedEntries}" var="consumedEntry">
							<c:if test="${not displayed && ycommerce:isConsumedByEntry(consumedEntry,entry)}">
								<c:set var="displayed" value="true" />
								<span class="promotion">${ycommerce:sanitizeHTML(promotions.description)}</span>
							</c:if>
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="price-row">
					<format:price priceData="${entry.basePrice}" displayFreeForZero="true" />
				</td>
				<td class="price-row">
					<spring:theme code="basket.page.qty" text="Qty"/>${entry.quantity}</td>
				<td class="price-row">
					<format:price priceData="${entry.totalPrice}" displayFreeForZero="true" />
				</td>
			</tr>
		</c:forEach>

	</tbody>
</table>


