<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ attribute name="subscriptions" required="true" type="java.util.List" %>
<%@ attribute name="paymentMethods" required="true" type="java.util.List" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="changePaymentMethodSubscriptionUrl" value="/my-account/my-payment-details/change-payment-method-subscription"
				htmlEscape="false"/>
<c:set var="paymentId" value="${paymentInfo.id}"/>
<c:set var="hasPaymentMethods" value="${not empty paymentMethods}"/>
<c:set var="hasSubscriptions" value="${not empty subscriptions}"/>

<div class="description">
	<div class="row">
		<div class="col-xs-12">
			<spring:theme code="text.account.paymentDetails.associatedSubscriptions"
							  text="The following subscriptions are associated to this payment method"/>
		</div>
	</div>
</div>
<br>

<form:form id="idManageAssociatedSubscriptions" class="orderList" method="post" modelAttribute="paymentSubscriptionsForm"
			  action="${changePaymentMethodSubscriptionUrl}">
	<input type="hidden" name="paymentInfoId" value="${ycommerce:encodeHTML(paymentId)}"/>
	<subscription:manageSubscriptionListingTable subscriptions="${subscriptions}"
														displaySelectAllOption="${hasSubscriptions and hasPaymentMethods}"/>
	<br>
	<c:if test="${hasSubscriptions and hasPaymentMethods}">
		<div class="infoText">
			<spring:theme code="text.account.paymentDetails.change.selectedSubscriptions"
							  text="Move the selected subscriptions across to other payment details in your account:"/>
		</div>
	</c:if>
	<c:choose>
		<c:when test="${hasPaymentMethods}">
			<div class="payment-box">
				<div class="credit-card">${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}</div>
				<spring:theme code="text.account.paymentDetails.payment.details"
								  arguments="${fn:replace(paymentInfo.cardNumber,'*','')}" text="cardNumber"/><br>
				<spring:theme code="text.expires" text="Expires"/>:&nbsp;
					${ycommerce:encodeHTML(paymentInfo.expiryMonth)}/${ycommerce:encodeHTML(paymentInfo.expiryYear)}
			</div>

			<div class="change-box right">
				<div class="actions">
					<table class="responsive-table">
						<tr class="responsive-table-item">
							<td class="responsive-table-cell">
								<form:select id="change-pm" path="newPaymentMethodId">
									<spring:theme var="selectPaymentMethodText" code="text.account.paymentDetails.selectPaymentMethod"
													  text="Select alternate payment details..."/>
									<option value="" label="${selectPaymentMethodText}" selected="selected">
										<spring:theme code="text.account.paymentDetails.selectPaymentMethod" text="Remove impossible"/>
									</option>
									<form:options items="${paymentMethods}" itemValue="code" itemLabel="name"/>
								</form:select>
								<form:button id="button-change-to" type="submit" class="btn btn-primary" disabled="true">
									<spring:theme code="text.account.paymentDetails.changeTo" text="Change Payment Details"/>
								</form:button>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<p>
				<spring:theme code="text.account.paymentDetails.remove.changeImpossible"
								  text="There are currently no other payment methods associated to your account."/>
			</p>
		</c:otherwise>
	</c:choose>
</form:form>
