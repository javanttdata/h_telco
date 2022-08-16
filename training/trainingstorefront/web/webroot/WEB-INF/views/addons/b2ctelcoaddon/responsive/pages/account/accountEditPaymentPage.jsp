<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="address" tagdir="/WEB-INF/tags/responsive/address"%>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement"%>
<%@ taglib prefix="telco-structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:theme code="text.button.save" text="Save" var="save" />
<spring:url value="/my-account/my-payment-details" var="paymentDetailsUrl" htmlEscape="false" />

<c:set var="cardDataName" value="payment.cardType.pleaseSelect" />
<c:if test="${isEditMode}">
	<c:set var="cardDataName" value="${paymentInfo.cardTypeData.name}" />
</c:if>

<div class="back-link border">
	<div class="row">
		<div class="container-lg col-md-6">
			<button type="button" class="addressBackBtn" data-back-to-addresses="${paymentDetailsUrl}">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</button>
			<c:choose>
				<c:when test="${isEditMode }">
					<span class="label">
						<spring:theme code="text.account.payment.editPayment" text="Edit Payment" />
					</span>
				</c:when>
				<c:otherwise>
					<span class="label">
						<spring:theme code="text.account.payment.addPayment" text="Add Payment" />
					</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<c:if test="${not empty paymentFormUrl}">
	<div class="row">
		<div class="container-lg col-md-6">
			<div class="account-section-content">
				<div class="account-section-form">

					<form:form id="silentOrderPostForm" name="silentOrderPostForm" modelAttribute="sopPaymentDetailsForm" action="${paymentFormUrl}" method="POST">
						<div class="acc-payment-method">
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

							<div class="form-group">
								<formElement:formSelectBox idKey="card_cardType" labelKey="payment.cardType" path="card_cardType" selectCSSClass="form-control" mandatory="true"
									skipBlank="false" skipBlankMessageKey="${cardDataName}" items="${sopCardTypes}" itemValue="${paymentInfo.cardTypeData.name}" tabindex="1"
									disabled="${isEditMode}" />
							</div>
							<telco-structure:formInputBoxWrapper idKey="card_nameOnCard" labelKey="payment.nameOnCard" path="card_nameOnCard" tabIndex="2" mandatory="false"
								disabled="${isEditMode}" />
							<telco-structure:formInputBoxWrapper idKey="card_accountNumber" labelKey="payment.cardNumber" path="card_accountNumber" mandatory="true" tabIndex="3"
								autocomplete="off" disabled="${isEditMode}" />


							<fieldset id="startDate">
								<label for="" class="control-label">
									<spring:theme code="payment.startDate" text="Start date (Maestro/Solo/Switch only)" />
								</label>
								<div class="row">
									<telco-structure:formSelectBoxWrapper idKey="StartMonth" labelKey="payment.month" path="card_startMonth" mandatory="true"
										skipBlankMessageKey="payment.month" items="${months}" disabled="${isEditMode}" />

									<telco-structure:formSelectBoxWrapper idKey="StartYear" labelKey="payment.year" path="card_startYear" mandatory="true"
										skipBlankMessageKey="payment.year" items="${startYears}" tabIndex="7" disabled="${isEditMode}" />
								</div>
							</fieldset>


							<fieldset id="cardDate">
								<label class="control-label">
									<spring:theme code="payment.expiryDate" text="Expiry date*" />
								</label>
								<div class="row">
									<telco-structure:formSelectBoxWrapper idKey="ExpiryMonth" labelKey="payment.month" path="card_expirationMonth" mandatory="true"
										skipBlankMessageKey="payment.month" items="${months}" tabIndex="6" disabled="${isEditMode}" />

									<telco-structure:formSelectBoxWrapper idKey="ExpiryYear" labelKey="payment.year" path="card_expirationYear" mandatory="true"
										skipBlankMessageKey="payment.year" items="${expiryYears}" tabIndex="7" disabled="${isEditMode}" />

								</div>
							</fieldset>
							<div class="row">
								<div class="col-xs-6">
									<formElement:formInputBox idKey="card_cvNumber" labelKey="payment.cvn" path="card_cvNumber" inputCSS="form-control" mandatory="true" tabindex="8"
										disabled="${isEditMode}" />
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6">
									<div id="issueNum">
										<formElement:formInputBox idKey="card_issueNumber" labelKey="payment.issueNumber" path="card_issueNumber" inputCSS="text" mandatory="false"
											tabindex="9" disabled="${isEditMode}" />
									</div>
								</div>
							</div>
							<div class="headline">
								<spring:theme code="checkout.multi.paymentMethod.addPaymentDetails.billingAddress" text="Billing Address" />
							</div>

							<address:billAddressFormSelector supportedCountries="${countries}" regions="${regions}" tabindex="10" />
						</div>
						<c:if test="${isEditMode}">
							<form:hidden path="card_nameOnCard" id="card_nameOnCard" />
							<form:hidden path="card_accountNumber" id="card_accountNumber" />
							<form:hidden path="card_expirationMonth" id="ExpiryMonth" />
							<form:hidden path="card_expirationYear" id="ExpiryYear" />
						</c:if>

					</form:form>
				</div>
				<div class="account-actions">
					<div class="row">
						<div class="col-sm-6 col-sm-push-6 account-buttons">
							<button type="submit" class="btn btn-block btn-primary submit_silentOrderPostForm checkout-next"  title="${save}">
								${save}
							</button>
						</div>
						<div class="col-sm-6 col-sm-pull-6 account-buttons">
							<a class="btn btn-block btn-default" href="${paymentDetailsUrl}"">
								<spring:theme code="text.button.cancel" text="Cancel" />
							</a>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

</c:if>