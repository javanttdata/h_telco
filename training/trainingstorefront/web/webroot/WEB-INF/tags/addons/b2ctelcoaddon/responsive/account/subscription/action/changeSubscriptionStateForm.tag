<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptionId" required="true" type="java.lang.String" %>
<%@ attribute name="buttonText" required="true" type="java.lang.String" %>
<%@ attribute name="newState" required="true" type="java.lang.String" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="changeSubscriptionStateUrl" value="/my-account/subscription/change-state" htmlEscape="false"/>
<form:form id="resume-subscription-form" action="${changeSubscriptionStateUrl}" method="post">
	<button type="submit" class="btn btn-primary btn-block" title="${buttonText}">${buttonText}</button>
	<input type="hidden" name="newState" value="${newState}"/>
	<input type="hidden" name="subscriptionId" value="${subscriptionId}"/>
</form:form>
