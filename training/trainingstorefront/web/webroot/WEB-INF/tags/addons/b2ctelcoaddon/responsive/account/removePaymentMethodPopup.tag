<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptions" required="true"
				  type="java.util.List<de.hybris.platform.subscriptionfacades.data.SubscriptionData>" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ attribute name="subscriptionsPerPaymentMethod" required="true" type="java.util.HashMap<java.lang.String,java.lang.Integer>" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>


<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="paymentInfoId" value="${paymentInfo.id}"/>
<c:set var="encodedPaymentInfoId" value="${ycommerce:encodeHTML(paymentInfoId)}"/>

<spring:url var="manageSubscriptionsUrl" value="/my-account/my-payment-details/manage?paymentInfoId={/paymentInfoId}"
				htmlEscape="false">
	<spring:param name="paymentInfoId" value="${paymentInfoId}"/>
</spring:url>
<spring:url var="removePaymentActionUrl" value="/my-account/my-payment-details/remove?paymentInfoId={/paymentInfoId}"
				htmlEscape="false">
	<spring:param name="paymentInfoId" value="${paymentInfoId}"/>
</spring:url>

<div class="display-none">
	<div id="popup_confirm_payment_removal_${encodedPaymentInfoId}" class="account-payment-removal-popup">
		<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] eq '0'  or empty subscriptionsPerPaymentMethod[paymentInfoId]}">
			<spring:theme code="text.account.paymentDetails.delete.following" text="The following payment method will be deleted"/>
		</c:if>
		<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] gt '0' }">
			<spring:theme code="text.account.paymentDetails.warningExistingSubscription.remove"
							  text="The subscriptions associated with the card needs to be managed before deleting the payment details"/>
		</c:if>

		<div class="address">
			<strong>${ycommerce:encodeHTML(paymentInfo.accountHolderName)}</strong>
			<br>${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}<br>${ycommerce:encodeHTML(paymentInfo.cardNumber)}<br>
			<fmt:formatNumber minIntegerDigits="2" value="${paymentInfo.expiryMonth}" var="expiryMonth"/>
			${ycommerce:encodeHTML(expiryMonth)}&nbsp;/&nbsp;${ycommerce:encodeHTML(paymentInfo.expiryYear)}

			<c:if test="${not empty paymentInfo.billingAddress}">
				<br>${ycommerce:encodeHTML(paymentInfo.billingAddress.line1)}
				<br>${ycommerce:encodeHTML(paymentInfo.billingAddress.town)}
				&nbsp;${ycommerce:encodeHTML(paymentInfo.billingAddress.region.isocodeShort)}
				<br>${ycommerce:encodeHTML(paymentInfo.billingAddress.country.name)}
				&nbsp;${ycommerce:encodeHTML(paymentInfo.billingAddress.postalCode)}
			</c:if>
		</div>

		<form:form id="removePaymentDetails${encodedPaymentInfoId}" action="${removePaymentActionUrl}" method="get">
			<input type="hidden" name="paymentInfoId" value="${encodedPaymentInfoId}"/>
			<br>
			<div class="modal-actions">
				<div class="row">
					<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] eq '0' or empty subscriptionsPerPaymentMethod[paymentInfoId] }">
						<div class="col-xs-12 col-sm-6 col-sm-push-6">
							<spring:theme code="text.account.paymentDetails.delete" text="Delete" var="deleteText"/>
							<button type="submit" class="btn btn-block btn-default btn-primary paymentsDeleteBtn" title="${deleteText}">
								${deleteText}
							</button>
						</div>
					</c:if>
					<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] gt '0' }">
						<div class="col-xs-12 col-sm-6 col-sm-push-6">
							<a href="${manageSubscriptionsUrl}" class="btn btn-default btn-primary btn-block paymentsDeleteBtn">
								<spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Subscriptions"/>
							</a>
						</div>
					</c:if>
					<div class="col-xs-12 col-sm-6 col-sm-pull-6">
						<a class="btn btn-default btn-block closeColorBox paymentsDeleteBtn" data-payment-id="${encodedPaymentInfoId}">
							<spring:theme code="text.button.cancel" text="Cancel"/>
						</a>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
