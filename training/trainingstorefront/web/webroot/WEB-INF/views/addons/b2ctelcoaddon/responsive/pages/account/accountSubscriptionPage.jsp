<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<%--@elvariable id="subscriptionData" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData"--%>
<%--@elvariable id="subscriptionProductData" type="de.hybris.platform.commercefacades.product.data.ProductData"--%>
<%--@elvariable id="upgradable" type="java.lang.Boolean"--%>
<%--@elvariable id="extensionOptions" type="java.util.Map"--%>
<%--@elvariable id="paymentInfos" type="java.util.List<de.hybris.platform.commercefacades.order.data.CCPaymentInfoData>"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="productDetailsUrl" value="${subscriptionData.productUrl}" htmlEscape="false"/>
<spring:url var="orderDetailsUrl" value="/my-account/order/{/orderNumber}" htmlEscape="false">
	<spring:param name="orderNumber" value="${subscriptionData.orderNumber}"/>
</spring:url>
<spring:url var="backToSubscriptions" value="/my-account/subscription" htmlEscape="false"/>
<spring:url var="upgradeSubscriptionComparisionUrl"
				value="/my-account/subscription/upgrades-comparison?subscriptionId={/subscriptionId}" htmlEscape="false">
	<spring:param name="subscriptionId" value="${subscriptionData.id}"/>
</spring:url>
<c:set var="subscriptionStatus" value="${fn:toUpperCase(subscriptionData.subscriptionStatus)}"/>
<c:set var="isNotCancelledSubscription" value="${subscriptionStatus ne 'CANCELLED'}"/>
<c:set var="actionVal" value="${actionVal eq 'manage'}"/>
<div class="account-orderdetail">
	<div class="back-link border">
		<button type="button" class="addressBackBtn" data-back-to-addresses="${backToSubscriptions}">
			<span class="glyphicon glyphicon-chevron-left"></span>
		</button>
		<span class="label">
			<a href="${productDetailsUrl}">${ycommerce:encodeHTML(subscriptionData.name)}</a>
		</span>
	</div>

	<div class="account-section-header no-border row">
		<div class="col-sm-8 no-side-padding">
			<div class="account-section-header__subheadline">
				<strong>${ycommerce:encodeHTML(subscriptionData.name)}</strong>
			</div>
			<c:if test="${not empty subscriptionData.description}">
				<div class="account-section-header__subheadline">
						${ycommerce:sanitizeHTML(subscriptionData.description)}
				</div>
			</c:if>
			<div class="account-section-header__subheadline">
				<span><spring:theme code="text.account.subscription.orderNumber" text="Order Number"/>:</span>
				<span><a href="${orderDetailsUrl}">${ycommerce:encodeHTML(subscriptionData.orderNumber)}</a></span>
			</div>
		</div>

		<c:if test="${isNotCancelledSubscription and upgradable and actionVal}">
			<div class="col-sm-4 no-side-padding">
				<button type="button" onclick="window.location='${upgradeSubscriptionComparisionUrl}'"
						  class="btn btn-primary upgrade-btn pull-right">
					<spring:theme code="text.account.subscription.upgradeSubscriptionDetail" text="Upgrade Options"/>
				</button>
			</div>
		</c:if>
	</div>

	<div class="row">
		<c:choose>
		   <c:when test="${actionVal}">
		      <div class="col-md-4">
			    <subscription:subscriptionDetails subscription="${subscriptionData}" subscriptionProduct="${subscriptionProductData}"
														 upgradable="${upgradable}" isNotCancelledSubscription="${isNotCancelledSubscription}"/>
		      </div>
		      <div class="col-md-4">
			    <subscription:manageSubscription subscription="${subscriptionData}"
														isNotCancelledSubscription="${isNotCancelledSubscription}"
														extensionOptions="${extensionOptions}" paymentInfos="${paymentInfos}"/>
		      </div>
		      <div class="col-md-4">
		 	    <subscription:subscriptionActivity subscription="${subscriptionData}"/>
		      </div>
		   </c:when>
		   <c:otherwise>
             <div class="col-md-6">
			   <subscription:subscriptionDetails subscription="${subscriptionData}" subscriptionProduct="${subscriptionProductData}"
														 upgradable="${upgradable}" isNotCancelledSubscription="${isNotCancelledSubscription}"/>
		     </div>
		     <div class="col-md-6">
			   <subscription:subscriptionActivity subscription="${subscriptionData}"/>
		     </div>
           </c:otherwise>
		 </c:choose>
	</div>
</div>
