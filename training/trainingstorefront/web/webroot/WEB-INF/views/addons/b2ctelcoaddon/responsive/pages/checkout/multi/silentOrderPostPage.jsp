<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement"%>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/responsive/address"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="telco-multi-checkout" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/checkout/multi"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/checkout/multi/payment-method/choose" var="saveCardDetails" htmlEscape="false" />
<spring:theme code="checkout.multi.paymentMethod.continue" text="Next" var="next" />
<spring:theme code="checkout.multi.paymentMethod.addPaymentDetails.useThesePaymentDetails" text="Use these payment details" var="useCardDetails" />
<spring:theme code="checkout.multi.paymentMethod.addPaymentDetails.useSavedCard" text="Use a saved card" var="savedCard" />

<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">
	<div class="row">
		<div class="col-sm-6">
			<telco-structure:checkoutHeadline />
			<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
				<jsp:body>
                <c:if test="${not empty paymentFormUrl}">
                    <div class="checkout-paymentmethod">
                        <div class="checkout-indent">
                            	<div class="headline">
									<spring:theme code="checkout.multi.paymentMethod" text="Payment Method" />
								</div>
							
								<form:form id="silentOrderPostForm" name="silentOrderPostForm" modelAttribute="sopPaymentDetailsForm" action="${paymentFormUrl}" method="POST">
									<input type="hidden" name="orderPage_receiptResponseURL" value="${silentOrderPageData.parameters['orderPage_receiptResponseURL']}" />
									<input type="hidden" name="orderPage_declineResponseURL" value="${silentOrderPageData.parameters['orderPage_declineResponseURL']}" />
									<input type="hidden" name="orderPage_cancelResponseURL" value="${silentOrderPageData.parameters['orderPage_cancelResponseURL']}" />
									<c:forEach items="${sopPaymentDetailsForm.signatureParams}" var="entry">
										<input type="hidden" id="${entry.key}" name="${entry.key}" value="${ycommerce:encodeHTML(entry.value)}" />
									</c:forEach>
									<c:forEach items="${sopPaymentDetailsForm.subscriptionSignatureParams}" var="entry">
										<input type="hidden" id="${entry.key}" name="${entry.key}" value="${ycommerce:encodeHTML(entry.value)}" />
									</c:forEach>
									<input type="hidden" value="${ycommerce:encodeHTML(silentOrderPageData.parameters['billTo_email'])}" name="billTo_email" id="billTo_email">
									
									<c:if test="${not empty paymentInfos}">
										<div class="form-group">
											<button type="submit" class="btn btn-block btn-default js-saved-payments" title="${savedCard}">${savedCard}</button>
										</div>
									</c:if>	
						
									<div class="form-group">
										<formElement:formSelectBox idKey="card_cardType" labelKey="payment.cardType" path="card_cardType" selectCSSClass="form-control" mandatory="true"
											skipBlank="false" skipBlankMessageKey="payment.cardType.pleaseSelect" items="${sopCardTypes}" tabindex="1" />
									</div>
									<telco-structure:formInputBoxWrapper idKey="card_nameOnCard" labelKey="payment.nameOnCard" path="card_nameOnCard" tabIndex="2" mandatory="false" />
									<telco-structure:formInputBoxWrapper idKey="card_accountNumber" labelKey="payment.cardNumber" path="card_accountNumber" mandatory="true" tabIndex="3"
										autocomplete="off" />
										 
									<fieldset id="startDate">
										<label for="" class="control-label">
												<spring:theme code="payment.startDate" text="Start date (Maestro/Solo/Switch only)" />
											</label>
										<div class="row">
											<telco-structure:formSelectBoxWrapper idKey="StartMonth" labelKey="payment.month" path="card_startMonth" mandatory="true"
												skipBlankMessageKey="payment.month" items="${months}" />
												
											<telco-structure:formSelectBoxWrapper idKey="StartYear" labelKey="payment.year" path="card_startYear" mandatory="true"
												skipBlankMessageKey="payment.year" items="${startYears}" tabIndex="7" />
										</div>
									</fieldset>

									<fieldset id="cardDate">
										<label class="control-label">
												<spring:theme code="payment.expiryDate" text="Expiry date*" />
										</label>
										<div class="row">
										<telco-structure:formSelectBoxWrapper idKey="ExpiryMonth" labelKey="payment.month" path="card_expirationMonth" mandatory="true"
												skipBlankMessageKey="payment.month" items="${months}" tabIndex="6" />
											
										<telco-structure:formSelectBoxWrapper idKey="ExpiryYear" labelKey="payment.year" path="card_expirationYear" mandatory="true"
												skipBlankMessageKey="payment.year" items="${expiryYears}" tabIndex="7" />
												
										</div>
									</fieldset>

									<div class="row">
										<div class="col-xs-6">
											<formElement:formInputBox idKey="card_cvNumber" labelKey="payment.cvn" path="card_cvNumber" inputCSS="form-control" mandatory="true" tabindex="8" />
										</div>
									</div>
									
									<div class="row">
										<div class="col-xs-6">
											<div id="issueNum">
												<formElement:formInputBox idKey="card_issueNumber" labelKey="payment.issueNumber" path="card_issueNumber" inputCSS="text" mandatory="false"
													tabindex="9" />
											</div>
										</div>
									</div>

									<hr />
                                  <div class="headline">
                                        <spring:theme code="checkout.multi.paymentMethod.addPaymentDetails.billingAddress" text="Billing Address" />
                                   </div>
                                    <c:if test="${cartData.deliveryItemsQuantity > 0}">

                                        <div id="useDeliveryAddressData" data-titlecode="${ycommerce:encodeHTML(deliveryAddress.titleCode)}"
											data-firstname="${ycommerce:encodeHTML(deliveryAddress.firstName)}" data-lastname="${ycommerce:encodeHTML(deliveryAddress.lastName)}"
											data-line1="${ycommerce:encodeHTML(deliveryAddress.line1)}" data-line2="${ycommerce:encodeHTML(deliveryAddress.line2)}"
											data-town="${ycommerce:encodeHTML(deliveryAddress.town)}" data-postalcode="${ycommerce:encodeHTML(deliveryAddress.postalCode)}"
											data-countryisocode="${ycommerce:encodeHTML(deliveryAddress.country.isocode)}"
											data-regionisocode="${ycommerce:encodeHTML(deliveryAddress.region.isocodeShort)}" data-address-id="${ycommerce:encodeHTML(deliveryAddress.id)}">
										
                                        <formElement:formCheckbox path="useDeliveryAddress" idKey="useDeliveryAddress"
												labelKey="checkout.multi.sop.useMyDeliveryAddress" tabindex="11" />
										</div>
                                    </c:if>
				  
                                    <input type="hidden" value="${ycommerce:encodeHTML(silentOrderPageData.parameters['billTo_email'])}" class="text"
										name="billTo_email" id="billTo_email">
                                    <address:billAddressFormSelector supportedCountries="${countries}" regions="${regions}" tabindex="12" />
				
									<p class="help-block">
											<spring:theme code="checkout.multi.paymentMethod.seeOrderSummaryForMoreInformation" text="See the Order Summary area for more information." />
										</p>							
								
									</form:form>
                         </div>
                    </div>
                    <button type="submit" class="btn btn-block btn-primary submit_silentOrderPostForm checkout-next" title="${next}">${next}</button>
                </c:if>
				<c:if test="${not empty paymentInfos}">
					<div id="savedpayments">
						<div id="savedpaymentstitle">
							<div class="headline">
								<span class="headline-text">
										<spring:theme code="checkout.multi.paymentMethod.addPaymentDetails.useSavedCard" text="Use a saved card" />
									</span>
							</div>
						</div>
						
						<div id="savedpaymentsbody">
							<c:forEach items="${paymentInfos}" var="paymentInfo" varStatus="status">
								<div class="saved-payment-entry">
									<form action="${saveCardDetails}" method="GET">
										<input type="hidden" name="selectedPaymentMethodId" value="${ycommerce:encodeHTML(paymentInfo.id)}" />
												<strong>${ycommerce:encodeHTML(paymentInfo.billingAddress.firstName)}&nbsp; ${ycommerce:encodeHTML(paymentInfo.billingAddress.lastName)}</strong>
												<br />
												${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}<br />
												${ycommerce:encodeHTML(paymentInfo.cardNumber)}<br />
												<spring:theme code="checkout.multi.paymentMethod.paymentDetails.expires"
												arguments="${ycommerce:encodeHTML(paymentInfo.expiryMonth)},${ycommerce:encodeHTML(paymentInfo.expiryYear)}" />
												<br />
												${ycommerce:encodeHTML(paymentInfo.billingAddress.line1)}<br />
												${ycommerce:encodeHTML(paymentInfo.billingAddress.town)}&nbsp; ${ycommerce:encodeHTML(paymentInfo.billingAddress.region.isocodeShort)}<br />
												${ycommerce:encodeHTML(paymentInfo.billingAddress.postalCode)}&nbsp; ${ycommerce:encodeHTML(paymentInfo.billingAddress.country.isocode)}<br />
										<button type="submit" class="btn btn-block btn-primary margin-top-20" title="${useCardDetails}">${useCardDetails}</button>
									</form>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:if>	

		   </jsp:body>
			</multi-checkout:checkoutSteps>
		</div>

		<div class="col-sm-6 hidden-xs">
			<telco-multi-checkout:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="true" />
		</div>

		<div class="col-sm-12 col-lg-12">
			<cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
				<cms:component component="${feature}" />
			</cms:pageSlot>
		</div>
	</div>

</template:page>
