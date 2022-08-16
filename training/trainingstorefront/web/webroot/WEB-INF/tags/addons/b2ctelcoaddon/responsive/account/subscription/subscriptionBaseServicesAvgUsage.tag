<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%@ attribute name="subscriptionBaseServicesWithValueMap" required="true" type="java.util.Map" %>


<spring:htmlEscape defaultHtmlEscape="true"/>

<table class="subscriptions-table">
	<tr class="responsive-table-head">
		<th><spring:theme code="text.account.subscription.services.serviceName" text="Service Name"/></th>
		<th><spring:theme code="text.account.subscription.services.startDate" text="Start Date"/></th>
		<th><spring:theme code="text.account.subscription.services.endDate" text="End Date"/></th>
		<th><spring:theme code="text.account.subscription.services.status" text="Status"/></th>
		<th><spring:theme code="text.account.subscription.services.usage" text="Usage"/></th>
	</tr>
	
	<c:forEach items="${subscriptionBaseServicesWithValueMap}" var="subscriptionBaseServicesWithValue">
	<subscription:subscriptionServiceBaseListingTable tmaSubscribedProduct="${subscriptionBaseServicesWithValue.key}"
											  subscriptionBaseServicesAvarageValueList="${subscriptionBaseServicesWithValue.value}"/>
	</c:forEach>
	
</table>
