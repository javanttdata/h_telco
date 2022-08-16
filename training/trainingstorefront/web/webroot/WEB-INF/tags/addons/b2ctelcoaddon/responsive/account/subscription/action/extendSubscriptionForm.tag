<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="extensionOptions" required="true" type="java.util.Map" %>
<%@ attribute name="subscriptionId" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="extendSubscriptionTermDuration" value="/my-account/subscription/extend-term-duration" htmlEscape="false"/>
<spring:theme var="updateText" code="text.account.subscription.updateTermDuration" text="Update"/>

<form:form id="extend-subscription-form" action="${extendSubscriptionTermDuration}" method="post">
	<div class="row">
		<div class="col-sm-8">
			<select disabled class="sub_contract" id="contractDurationExtensionOptions" title="Contract Duration" name="contractDurationExtension">
				<c:forEach items="${extensionOptions}" var="extensionOption">
					<option value="${ycommerce:encodeHTML(extensionOption.key)}">
							${ycommerce:encodeHTML(extensionOption.value)}
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-sm-4">
			<button disabled  type="submit" class="btn btn-primary sub_contract" title="${updateText}">${updateText}</button>
			<input type="hidden" name="subscriptionId" value="${subscriptionId}"/>
		</div>
	</div>
</form:form>
