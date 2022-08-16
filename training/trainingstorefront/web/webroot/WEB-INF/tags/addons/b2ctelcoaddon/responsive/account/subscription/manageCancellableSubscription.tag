<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="subscription" required="true" type="de.hybris.platform.subscriptionfacades.data.SubscriptionData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="cancelUrl" value="/my-account/subscription/cancel/{/subscriptionId}" htmlEscape="false">
	<spring:param name="subscriptionId" value="${subscription.id}"/>
</spring:url>

<c:if test="${subscription.cancellable}">
	<div class="hidden">
		<div id="cancel-subscription-confirm">
			<div>
				<p>
					<spring:theme code="text.account.subscription.cancellation.message"
									  text="Are you sure you would like to cancel this subscription"/>
				</p>
				<div class="margin-top-20">
					<a href="${cancelUrl}" class="btn btn-primary btn-block">
						<spring:theme code="text.account.subscription.cancellable.yes" text="Yes"/>
					</a>
					<a href="#" onclick="jQuery.colorbox.close();" class="btn btn-default btn-block">
						<spring:theme code="text.account.subscription.cancellable.no" text="No"/>
					</a>
				</div>
			</div>
		</div>
	</div>
</c:if>
