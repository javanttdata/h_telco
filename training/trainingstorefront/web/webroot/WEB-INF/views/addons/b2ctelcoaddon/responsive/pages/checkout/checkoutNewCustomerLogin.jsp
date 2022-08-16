<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/responsive/user" %>
<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url value="/login/checkout/register" var="registerAndCheckoutActionUrl" htmlEscape="false"/>
<user:register actionNameKey="checkout.login.registerAndCheckout" action="${registerAndCheckoutActionUrl}"/>