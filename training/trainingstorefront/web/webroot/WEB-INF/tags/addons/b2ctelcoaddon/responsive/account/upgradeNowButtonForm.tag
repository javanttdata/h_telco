<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/my-account/subscription/upgrade" var="upgradeSubscription" htmlEscape="false"/>
<spring:theme code="text.account.subscription.upgradeSubscriptionNow" text="Upgrade Now" var="upgradeNow"/>

<form:form class="upgrade-subscription-form" action="${upgradeSubscription}" method="post">
	<button type="submit" class="btn btn-block btn btn-default btn-primary btn-block" id="upgradeNow" title="${upgradeNow}">
		${upgradeNow}
	</button>
	<input type="hidden" name="productCode" value="${ycommerce:encodeHTML(upgradeData.code)}" />
	<input type="hidden" name="subscriptionId" value="${ycommerce:encodeHTML(subscriptionData.id)}" />
	<input type="hidden" name="originalOrderCode" value="${ycommerce:encodeHTML(subscriptionData.orderNumber)}" />
	<input type="hidden" name="originalEntryNumber" value="${ycommerce:encodeHTML(subscriptionData.orderEntryNumber)}" />
</form:form>
