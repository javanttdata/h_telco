<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="paymentInfo" required="true" type="de.hybris.platform.commercefacades.order.data.CCPaymentInfoData" %>
<%@ attribute name="hasSubscriptions" required="true" type="java.lang.Boolean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>


<spring:htmlEscape defaultHtmlEscape="true"/>
<c:set var="paymentId" value="${paymentInfo.id}"/>

<div class="col-xs-12 col-sm-6 card">

	<div class="edit-remove-links">
		<div class="row">
			<div class="col-xs-10">
				<h3>
					<spring:theme code="text.account.paymentDetails" text="Payment Details" />
				</h3>
			</div>

			<div class="col-xs-2">
				<div class="account-cards-actions pull-right">
					<c:choose>
						<c:when test="${not hasSubscriptions}">
							<spring:url var="editPaymentUrl" value="edit?paymentInfoId={/paymentInfoId}&targetArea=accountArea" htmlEscape="false">
								<spring:param name="paymentInfoId" value="${paymentId}" />
							</spring:url>
							<a href="${editPaymentUrl}" class="action-links">
								<span class="glyphicon glyphicon-pencil"></span>
							</a>
						</c:when>
						<c:otherwise>
							<spring:url var="editSubscriptionsUrl" value="/my-account/my-payment-details/payment-method-subscriptions?paymentInfoId={/paymentInfoId}"
								htmlEscape="false">
								<spring:param name="paymentInfoId" value="${paymentId}" />
							</spring:url>
							<a href="#" id="edit-with-subscriptions-account" class="action-links" data-url="${editSubscriptionsUrl}">
								<span class="glyphicon glyphicon-pencil"></span>
							</a>
						</c:otherwise>
					</c:choose>
					<c:if test="${not hasSubscriptions}">
						<spring:theme var="removePaymentPopupTitle" code="text.account.paymentDetails.delete.popup.title" text="Delete Payment" />
						<a href="#" class="action-links removePaymentDetailsButton" data-popup-title="${removePaymentPopupTitle}"
							data-payment-id="${ycommerce:encodeHTML(paymentId)}">
							<span class="glyphicon glyphicon-remove"></span>
						</a>
					</c:if>
				</div>
			</div>
		</div>

		<ul class="pull-left">
			<li>${ycommerce:encodeHTML(paymentInfo.cardNumber)}</li>
			<li>${ycommerce:encodeHTML(paymentInfo.cardTypeData.name)}</li>
			<li>
				<spring:theme code="text.expires" text="Expires"/>&nbsp;
				${ycommerce:encodeHTML(paymentInfo.expiryMonth)}/${ycommerce:encodeHTML(paymentInfo.expiryYear)}
			</li>
		</ul>
	</div>
</div>
