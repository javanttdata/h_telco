<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/structure" %>

<%@ attribute name="paymentInfoMap" required="false" type="java.util.Map" %>
<%@ attribute name="displayActions" required="false" type="java.lang.Boolean" %>
<%@ attribute name="displaySelectAllOption" required="false" type="java.lang.Boolean" %>
<%@ attribute name="accessType" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaAccessTypeData" %>
<%@ attribute name="subscription" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaSubscribedProductData" %>


<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="subscriptionId" value="${ycommerce:encodeHTML(subscription.id)}"/>
<c:set var="subscriptionStatus" value="${fn:toUpperCase(subscription.subscriptionStatus)}"/>
<c:set var="isPausedSubscription" value="${subscriptionStatus eq 'PAUSED'}"/>
<c:set var="isActiveSubscription" value="${not isPausedSubscription and subscriptionStatus ne 'CANCELLED'}"/>

<spring:eval expression="accessType!= T(de.hybris.platform.b2ctelcofacades.data.TmaAccessTypeData).BENEFICIARY" var="isAccessTypeOwnerOrAdministrator" />
<c:choose>
	<c:when test="${isAccessTypeOwnerOrAdministrator==true}">
				<c:set var="actionId" value="manage"/>
				<c:set var="actionCode" value="text.manage"/>
	</c:when>
	<c:otherwise>
				<c:set var="actionId" value="details"/>
				<c:set var="actionCode" value="text.details"/>
	</c:otherwise>
</c:choose>

<spring:url var="subscriptionDetailsUrl" value="/my-account/subscription/{/subscriptionId}/{actionVal}"
				htmlEscape="false">
	<spring:param name="subscriptionId" value="${subscriptionId}"/>
	<spring:param name="actionVal" value="${actionId}"/>
</spring:url>
<spring:url var="productDetailsUrl" value="${subscription.productUrl}" htmlEscape="false"/>

<tr>
	<structure:hiddenTitleCell titleCode="text.account.subscriptions.productName" titleDefaultText="Product Name">
		${ycommerce:encodeHTML(subscription.name)}  (${subscriptionId})
	</structure:hiddenTitleCell>
	<structure:hiddenTitleCell titleCode="text.account.subscriptions.startDate" titleDefaultText="Start Date">
		<fmt:formatDate value="${subscription.startDate}" dateStyle="long" timeStyle="short" type="date"/>
	</structure:hiddenTitleCell>
	<structure:hiddenTitleCell titleCode="text.account.subscriptions.endDate" titleDefaultText="End Date">
		<fmt:formatDate value="${subscription.endDate}" dateStyle="long" timeStyle="short" type="date"/>
	</structure:hiddenTitleCell>
	<structure:hiddenTitleCell titleCode="text.account.subscriptions.status" titleDefaultText="Status">
		${ycommerce:encodeHTML(subscriptionStatus)}
	</structure:hiddenTitleCell>
	<c:if test="${displayActions}">
		<structure:hiddenTitleCell titleCode="text.account.orderHistory.actions" titleDefaultText="Actions">
			<a href="${subscriptionDetailsUrl}" class="manage-link">
				<spring:theme code="${actionCode}" text="${actionId}"/>
			</a>
		</structure:hiddenTitleCell>
		<structure:hiddenTitleCell titleCode="text.account.subscriptions.remove" titleDefaultText="Status">
			<c:if test="${isPausedSubscription and isAccessTypeOwnerOrAdministrator}">
				<spring:theme var="changeSubscriptionStateButtonText" code="text.account.subscription.resumeSubscription"
								  text="Resume Subscription"/>
				<spring:url var="changeSubscriptionStateUrl" value="/my-account/subscription/change-state" htmlEscape="false"/>
				<form:form id="resume-subscription-form" action="${changeSubscriptionStateUrl}" method="post">
					<button type="submit" class="btn btn-primary" title="${changeSubscriptionStateButtonText}">${changeSubscriptionStateButtonText}</button>
					<input type="hidden" name="newState" value="ACTIVE"/>
					<input type="hidden" name="subscriptionId" value="${subscriptionId}"/>
				</form:form>																
			</c:if>
		</structure:hiddenTitleCell>
	</c:if>
	<c:if test="${displaySelectAllOption}">
		<structure:hiddenTitleCell titleCode="text.account.subscription.select" titleDefaultText="Select">
			<form:checkbox path="subscriptionsToChange" value="${subscriptionId}"/>
		</structure:hiddenTitleCell>
	</c:if>
</tr>
