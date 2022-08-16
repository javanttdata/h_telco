<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="upgradeOptionTab" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ attribute name="buttonTooltip" required="true" type="java.lang.String"%>
<%@ attribute name="isSubscriptionUpgradable" required="true" type="java.lang.Boolean"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>

<%--@elvariable id="subscriptionData" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData"--%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="/my-account/subscription/upgrade" var="upgradeSubscription" htmlEscape="false" />
<c:set var="subscriptionDataId" value="${ycommerce:encodeHTML(subscriptionData.id)}" />
<c:set var="upgradeOptionTabCode" value="${ycommerce:encodeHTML(upgradeOptionTab.code)}" />
<spring:url value="billing-upgrade-details?subscriptionId=${subscriptionDataId}&upgradeId=${upgradeOptionTabCode}" var="billingChangeUrl" htmlEscape="false"  />

<div class="sub-tabbody">
	<table class="sub-tabbody-table account-upgrade-table">
		<thead>
			<tr>
				<th>
					<div class="info-line center">
						<spring:theme code="text.account.subscriptions.upgrade.change" text="Change" />
					</div>
				</th>
				<th>
					<div class="top-plan">
						<spring:theme code="text.account.upgrade.current" text="Current Subscription" />
					</div>
					<div class="info-line">${ycommerce:encodeHTML(subscriptionProductData.name)}</div>
				</th>
				<th>
					<div class="top-plan">
						<spring:theme code="text.account.upgrade.upgradeOptions" text="Upgrade option(s)" />
					</div>
					<div class="info-line">${ycommerce:encodeHTML(upgradeOptionTab.name)}</div>
				</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="change_col">
					<spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency" />
				</td>
				<td>${ycommerce:encodeHTML(subscriptionProductData.subscriptionTerm.billingPlan.billingTime.name)}</td>
				<td>${ycommerce:encodeHTML(upgradeOptionTab.subscriptionTerm.billingPlan.billingTime.name)}</td>
			</tr>
			<tr>
				<td class="change_col">
					<spring:theme code="product.list.viewplans.price" text="Price" />
				</td>
				<td>
					<product:subscriptionPricesLister subscriptionData="${subscriptionProductData}" />
				</td>
				<td>
					<product:subscriptionPricesLister subscriptionData="${upgradeOptionTab}" />
				</td>
			</tr>
			<tr>
				<td class="change_col">
					<spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency" />
				</td>
				<td>${subscriptionProductData.subscriptionTerm.termOfServiceNumber}&nbsp;${ycommerce:encodeHTML(subscriptionProductData.subscriptionTerm.termOfServiceFrequency.name)}</td>
				<td>${upgradeOptionTab.subscriptionTerm.termOfServiceNumber}&nbsp;${ycommerce:encodeHTML(upgradeOptionTab.subscriptionTerm.termOfServiceFrequency.name)}</td>
			</tr>
			<c:if test="${not empty upgradeOptionTab.entitlements}">
				<tr>
					<td class="change_col">
						<spring:theme code="product.list.viewplans.entitlements" text="Included" />
					</td>
					<td>
						<product:entitlementLister subscriptionData="${subscriptionProductData}" showEntitlementQuantity="true"/>
					</td>
					<td>
						<product:entitlementLister subscriptionData="${upgradeOptionTab}" showEntitlementQuantity="true"/>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="change_col">
					<spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges" />
				</td>
				<td>
					<product:usageChargesLister subscriptionData="${subscriptionProductData}" />
				</td>
				<td>
					<product:usageChargesLister subscriptionData="${upgradeOptionTab}" />
				</td>
			</tr>
			<tr>
				<td class="change_col">
					<spring:theme code="text.account.subscription.renewalType.title" text="Renewal Type" />
				</td>
				<td>${ycommerce:encodeHTML(subscriptionProductData.subscriptionTerm.termOfServiceRenewal.name)}</td>
				<td>${ycommerce:encodeHTML(upgradeOptionTab.subscriptionTerm.termOfServiceRenewal.name)}</td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td class="upgrade-btn-container">
					<form:form class="upgrade-subscription-form right" id="upgradeSubscriptionForm_${subscriptionDataId}_${upgradeOptionTabCode}"
						action="${upgradeSubscription}" method="post">
						<c:set var="buttonTypeUpgrade" value="${isSubscriptionUpgradable? \"submit\" : \"button\" }"/>
						<button id="addUpgradeButton" class="btn btn-block btn-primary btn-dark-style" type="${buttonTypeUpgrade}"
							<c:if test="${isSubscriptionUpgradable eq false}">disabled="disabled"</c:if> title="<spring:theme code="${buttonTooltip}"/>">
							<spring:theme code="text.account.subscription.upgradeSubscriptionNow" text="Add Upgrade" />
						</button>					
						<input type="hidden" name="productCode" value="${upgradeOptionTabCode}" />
						<input type="hidden" name="subscriptionId" value="${subscriptionDataId}" />
						<input type="hidden" name="subscriberId" value="${subscriptionData.subscriptionBaseId}" />
						<input type="hidden" name="subscriberBillingId" value="${subscriptionData.billingsystemId}" />
						<input type="hidden" name="rootBpoCode" value="${subscriptionData.parentPOCode}" />
						<input type="hidden" name="subscriptionTermId" value="${upgradeOptionTab.subscriptionTerm.id}" />
					</form:form>
					<!-- Remove As no Billing System Integrated 
					<button class="btn btn-default view-potential-upgrade-billing-details" data-popup-title="<spring:theme code="text.account.upgrade.proposedBillingChanges" text="Proposed Billing Changes" />"
						data-url=$"     {bil     lingChangeUrl}">
						<spring:theme code="text.account.subscription.previewBillingChanges" text="View Billing Changes" />
					</button> -->
				</td>
			</tr>
		</tbody>
	</table>
</div>
