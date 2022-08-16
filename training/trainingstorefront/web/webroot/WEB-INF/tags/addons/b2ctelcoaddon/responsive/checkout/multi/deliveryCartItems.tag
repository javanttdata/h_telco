<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="showDeliveryAddress" required="false" type="java.lang.Boolean"%>
<%@ attribute name="showPotentialPromotions" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="grid" tagdir="/WEB-INF/tags/responsive/grid"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/responsive/common"%>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:set var="hasDeliveryItems" value="${cartData.deliveryItemsQuantity > 0}" />
<c:set var="deliveryAddress" value="${cartData.deliveryAddress}" />

<c:if test="${not hasDeliveryItems}">
	<spring:theme code="checkout.pickup.no.delivery.required" text="No delivery required for this order" />
</c:if>

<ul class="checkout-order-summary-list">
	<c:if test="${hasDeliveryItems}">
		<li class="checkout-order-summary-list-heading">
			<c:choose>
				<c:when test="${showDeliveryAddress and not empty deliveryAddress}">
					<div class="title">
						<spring:theme code="checkout.pickup.items.to.be.shipped" text="Ship To:" />
					</div>
					<div class="address">
						${ycommerce:encodeHTML(deliveryAddress.title)}&nbsp; ${ycommerce:encodeHTML(deliveryAddress.firstName)}&nbsp;
						${ycommerce:encodeHTML(deliveryAddress.lastName)}
						<br>
						${ycommerce:encodeHTML(deliveryAddress.line1)},&nbsp;
						<c:if test="${not empty deliveryAddress.line2}">
						${ycommerce:encodeHTML(deliveryAddress.line2)},&nbsp;
						</c:if>
						${ycommerce:encodeHTML(deliveryAddress.town)},&nbsp;
						<c:if test="${not empty deliveryAddress.region.name}">
						${ycommerce:encodeHTML(deliveryAddress.region.name)},&nbsp;
						</c:if>
						${ycommerce:encodeHTML(deliveryAddress.postalCode)},&nbsp; ${ycommerce:encodeHTML(deliveryAddress.country.name)}
						<br />
						${ycommerce:encodeHTML(deliveryAddress.phone)}
					</div>
				</c:when>
				<c:otherwise>
					<spring:theme code="checkout.pickup.items.to.be.delivered" text="Items to be delivered" />
				</c:otherwise>
			</c:choose>
		</li>
	</c:if>

	<c:forEach items="${cartData.entries}" var="entry" varStatus="loop">
		<spring:url value="${entry.product.url}" var="productUrl" htmlEscape="false" />
		<li class="checkout-order-summary-list-items">
			<div class="thumb">
				<a href="${productUrl}">
					<product:productPrimaryImage product="${entry.product}" format="thumbnail" />
				</a>
			</div>

			<div class="price col-sm-6">
				<table>
							<tr>
								<spring:theme code="entry.payoncheckout" text="Pay On Checkout:" var="billingTimeText"/>
								<td>${billingTimeText}</td>
								<td class="actualPrice">
									<format:price priceData="${entry.totalPrice}" displayFreeForZero="false"/>
								</td>
							</tr>
				</table>
			</div>

			<div class="details">
				<div class="name" style="display:flow-root;">
					<a href="${productUrl}">${ycommerce:encodeHTML(entry.product.name)}</a>
				</div>
				<order-entry:variantDetails product="${entry.product}"/>
				<div class="qty">
					<span>
						<spring:theme code="basket.page.qty" text="Qty" />:
					</span>
					${entry.quantity}
				</div>
				<div>
					<c:forEach items="${entry.product.baseOptions}" var="option">
						<c:if test="${not empty option.selected and option.selected.url eq entry.product.url}">
							<c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
								<div>${ycommerce:encodeHTML(selectedOption.name)}:${ycommerce:encodeHTML(selectedOption.value)}</div>
							</c:forEach>
						</c:if>
					</c:forEach>

					<div class="promotion">
						<c:if
							test="${ycommerce:doesPotentialPromotionExistForOrderEntryOrOrderEntryGroup(cartData, entry) && showPotentialPromotions}">
							<c:set var="promotions" value="${cartData.potentialProductPromotions}" />
						</c:if>
						<c:if test="${ycommerce:doesAppliedPromotionExistForOrderEntryOrOrderEntryGroup(cartData, entry)}">
							<c:set var="promotions" value="${cartData.appliedProductPromotions}" />
						</c:if>
                        <c:forEach items="${promotions}" var="promotion">
                            <c:if test="${not empty promotion.consumedEntries}">
                                <c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
                                    <c:if test="${ycommerce:isConsumedByEntry(consumedEntry,entry)}">
                                        <span class="promotion">${ycommerce:sanitizeHTML(promotion.description)}</span>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
					</div>
					<common:configurationInfos entry="${entry}" />
				</div>
				<spring:url value="/checkout/multi/getReadOnlyProductVariantMatrix" var="targetUrl" htmlEscape="false" />
				<grid:gridWrapper entry="${entry}" index="${loop.index}" styleClass="display-none" targetUrl="${targetUrl}" />
			</div>
		</li>
	</c:forEach>
</ul>
