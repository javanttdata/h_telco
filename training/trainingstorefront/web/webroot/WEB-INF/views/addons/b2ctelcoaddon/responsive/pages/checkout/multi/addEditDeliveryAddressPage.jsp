<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/responsive/address"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="multi-checkout-telco" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">

	<div class="row">
		<div class="col-sm-6">
			<telco-structure:checkoutHeadline/>
			<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
				<jsp:body>
                    <div class="checkout-shipping">
                        <multi-checkout-telco:shipmentItems cartData="${cartData}" showDeliveryAddress="false" />

                        <div class="checkout-indent">
                            <div class="headline">
									<spring:theme code="checkout.summary.shippingAddress" text="Shipping Address" />
								</div>

                            <address:addressFormSelector supportedCountries="${countries}" regions="${regions}" cancelUrl="${currentStepUrl}"
									country="${country}" />

                            <div id="addressbook">
                                <c:forEach items="${deliveryAddresses}" var="deliveryAddress" varStatus="status">
                                    <div class="addressEntry">
                                        <form action="${request.contextPath}/checkout/multi/delivery-address/select" method="GET">
                                            <input type="hidden" name="selectedAddressCode" value="${ycommerce:encodeHTML(deliveryAddress.id)}" />
                                            <ul>
                                                <li>
                                                    <strong>
                                                        ${ycommerce:encodeHTML(deliveryAddress.title)}&nbsp;
                                                        ${ycommerce:encodeHTML(deliveryAddress.firstName)}&nbsp;
                                                        ${ycommerce:encodeHTML(deliveryAddress.lastName)}
                                                   </strong>
                                                   <br />
                                                   ${ycommerce:encodeHTML(deliveryAddress.line1)}&nbsp;
                                                   ${ycommerce:encodeHTML(deliveryAddress.line2)}
                                                   <br />
                                                   ${ycommerce:encodeHTML(deliveryAddress.town)}
                                                   <c:if test="${not empty deliveryAddress.region.name}">
                                                       &nbsp;${ycommerce:encodeHTML(deliveryAddress.region.name)}
                                                   </c:if>
                                                   <br />
                                                   ${ycommerce:encodeHTML(deliveryAddress.country.name)}&nbsp;
                                                   ${ycommerce:encodeHTML(deliveryAddress.postalCode)}
                                                </li>
                                            </ul>
                                            <button type="submit" class="btn btn-primary btn-block">
                                                <spring:theme code="checkout.multi.deliveryAddress.useThisAddress" text="Use This Delivery Address" />
                                            </button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </div>

                            <address:suggestedAddresses selectedAddressUrl="/checkout/multi/delivery-address/select" />
                        </div>

                     <multi-checkout:pickupGroups cartData="${cartData}" />
                    </div>

                    <button id="addressSubmit" type="button" class="btn btn-primary btn-block checkout-next">
                        <spring:theme code="checkout.multi.deliveryAddress.continue" text="Next" />
                    </button>
            	</jsp:body>
			</multi-checkout:checkoutSteps>
		</div>

		<div class="col-sm-6 hidden-xs">
			<multi-checkout-telco:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="false" />
		</div>

		<div class="col-sm-12 col-lg-12">
			<cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
				<cms:component component="${feature}" />
			</cms:pageSlot>
		</div>
	</div>

</template:page>
