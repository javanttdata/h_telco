<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<div id="checkout-content-panel" class="checkout-indent">
	<div class="headline">
		<spring:theme code="checkout.pickup.pickup.in.store.title" text="Pickup in Store" />
	</div>
	<div class="description">
		<spring:theme code="checkout.pickup.confirm.and.continue" text="Simply confirm the information below and continue to the next step of checkout" />
	</div>
	<c:forEach items="${cartData.pickupOrderGroups}" var="groupData" varStatus="status">
		<div class="headline pickup-items-data">
			<spring:theme code="checkout.pickup.items.to.pickup" arguments="${groupData.quantity}" />
			<span class="right">${ycommerce:encodeHTML(groupData.deliveryPointOfService.formattedDistance)}</span>
		</div>
		<div class="row">
			<div class="col-lg-6 content-panel-left">
				<div class="label-order">
					<spring:theme code="text.account.order.consignment.store.title" />
				</div>
				<ul class="pickup-adress-list">
					<li class="strong">${ycommerce:encodeHTML(groupData.deliveryPointOfService.name)}</li>
					<li>${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.line1)}</li>
					<li>${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.line2)}</li>
					<li>${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.town)}</li>
					<li>${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.postalCode)}</li>
					<li>${ycommerce:encodeHTML(groupData.deliveryPointOfService.address.country.name)}</li>
				</ul>
			</div>
			<div class="col-lg-6 content-panel-right">
				<multi-checkout:pickupCartItems cartData="${cartData}" groupData="${groupData}" index="${status.index}" showHead="false" />
			</div>
		</div>
		<c:set var="openingSchedule" value="${groupData.deliveryPointOfService.openingHours}" />
		<c:if test="${not empty openingSchedule}">
			<div class="store-timings">
				<div class="label-order">
					<spring:theme code="storeDetails.table.opening" text="Opening Times" />
				</div>
				<c:forEach items="${openingSchedule.weekDayOpeningList}" var="weekDay">
					<span class="value-order-date">${ycommerce:encodeHTML(weekDay.weekDay)}</span>
					<c:choose>
						<c:when test="${weekDay.closed}">
							<spring:theme code="storeDetails.table.opening.closed" text="Closed" />
						</c:when>
						<c:otherwise>
                                ${ycommerce:encodeHTML(weekDay.openingTime.formattedHour)} - ${ycommerce:encodeHTML(weekDay.closingTime.formattedHour)},&nbsp;
                            </c:otherwise>
					</c:choose>
					<br />
				</c:forEach>
			</div>
		</c:if>
	</c:forEach>
</div>
