<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/store-finder" var="storefinderUrl"/>

<a href="${storefinderUrl}">
	<span class="glyphicon glyphicon-map-marker"></span> 
	<span class ="hidden-xs hidden-sm">
		<spring:theme code="storeFinder.store.locator" text="Store Locator"/>
	</span>
</a>
