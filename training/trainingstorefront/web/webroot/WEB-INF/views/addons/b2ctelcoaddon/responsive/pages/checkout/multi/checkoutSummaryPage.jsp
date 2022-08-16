<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="multi-checkout-telco" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="/checkout/multi/summary/placeOrder" var="placeOrderUrl" htmlEscape="false"/>
<spring:url value="/checkout/multi/termsAndConditions" var="getTermsAndConditionsUrl" htmlEscape="false"/>
<c:set var = "colSm6cssClass" value ="col-sm-6"/>
 
<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">

<div class="row">
    <div class="${colSm6cssClass}">
		<telco-structure:checkoutHeadline/>
		<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
			<div class="checkout-review hidden-xs">
                <div class="checkout-order-summary">
                    <multi-checkout-telco:orderTotals cartData="${cartData}" showTaxEstimate="${showTaxEstimate}" showTax="${showTax}" subtotalsCssClasses="dark"/>
                </div>
            </div>
            <div class="place-order-form hidden-xs">
                <form:form action="${placeOrderUrl}" id="placeOrderForm1" modelAttribute="placeOrderForm">
                    <div class="checkbox">
                        <label> 
                        	<form:checkbox id="Terms1" path="termsCheck" />
                            <spring:theme code="checkout.summary.placeOrder.readTermsAndConditions" arguments="${getTermsAndConditionsUrl}" text="Terms and Conditions" htmlEscape="false"/>
                        </label>
                    </div>
                    <spring:theme code="checkout.summary.placeOrder" text="Place Order" var="placeOrderText"/>
                    <button type="submit" class="btn btn-block btn-primary btn-place-order" id="placeOrder" title="${placeOrderText}">${placeOrderText}</button>
                </form:form>
            </div>
		</multi-checkout:checkoutSteps>
    </div>

    <div class="${colSm6cssClass}">
		<multi-checkout-telco:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="true" showPaymentInfo="true" />
	</div>

    <div class="col-sm-12 col-lg-12">
     <div class="place-order-form visible-xs">
                    <form:form action="${placeOrderUrl}" id="placeOrderForm1" modelAttribute="placeOrderForm">
                        <div class="checkbox">
                            <label> 
                            	<form:checkbox id="Terms1" path="termsCheck" />
                                <spring:theme code="checkout.summary.placeOrder.readTermsAndConditions" arguments="${getTermsAndConditionsUrl}" text="Terms and Conditions" htmlEscape="false"/>
                            </label>
                        </div>
                        <spring:theme code="checkout.summary.placeOrder" text="Place Order" var="placeOrderText"/>
                        
                        <button type="submit" class="btn btn-block btn-primary btn-place-order" id="placeOrder" title="${placeOrderText}">
						   ${placeOrderText}
						</button>
                    </form:form>
     </div>
     <br class="hidden-lg">
     <cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
            <cms:component component="${feature}"/>
     </cms:pageSlot>
       
    </div>
</div>
</template:page>