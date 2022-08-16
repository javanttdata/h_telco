<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="pickupConsolidationOptions" required="true"	type="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="false" />

<c:if test="${not empty pickupConsolidationOptions}">
	<spring:url value="${currentStepUrl}" var="consolidatePickupUrl" htmlEscape="false"/>
	<div class="checkout-indent">
		<form:form id="simplify-delivery-location-form" action="${consolidatePickupUrl}" method="POST">
			<div class="headline">
				<spring:theme code="checkout.pickup.items.available.at.one.location" text="Your pickup items are available at one location" />
			</div>
			<div class="description margin-bottom-20">
				<spring:theme code="checkout.pickup.items.at.one.location" text="All items in your order selected for pickup are currently available at these store locations:" />
			</div>
			<div>
				<c:forEach items="${pickupConsolidationOptions}" var="option" varStatus="status">
					<div class="select-delivery-location-item">
						<label class="select-delivery-location-item-label" for="select-delivery-location-item-id${status.count}"> 
							<input id="select-delivery-location-item-id${status.count}"	class="select-delivery-location-item-option" type="radio" name="posName" value="${option.name}"
							<c:if test="${status.first}">checked="checked"</c:if> />
							<span class="pickup-adress-list">
							<c:if test="${not empty userLocation}">
								<span class="pickup-adress-item">${option.formattedDistance}</span>
								</c:if> <span class="pickup-adress-item strong">${ycommerce:encodeHTML(option.name)}</span>
								<span class="pickup-adress-item">${ycommerce:encodeHTML(option.address.line1)}</span>
								<span class="pickup-adress-item">${ycommerce:encodeHTML(option.address.line2)}</span>
								<span class="pickup-adress-item">${ycommerce:encodeHTML(option.address.town)}</span>
								<span class="pickup-adress-item">${ycommerce:encodeHTML(option.address.postalCode)}</span>
								<span class="pickup-adress-item">${ycommerce:encodeHTML(option.address.country.name)}</span>
							</span>
						</label>
					</div>
				</c:forEach>
			</div>
			<div>
				<div class="margin-bottom-20">
					<spring:theme code="checkout.pickup.items.simplify.pickup.location"	text="I would like to change my order to pickup all my items in the same store" />
				</div>
				
				<button type="submit" class="btn btn-block btn-primary selectDeliverylocationItemButton" id="chooseDeliveryLocation_simplify_button" title="Simplify Pickup Location">
					<spring:theme code="checkout.pickup.simplifyPickup" text="Simplify Pickup Location" />
				</button>
			</div>
		</form:form>
	</div>
</c:if>