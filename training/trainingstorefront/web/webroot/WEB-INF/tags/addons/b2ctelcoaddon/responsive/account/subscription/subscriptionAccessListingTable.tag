<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/structure" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%@ attribute name="displayActions" required="false" type="java.lang.Boolean" %>
<%@ attribute name="displaySelectAllOption" required="false" type="java.lang.Boolean" %>
<%@ attribute name="paymentInfoMap" required="false" type="java.util.Map" %>
<%@ attribute name="serviceList" required="true" type="java.util.Set" %>
<%@ attribute name="subscriptionAccessData" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionAccessData" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

	
<c:set var="linkToSubscriptionBaseUrl" value="/my-account/subscription/subscription-base/{billingSystemId}/{subscriberIdentity}"/>
<spring:url var="linkToSubscriptionBaseUrl" value="${linkToSubscriptionBaseUrl}" htmlEscape="false">
	<spring:param name="billingSystemId" value="${subscriptionAccessData.billingSystemId}" />
	<spring:param name="subscriberIdentity" value="${subscriptionAccessData.subscriberIdentity}" />
</spring:url>

<tr>
	<td colspan="6">
		<a href="${linkToSubscriptionBaseUrl}">${ycommerce:encodeHTML(subscriptionAccessData.subscriberIdentity)}</a>
	</td>
</tr>
<c:forEach items="${serviceList}" var="tmaService">
	<subscription:subscriptionListingTableItem subscription="${tmaService}" paymentInfoMap="${paymentInfoMap}"
																 displayActions="${displayActions}"
																 displaySelectAllOption="${displaySelectAllOption}"
																 accessType="${subscriptionAccessData.accessType}"/>
</c:forEach>
	