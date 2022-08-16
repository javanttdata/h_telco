<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="multi-checkout-telco" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/checkout/multi/delivery-method/select" var="placeOrderUrl" htmlEscape="false"/>

<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">

<div class="row">
    <div class="col-sm-6">
        <telco-structure:checkoutHeadline/>
		<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
			<jsp:body>
					<div class="checkout-shipping">
						<multi-checkout-telco:shipmentItems cartData="${cartData}" showDeliveryAddress="true" />
						<div class="checkout-indent">
							<div class="headline">
								<spring:theme code="checkout.summary.deliveryMode.selectDeliveryMethodForOrder" text="Shipment Method"/>
							</div>
							
							<form id="selectDeliveryMethodForm" action="${placeOrderUrl}" method="get">
								<div class="form-group">
									<multi-checkout:deliveryMethodSelector deliveryMethods="${deliveryMethods}" selectedDeliveryMethodId="${cartData.deliveryMode.code}"/>
								</div>
							</form>
							<p><spring:theme code="checkout.multi.deliveryMethod.message" htmlEscape="false"/></p>
						</div>
					</div>
					<button id="deliveryMethodSubmit" type="button" class="btn btn-primary btn-block checkout-next"><spring:theme code="checkout.multi.deliveryMethod.continue" text="NEXT"/></button>
			</jsp:body>
		</multi-checkout:checkoutSteps>
    </div>

    <div class="col-sm-6 hidden-xs">
		<multi-checkout-telco:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="true" />
    </div>

    <div class="col-sm-12 col-lg-12">
        <cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
            <cms:component component="${feature}"/>
        </cms:pageSlot>
    </div>
</div>

</template:page>
