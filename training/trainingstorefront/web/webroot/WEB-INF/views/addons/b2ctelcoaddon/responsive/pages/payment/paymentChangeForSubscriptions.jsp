<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%--@elvariable id="paymentInfo" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData"--%>
<%--@elvariable id="subscriptions" type="java.util.List<de.hybris.platform.subscriptionfacades.data.SubscriptionData>"--%>
<%--@elvariable id="paymentMethods" type="java.util.List"--%>
<%--@elvariable id="subscriptionsPerPaymentMethod" type="java.util.HashMap<java.lang.String,java.lang.Integer>"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:if test="${not empty paymentInfo}">
	<c:set var="noBorder" value="no-border"/>
</c:if>
<c:set var="hasSubscriptions" value="${not empty subscriptions}"/>
<c:set var="billingAddress" value="${paymentInfo.billingAddress}"/>
<spring:url var="addPaymentUrl" value="/my-account/my-payment-details/add" htmlEscape="false"/>
<spring:url var="backToPaymentInfoUrl" value="/my-account/my-payment-details" htmlEscape="false"/>

<div class="account-section-header ${noBorder}">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<div class="back-link payment-title">
				<a href="${backToPaymentInfoUrl}"><span class="glyphicon glyphicon-chevron-left"></span></a>
				<span class="label">
					<spring:theme code="text.account.paymentDetails.manageSubscriptions" text="Manage Subscriptions"/>
				</span>
			</div>
		</div>
		<div class="account-section-header-add col-xs-12 col-sm-6">
			<a href="${addPaymentUrl}">
				<spring:theme code="text.account.paymentDetails.addNewPaymentDetails" text="Add Payment"/>
			</a>
		</div>
	</div>
</div>

<div class="description">
	<div class="row">
		<div class="col-xs-12">
			<spring:theme code="text.account.paymentDetails.manageAssociatedSubscriptions"
							  text="Associate your subscriptions to the payment details below"/>
		</div>
	</div>
</div>
<br>

<div class="item_container_holder paymentDetails manage-subscriptions">
	<div class="account-paymentdetails account-list">
		<div class="account-cards card-select">
			<div class="row">
				<account:removePaymentMethodPopup paymentInfo="${paymentInfo}" subscriptions="${subscriptions}"
															 subscriptionsPerPaymentMethod="${subscriptionsPerPaymentMethod}"/>
				<account:subscriptionPaymentDetails paymentInfo="${paymentInfo}" hasSubscriptions="${hasSubscriptions}"/>
				<account:billingAddressDetails billingAddress="${billingAddress}"/>
			</div>
		</div>
	</div>

	<br>
	<c:choose>
		<c:when test="${hasSubscriptions}">
			<subscription:manageSubscriptionDetails paymentInfo="${paymentInfo}" subscriptions="${subscriptions}"
																 paymentMethods="${paymentMethods}"/>
		</c:when>
		<c:otherwise>
			<div class="description">
				<spring:theme code="text.account.paymentDetails.noAssociatedSubscriptions"
								  text="There are currently no subscriptions associated to this payment method."/>
			</div>
		</c:otherwise>
	</c:choose>
</div>
