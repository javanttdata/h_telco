<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="multi-checkout-telco" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="${nextStepUrl}" var="nextStep" htmlEscape="false" />
<template:page pageTitle="${pageTitle}">
	<div class="row choose-pickup-store">
		<div class="col-sm-6">
			<telco-structure:checkoutHeadline />
			<multi-checkout-telco:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
				<jsp:body>
					<div class="checkout-shipping">
						<multi-checkout:pickupConsolidationOptions cartData="${cartData}" pickupConsolidationOptions="${pickupConsolidationOptions}" />
						<multi-checkout:pickupGroups cartData="${cartData}" />
						<form:form id="select-delivery-location-form" action="${nextStep}" method="get">
							<button id="chooseDeliveryLocation_continue_button" class="btn btn-primary btn-block checkout-next">
               					 <spring:theme code="checkout.multi.deliveryMethod.continue" text="Next" />
							</button>
						</form:form>
					</div>
				</jsp:body>
			</multi-checkout-telco:checkoutSteps>
		</div>
		<div class="col-sm-6 hidden-xs">
			<multi-checkout:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="true" />
		</div>
		<div class="col-sm-12 col-lg-12">
			<cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
				<cms:component component="${feature}" />
			</cms:pageSlot>
		</div>
	</div>
</template:page>
