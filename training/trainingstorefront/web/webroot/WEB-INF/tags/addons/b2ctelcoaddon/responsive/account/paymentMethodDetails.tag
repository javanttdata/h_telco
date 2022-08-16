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
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="paymentInfoId" value="${paymentInfo.id}"/>
<c:set var="isDefaultPayment" value="${paymentInfo.defaultPaymentInfo}"/>
<c:set var="billingAddress" value="${paymentInfo.billingAddress}"/>

<div class="col-xs-12 col-sm-6 col-md-4 card">
	<ul class="pull-left">
		<li>
			<c:if test="${isDefaultPayment}">
			<strong>
				</c:if>
				${ycommerce:encodeHTML(paymentInfo.accountHolderName)}
				<c:if test="${isDefaultPayment}">
				&nbsp;
				(<spring:theme code="text.default" text="default"/>)
			</strong>
			</c:if>
		</li>
		<li>${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}</li>
		<li>${ycommerce:encodeHTML(paymentInfo.cardNumber)}</li>
		<li>
			<fmt:formatNumber var="expiryMonth" minIntegerDigits="2" value="${paymentInfo.expiryMonth}"/>
			${ycommerce:encodeHTML(expiryMonth)}&nbsp;/&nbsp;${ycommerce:encodeHTML(paymentInfo.expiryYear)}
		</li>
		<c:if test="${not empty billingAddress}">
			<li>${ycommerce:encodeHTML(billingAddress.line1)}</li>
			<li>
					${ycommerce:encodeHTML(billingAddress.town)}&nbsp;
					${ycommerce:encodeHTML(billingAddress.region.isocodeShort)}
			</li>
			<li>
					${ycommerce:encodeHTML(billingAddress.country.name)}&nbsp;
					${ycommerce:encodeHTML(billingAddress.postalCode)}
			</li>
		</c:if>
	</ul>
	<div class="account-cards-actions pull-left">
		<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] gt '0'}">
			<spring:url var="editSubscriptionsUrl"
							value="/my-account/my-payment-details/payment-method-subscriptions?paymentInfoId={/paymentInfoId}"
							htmlEscape="false">
				<spring:param name="paymentInfoId" value="${paymentInfoId}"/>
			</spring:url>
			<a href="#" id="edit-with-subscriptions-account" class="action-links" data-url="${editSubscriptionsUrl}">
				<span class="glyphicon glyphicon-pencil"></span>
			</a>
		</c:if>
		<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] eq '0'}">
			<spring:url var="editPaymentUrl"
							value="my-payment-details/edit"
							htmlEscape="false">
			</spring:url>
			<form:form id="formEditpaymentInfo${paymentInfoId}" action="${editPaymentUrl}" method="POST">
				<input type="hidden" name="paymentInfoId" id="paymentInfoId" value="${paymentInfoId}"/>
                   <a href="#" id="${paymentInfoId}" class="action-links edit-payment">
							<span class="glyphicon glyphicon-pencil"></span>
                   </a>
			</form:form>
		</c:if>

		<spring:theme var="removePaymentPopupTitle" code="text.account.paymentDetails.delete.popup.title"
						  text="Delete Payment"/>
		<a href="#" class="action-links removePaymentDetailsButton" data-popup-title="${removePaymentPopupTitle}"
			data-payment-id="${ycommerce:encodeHTML(paymentInfoId)}">
			<span class="glyphicon glyphicon-remove"></span>
		</a>
	</div>
	<c:if test="${not isDefaultPayment}">
		<spring:url value="/my-account/my-payment-details/set-default" var="setDefaultPaymentActionUrl"
						htmlEscape="false"/>
		<form:form id="setDefaultPaymentDetails${ycommerce:encodeHTML(paymentInfoId)}"
					  action="${setDefaultPaymentActionUrl}" method="post">
			<input type="hidden" name="paymentInfoId" value="${ycommerce:encodeHTML(paymentInfoId)}"/>
			<button type="submit" class="account-set-default-address">
				<spring:theme code="text.setDefault" text="Set Default"/>
			</button>
		</form:form>
	</c:if>

	<c:if test="${subscriptionsPerPaymentMethod[paymentInfoId] gt '0'}">
		<spring:url var="manageSubscriptionsUrl"
						value="/my-account/my-payment-details/manage?paymentInfoId={paymentInfoId}"
						htmlEscape="false">
			<spring:param name="paymentInfoId" value="${paymentInfoId}"/>
		</spring:url>
		<a href="${manageSubscriptionsUrl}" class="manage-subscriptions">
			<spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Subscriptions"/>
		</a>
	</c:if>
</div>
<account:removePaymentMethodPopup paymentInfo="${paymentInfo}" subscriptions="${subscriptions}"
											 subscriptionsPerPaymentMethod="${subscriptionsPerPaymentMethod}"/>
