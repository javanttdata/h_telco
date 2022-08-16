<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%--@elvariable id="subscriptions" type="java.util.Collection<de.hybris.platform.subscriptionfacades.data.SubscriptionData>"--%>
<%--@elvariable id="paymentInfoMap" type="java.util.Map<java.lang.String, de.hybris.platform.commercefacades.order.data.CCPaymentInfoData>"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<div class="account-section-header">
	<spring:theme code="text.account.subscriptions" text="Subscriptions"/>
</div>

<c:choose>
	<c:when test="${empty subscriptionInfoMap}">
		<div class="account-section-content content-empty">
			<spring:theme code="text.account.subscriptions.noSubscriptions" text="You have no subscriptions"/>
		</div>
	</c:when>
	<c:otherwise>
		<div class="account-section-content">
			<div class="account-orderhistory">
				<div class="account-overview-table">
					<subscription:subscriptionListingTable subscriptionInfoMap="${subscriptionInfoMap}"
																		paymentInfoMap="${paymentInfoMap}"
																		displayActions="${true}"/>
				</div>
			</div>
		</div>
	</c:otherwise>
</c:choose>
