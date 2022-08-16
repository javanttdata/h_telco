<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscription" required="true" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/structure" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url var="subscriptionBillingActivityUrl" value="/my-account/subscription/billing-activity" htmlEscape="false"/>

<h3 class="subsciptions-section-title"><spring:theme code="text.account.subscription.activity" text="Activity"/></h3>
<table class="subscriptions-table">
	<c:if test="${fn:toUpperCase(subscription.subscriptionStatus) eq 'CANCELLED'}">
		<tr>
			<td><spring:theme code="text.account.subscription.cancelledDate" text="Cancelled Date"/>:</td>
			<td><fmt:formatDate value="${subscription.cancelledDate}" dateStyle="long" timeStyle="short" type="both"/></td>
		</tr>
	</c:if>
	<tr>
		<td><spring:theme code="text.account.subscription.startDate" text="Start Date:"/></td>
		<td><fmt:formatDate value="${subscription.startDate}" dateStyle="long" timeStyle="short" type="both"/></td>
	</tr>
	<tr>
		<td><spring:theme code="text.account.subscription.placedOn" text="Ordered:"/></td>
		<td><fmt:formatDate value="${subscription.placedOn}" dateStyle="long" timeStyle="short" type="both"/></td>
	</tr>
</table>
<div class="button-container">
	<form:form id="viewBillingActivityForm" action="${subscriptionBillingActivityUrl}" method="get">
		<spring:theme var="viewBillingActivityText" code="text.account.subscription.viewBillingActivity"
						  text="View Billing Activity"/>
		<button type="submit" class="btn btn-primary" title="${viewBillingActivityText}">${viewBillingActivityText}</button>
		<input type="hidden" name="subscriptionId" value="${ycommerce:encodeHTML(subscription.id)}"/>
	</form:form>
</div>
