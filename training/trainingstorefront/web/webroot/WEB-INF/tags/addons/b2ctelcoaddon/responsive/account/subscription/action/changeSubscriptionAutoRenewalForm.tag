<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptionId" required="true" type="java.lang.String" %>
<%@ attribute name="buttonText" required="true" type="java.lang.String" %>
<%@ attribute name="autoRenew" required="true" type="java.lang.Boolean" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="setAutorenewStatusUrl" value="/my-account/subscription/set-autorenewal-status" htmlEscape="false"/>
<form:form id="deactivateAutorenewalForm" action="${setAutorenewStatusUrl}" method="post">
	<button type="submit" class="btn btn-default btn-block" title="${buttonText}">${buttonText}</button>
	<input type="hidden" name="autorenew" value="${autoRenew}"/>
	<input type="hidden" name="subscriptionId" value="${subscriptionId}"/>
</form:form>
