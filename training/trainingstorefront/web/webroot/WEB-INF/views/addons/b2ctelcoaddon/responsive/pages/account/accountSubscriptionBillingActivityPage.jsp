<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/structure" %>

<%--@elvariable id="subscriptionData" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData"--%>
<%--@elvariable id="billingActivities" type="java.util.List<de.hybris.platform.subscriptionfacades.data.SubscriptionBillingData>"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url value="/my-account/subscription/" var="backToSubscriptionDetails" htmlEscape="false">
	<spring:param name="subscriptionDataId" value="${subscriptionData.id}"/>
</spring:url>
<spring:url value="/my-account/subscription/billing-activity/download" var="downloadBillingActivityDetailUrl" htmlEscape="false"/>

<div class="account-section">
	<div class="back-link border">
		<button type="button" class="addressBackBtn" data-back-to-addresses="${backToSubscriptionDetails}">
			<span class="glyphicon glyphicon-chevron-left"></span>
		</button>
		<span class="label">
			<spring:theme code="text.account.subscription.billingActivity" text="Billing Activity"/>
		</span>
	</div>

	<div class="account-section-header no-border">
		<div class="account-section-header__subheadline">
			<strong>${ycommerce:encodeHTML(subscriptionData.name)}</strong>
		</div>
		<div class="account-section-header__subheadline">
			${ycommerce:sanitizeHTML(subscriptionData.description)}
		</div>
	</div>
	<c:choose>
		<c:when test="${empty billingActivities}">
			<div class="account-section-content content-empty">
				<spring:theme code="text.account.subscriptions.noSubscriptions" text="You have no subscriptions"/>
			</div>
		</c:when>
		<c:otherwise>
			<div class="account-section-content">
				<div class="account-orderhistory">
					<div class="account-overview-table">
						<table class="orderhistory-list-table billing-details-table responsive-table">

							<tr class="account-orderhistory-table-head responsive-table-head">
								<th><spring:theme code="text.account.subscription.billingActivity.billingPeriod"
														text="Billing Period"/></th>
								<th><spring:theme code="text.account.subscription.billingActivity.billingDate" text="Billing Date"/></th>
								<th><spring:theme code="text.account.subscription.billingActivity.paymentAmount"
														text="Payment Amount"/></th>
								<th><spring:theme code="text.account.subscription.billingActivity.paymentStatus"
														text="Payment Status"/></th>
							</tr>

							<c:forEach items="${billingActivities}" var="billingActivity">
								<tr class="responsive-table-item">
									<structure:hiddenTitleCell titleCode="text.account.subscription.billingActivity.billingPeriod"
																		titleDefaultText="Billing Period">
										${ycommerce:encodeHTML(billingActivity.billingPeriod)}
									</structure:hiddenTitleCell>

									<structure:hiddenTitleCell titleCode="text.account.subscription.billingActivity.billingDate"
																		titleDefaultText="Billing Date">
										${ycommerce:encodeHTML(billingActivity.billingDate)}
									</structure:hiddenTitleCell>

									<structure:hiddenTitleCell titleCode="text.account.subscription.billingActivity.paymentAmount"
																		titleDefaultText="Payment Amount">
										${ycommerce:encodeHTML(billingActivity.paymentAmount)}
									</structure:hiddenTitleCell>

									<structure:hiddenTitleCell titleCode="text.account.subscription.billingActivity.paymentStatus"
																		titleDefaultText="Payment Status">
										${ycommerce:encodeHTML(billingActivity.paymentStatus)}
									</structure:hiddenTitleCell>
									<td class="hidden-sm hidden-md hidden-lg"/>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<div class="account-actions billing-activity-buttons">
		<a href="${backToSubscriptionDetails}" class="btn btn-default">
			<spring:theme code="text.account.subscription.returnToSubscriptionDetails" text="Return To Subscription"/>
		</a>
	</div>
</div>