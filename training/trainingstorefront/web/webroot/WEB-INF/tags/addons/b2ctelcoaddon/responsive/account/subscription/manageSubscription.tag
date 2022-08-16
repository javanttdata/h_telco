<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscription" required="true" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData" %>
<%@ attribute name="extensionOptions" required="true" type="java.util.Map" %>
<%@ attribute name="paymentInfos" required="true"
				  type="java.util.List<de.hybris.platform.commercefacades.order.data.CCPaymentInfoData>" %>
<%@ attribute name="isNotCancelledSubscription" required="true" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>
<%@ taglib prefix="action" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription/action" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="subscriptionStatus" value="${fn:toUpperCase(subscription.subscriptionStatus)}"/>
<c:set var="subscriptionId" value="${ycommerce:encodeHTML(subscription.id)}"/>
<c:set var="renewalType" value="${ycommerce:encodeHTML(subscription.renewalType)}"/>

<spring:url var="changeSubscriptionStateUrl" value="/my-account/subscription/change-state" htmlEscape="false"/>
<spring:url var="setAutorenewStatusUrl" value="/my-account/subscription/set-autorenewal-status" htmlEscape="false"/>
<spring:url var="replaceSubscriptionPaymentMethodUrl" value="/my-account/subscription/billing-activity/payment-method/replace"
				htmlEscape="false"/>
<spring:url var="extendSubscriptionTermDuration" value="/my-account/subscription/extend-term-duration" htmlEscape="false"/>
<spring:theme var="updateText" code="text.account.subscription.updateTermDuration" text="Update"/>

<h3 class="subsciptions-section-title">
	<spring:theme code="text.account.subscription.manageSubscription" text="Manage this subscription"/>
</h3>

<table class="subscriptions-table">
	<tr>
		<td><spring:theme code="text.account.subscription.status" text="Status:"/></td>
		<td>${ycommerce:encodeHTML(subscriptionStatus)}</td>
	</tr>
	<c:if test="${isNotCancelledSubscription}">
		<tr>
			<td><spring:theme code="text.account.subscription.renewalType" text="Renewal Type:"/></td>
			<td>${renewalType}</td>
		</tr>
		<tr>
			<td><spring:theme code="text.account.subscription.endDate" text="End Date:"/></td>
			<td><fmt:formatDate value="${subscription.endDate}" dateStyle="long" timeStyle="short" type="both"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<action:extendSubscriptionForm subscriptionId="${subscriptionId}" extensionOptions="${extensionOptions}"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<action:updatePaymentMethodForm paymentInfos="${paymentInfos}" subscription="${subscription}"/>
			</td>
		</tr>
	</c:if>
</table>
<c:if test="${isNotCancelledSubscription}">
	<div class="button-container">
		<div class="row">
			<spring:theme var="resumeSubscriptionButtonText" code="text.account.subscription.resumeSubscription"
							  text="Resume Subscription"/>
			<spring:theme var="pauseSubscriptionButtonText" code="text.account.subscription.pauseSubscription" text="Pause"/>
			<c:set var="isPausedSubscription" value="${subscriptionStatus eq 'PAUSED'}"/>
			<c:set var="newState" value="${isPausedSubscription? 'ACTIVE' : 'PAUSED'}"/>
			<c:set var="changeSubscriptionStateButtonText"
					 value="${isPausedSubscription? resumeSubscriptionButtonText : pauseSubscriptionButtonText}"/>

			<div class="col-sm-4 col-md-12">
				<action:changeSubscriptionStateForm subscriptionId="${subscriptionId}" newState="${newState}"
																buttonText="${changeSubscriptionStateButtonText}"/>
			</div>

			<c:if test="${subscription.cancellable}">
				<div class="col-sm-4 col-md-12">
					<spring:theme var="cancelSubscriptionText" code="text.account.subscription.cancelSubscription" text="Cancel"/>
					<spring:theme var="confirmCancellationText" code="text.account.subscription.confirm.cancellation"
									  text="Confirm Cancellation"/>
					<button type="button" class="btn btn-default btn-block js-cancel-subscription"
							  data-help="${confirmCancellationText}" title="${cancelSubscriptionText}">
							${cancelSubscriptionText}
					</button>
				</div>
			</c:if>

			<c:choose>
				<c:when test="${renewalType}">
					<spring:theme var="changeSubscriptionAutoRenewalButtonText" code="text.account.subscription.deactivateAutorenew"
									  text="Deactivate Auto-Renew"/>
					<c:set var="autoRenew" value="${false}"/>
				</c:when>
				<c:otherwise>
					<spring:theme var="changeSubscriptionAutoRenewalButtonText" code="text.account.subscription.activateAutorenew"
									  text="Activate Auto-Renew"/>
					<c:set var="autoRenew" value="${true}"/>
				</c:otherwise>
			</c:choose>

			<div class="col-sm-4 col-md-12">
				<action:changeSubscriptionAutoRenewalForm subscriptionId="${subscriptionId}" autoRenew="${autoRenew}"
																		buttonText="${changeSubscriptionAutoRenewalButtonText}"/>
			</div>
		</div>
	</div>
</c:if>

<subscription:manageCancellableSubscription subscription="${subscription}"/>
