<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account"%>

<%--@elvariable id="subscriptionData" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData"--%>
<%--@elvariable id="cartData" type=de.hybris.platform.commercefacades.order.data.CartData"--%>
<%--@elvariable id="upsellingOptions" type="java.util.List<de.hybris.platform.commercefacades.product.data.ProductData>"--%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="" var="buttonTooltip" htmlEscape="false" />
<c:set var="isSubscriptionUpgradable" value="true" />
<div class="headline">
	<spring:theme code="text.account.upgrade.options" text="Upgrade Options" />
</div>
<div class="description">
	<spring:theme code="text.account.upgrade.options.description" text="View options" />
</div>

<div class="item_container account-upgrade-subscription">

	<c:if test="${subscriptionData.subscriptionStatus eq 'cancelled'}">
		<c:set var="isSubscriptionUpgradable" value="false" />
		<spring:url value="text.account.subscription.cancelledSubscriptionNotUpgradable" var="buttonTooltip" htmlEscape="false" />
	</c:if>

	<c:if test="${isSubscriptionUpgradable}">
		<c:forEach items="${cartData.entries}" var="entry">
			<c:if test="${not empty entry.originalSubscriptionId and subscriptionData.id eq entry.originalSubscriptionId}">
				<c:set var="isSubscriptionUpgradable" value="false" />
				<spring:url value="text.account.subscription.alreadyUpgraded" var="buttonTooltip" htmlEscape="false" />
			</c:if>
		</c:forEach>
	</c:if>

	<div class="tabs js-tabs tabs-responsive">
		<c:forEach items="${upsellingOptions}" var="upgradeOptionTab">
			<div class="tabhead">
				<a href="" <c:if test="${upgradeOptionTab.preselected}"> id="preselected"</c:if>>${ycommerce:encodeHTML(upgradeOptionTab.name)}</a>
			</div>
			<div class="tabbody">
				<account:upgradeSubscriptionTable upgradeOptionTab="${upgradeOptionTab}" isSubscriptionUpgradable="${isSubscriptionUpgradable}"
					buttonTooltip="${buttonTooltip}" />
				<spring:url value="/my-account/subscription/{/subscriptionDataId}/manage" var="myAccountSubscriptionDetailsUrl" htmlEscape="false">
					<spring:param name="subscriptionDataId" value="${subscriptionData.id}" />
				</spring:url>
				<div class="button-container">
					<a class="r_action_btn cancel" href="${myAccountSubscriptionDetailsUrl}">
						<spring:theme code="text.account.subscription.returnToCurrentPlan" text="Return to Current Plan" />
					</a>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
