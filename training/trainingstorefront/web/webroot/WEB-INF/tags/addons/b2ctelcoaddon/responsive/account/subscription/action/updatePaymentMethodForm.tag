<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentInfos" required="true"
				  type="java.util.List<de.hybris.platform.commercefacades.order.data.CCPaymentInfoData>" %>
<%@ attribute name="subscription" required="true" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="replaceSubscriptionPaymentMethodUrl" value="/my-account/subscription/billing-activity/payment-method/replace"
				htmlEscape="false"/>
<spring:theme var="updateText" code="text.account.subscription.updateTermDuration" text="Update"/>
<c:if test="${fn:length(paymentInfos) < 2}">
	<c:set var="disabledField" value="disabled=\"disabled\""/>
	<c:set var="disabledValue" value="disabled"/>
</c:if>

<c:if test="${fn:length(paymentInfos) >0}">
<form:form id="update-payment-method-form" action="${replaceSubscriptionPaymentMethodUrl}" method="post">
	<div class="row">
		<div class="col-sm-8">
			<select id="paymentMethods" name="paymentMethodId" title="Payment Methods" ${disabledField}>
				<c:forEach items="${paymentInfos}" var="paymentInfo">
					<c:if test="${paymentInfo.subscriptionId eq subscription.paymentMethodId}">
						<c:set var="selectedField" value="selected"/>
					</c:if>
					<option value="${ycommerce:encodeHTML(paymentInfo.subscriptionId)}" ${selectedField}>
						<spring:theme code="text.account.subscription.paymentMethod" text="Update"
										  arguments="${paymentInfo.cardTypeData.name},
										  ${fn:replace(paymentInfo.cardNumber,'****','**** ')},
										  ${paymentInfo.expiryMonth},${paymentInfo.expiryYear}"/>
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-sm-4">
			<button type="submit" class="btn btn-primary" ${disabledValue} title="${updateText}">${updateText}</button>
		</div>
	</div>
	<input type="hidden" name="effectiveFrom" value="NOW"/>
	<input type="hidden" name="subscriptionId" value="${ycommerce:encodeHTML(subscription.id)}"/>
</form:form>
</c:if>