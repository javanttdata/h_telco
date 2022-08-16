<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/structure" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<%--@elvariable id="paymentInfoData" type="java.util.List<de.hybris.platform.commercefacades.order.data.CCPaymentInfoData>"--%>
<%--@elvariable id="subscriptions" type="java.util.List<de.hybris.platform.subscriptionfacades.data.SubscriptionData> "--%>
<%--@elvariable id="subscriptionsPerPaymentMethod" type="java.util.HashMap<java.lang.String,java.lang.Integer>"--%>

<c:if test="${not empty paymentInfoData}">
	<c:set var="noBorder" value="no-border"/>
</c:if>

<spring:url var="addPaymentDetailsUrl" value="my-payment-details/add" htmlEscape="false"/>

<div class="account-section-header ${noBorder}">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<spring:theme code="text.account.paymentDetails" text="Payment Details"/>
		</div>
		<div class="account-section-header-add col-xs-12 col-sm-6">
			<a href="${addPaymentDetailsUrl}">
				<spring:theme code="text.account.paymentDetails.addNewPaymentDetails" text="Add Payment"/>
			</a>
		</div>
	</div>
</div>
<c:choose>
	<c:when test="${not empty paymentInfoData}">
		<div class="account-paymentdetails account-list">
			<div class="account-cards card-select">
				<div class="row">
					<c:forEach items="${paymentInfoData}" var="paymentInfo">
						<account:paymentMethodDetails subscriptions="${subscriptions}" paymentInfo="${paymentInfo}"
																subscriptionsPerPaymentMethod="${subscriptionsPerPaymentMethod}"/>
					</c:forEach>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="account-section-content content-empty">
			<spring:theme code="text.account.paymentDetails.noPaymentInformation" text="No Saved Payment Details"/>
		</div>
	</c:otherwise>
</c:choose>
