<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="orderData" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData"%>
<%@ attribute name="consignment" required="true" type="de.hybris.platform.commercefacades.order.data.ConsignmentData"%>
<%@ attribute name="inProgress" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/responsive/order"%>
<%@ taglib prefix="telco-order" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/order"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<div class="well well-quinary well-xs">
	<div class="well-headline">
		<spring:theme code="text.account.order.consignment.status.${consignment.statusDisplay}" />

		<span class="well-headline-sub"> <fmt:formatDate value="${consignment.statusDate}" dateStyle="medium" timeStyle="short"
				type="both" />
		</span>
	</div>

	<div class="well-content col-sm-12 col-md-9">
		<div class="row">
			<div class="col-sm-12 col-md-9">
				<c:choose>
					<c:when test="${consignment.deliveryPointOfService ne null}">
						<order:storeAddressItem deliveryPointOfService="${consignment.deliveryPointOfService}" inProgress="${inProgress}"
							statusDate="${consignment.statusDate}" />
					</c:when>
					<c:otherwise>
						<div class="row">
							<div class="col-sm-6 col-md-4">
								<div class="order-ship-to">
									<div class="label-order">
										<spring:theme code="text.account.order.shipto" text="Ship To" />
									</div>
									<div class="value-order">
										<order:addressItem address="${orderData.deliveryAddress}" />
									</div>
								</div>
							</div>

							<div class="col-sm-6 col-md-4">
								<div class="order-shipping-method">
									<order:deliveryMethodItem order="${orderData}" />
								</div>
							</div>
						</div>

						<c:if test="${not inProgress}">
							<c:choose>
								<c:when test="${consignment.status.code eq 'SHIPPED' and not empty consignment.trackingID}">
									<div class="col-sm-4">
										<div class="order-tracking-no">
											<span class="label-order"><spring:theme code="text.account.order.tracking" text="Tracking No." /></span>
											<br>
											<span class="order-track-number">${ycommerce:encodeHTML(consignment.trackingID)}</span>
										</div>
									</div>
								</c:when>
							</c:choose>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<ul class="item__list">
	<li class="hidden-xs hidden-sm">
		<ul class="item__list--header">
			<li class="item__image"></li>
			<li class="item__info"><spring:theme code="basket.page.item" text="Item (style number)" /></li>
			<li class="item__quantity"><spring:theme code="basket.page.qty" text="Qty" /></li>
			<li class="item__delivery"><spring:theme code="basket.page.delivery" text="Delivery" /></li>
			<li class="item__price"><spring:theme code="basket.page.price" text="Price"/></li>
		</ul>
	</li>
	<c:forEach items="${consignment.entries}" var="entry">

		<telco-order:orderEntryDetails orderEntry="${entry.orderEntry}" consignmentEntry="${entry}" order="${orderData}" />
		<c:if test="${not empty entry.orderEntry.entries}">
			<c:forEach items="${entry.orderEntry.entries}" var="childEntry">

				${entry.orderEntry.product.code}'s child entry:

				<telco-order:orderEntryDetails orderEntry="${childEntry}" consignmentEntry="${entry}" order="${orderData}" />
			</c:forEach>

		</c:if>
	</c:forEach>
</ul>
