
<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscriptions" required="true" type="java.util.List" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="paymentInfoId" value="${paymentInfo.id}"/> 
<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url var="continueToEditPaymentDetailsUrl"
				value="/my-account/my-payment-details/edit"
				htmlEscape="false">
</spring:url>
<div id="payment-method-subscriptions">
	<div id="cboxTitle">
		<div class="headline">
			<span class="headline-text">
				<spring:theme code="text.account.paymentDetails.editPaymentDetails" text="Edit Payment Details"/>
			</span>
		</div>
	</div>
	<div class="small-popup-content" id="payment-method-subscriptions_${ycommerce:encodeHTML(paymentInfo.id)}">

		<div class="payment-box">
			<div class="credit-card">${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}</div>
			<spring:theme code="text.account.paymentDetails.payment.details" arguments="${fn:replace(paymentInfo.cardNumber,'*','')}"
							  text="cardNumber"/>
			<br>
			<spring:theme code="text.expires" text="Expires"/>
			:&nbsp;${paymentInfo.expiryMonth}/${paymentInfo.expiryYear}
		</div>

		<div class="infoline">
			<spring:theme code="text.account.paymentDetails.associatedSubscriptions"
							  text="The following subscriptions are associated to this payment method"/>
		</div>

		<table class="payment-list-table">
			<thead>
			<tr>
				<th>
					<spring:theme code="text.account.subscription.productName" text="Product Name"/>
				</th>
				<th class="hidden-xs">
					<spring:theme code="text.account.subscription.startDate" text="Start Date"/>
				</th>
				<th class="hidden-xs">
					<spring:theme code="text.account.subscription.endDate" text="End Date"/>
				</th>
				<th>
					<spring:theme code="text.account.subscription.status" text="Status"/>
				</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${subscriptions}" var="subscription">
				<tr>
					<td>${ycommerce:sanitizeHTML(subscription.name)}</td>
					<td class="hidden-xs">
						<fmt:formatDate type="date" value="${subscription.startDate}"/>
					</td>
					<td class="hidden-xs">
						<fmt:formatDate type="date" value="${subscription.endDate}"/>
					</td>
					<td>${ycommerce:encodeHTML(subscription.subscriptionStatus)}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="modal-actions">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-sm-push-6">
				 <form:form id="formEditpaymentInfo${paymentInfoId}" action="${continueToEditPaymentDetailsUrl}" method="POST">
				  <input type="hidden" name="paymentInfoId" id="paymentInfoId" value="${paymentInfoId}"/>
				    <a href="#" onClick="ACC.paymentDetailsTelco.submitEditPaymentInfo('${paymentInfoId}');" class="btn btn-default btn-primary btn-block">
				    <spring:theme code="text.account.paymentDetails.editPaymentDetails" text="Edit Payment Details"/>
				   </a>
			     </form:form>
				</div>
				<div class="col-xs-12 col-sm-6 col-sm-pull-6">
				<a href="#" onClick="window.location.reload(true)" class="btn btn-default btn-block">
						<spring:theme code="text.button.cancel" text="Cancel"/>
					</a>
				
				</div>
			</div>
		</div>
	</div>
</div>