<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%@ attribute name="displayActions" required="false" type="java.lang.Boolean" %>
<%@ attribute name="displaySelectAllOption" required="false" type="java.lang.Boolean" %>
<%@ attribute name="subscriptionInfoMap" required="false" type="java.util.Map" %>
<%@ attribute name="paymentInfoMap" required="false" type="java.util.Map" %>


<spring:htmlEscape defaultHtmlEscape="true"/>

<table class="subscriptions-table">
	<tr class="responsive-table-head">
		<th><spring:theme code="text.account.subscriptions.productName" text="Product Name"/></th>
		<th><spring:theme code="text.account.subscriptions.startDate" text="Start Date"/></th>
		<th><spring:theme code="text.account.subscriptions.endDate" text="End Date"/></th>
		<th><spring:theme code="text.account.subscriptions.status" text="Status"/></th>
		<c:if test="${displayActions}">
			<th><spring:theme code="text.account.orderHistory.actions" text="Actions"/></th>
		</c:if>
		<c:if test="${displaySelectAllOption}">
			<th>
				<input id="selectall" title="selectall" type="checkbox"/>
				<spring:theme code="text.account.subscription.selectAll" text="Select All"/>
			</th>
		</c:if>
		<th></th>
	</tr>
	
	<c:forEach items="${subscriptionInfoMap}" var="subscriptionEntry">
	<subscription:subscriptionAccessListingTable subscriptionAccessData="${subscriptionEntry.key}" 
											  serviceList="${subscriptionEntry.value}" paymentInfoMap="${paymentInfoMap}"
											  displayActions="${displayActions}" displaySelectAllOption="${displaySelectAllOption}"/>
	</c:forEach>
	
</table>
