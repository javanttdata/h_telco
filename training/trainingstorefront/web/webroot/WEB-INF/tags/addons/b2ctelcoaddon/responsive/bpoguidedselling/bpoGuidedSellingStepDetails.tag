<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="dashboard" required="true"
	type="de.hybris.platform.b2ctelcofacades.data.GuidedSellingDashBoardEntryData"%>
<%@ attribute name="loop" required="true" type="javax.servlet.jsp.jstl.core.LoopTagStatus"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url var="currentstepUrl" value="/bpo/configure/{bpoCode}/{stepId}/{parentEntryNumber}" htmlEscape="false">
	<spring:param name="bpoCode" value="${ycommerce:encodeHTML(bpoCode)}" />
	<spring:param name="stepId" value="${ycommerce:encodeHTML(dashboard.stepId)}" />
	<spring:param name="parentEntryNumber" value="${parentEntryNumber}" />
</spring:url>

<div class="stepwizard-step">
	<a href="${currentstepUrl}" aria-controls="${dashboard.stepId}">
		<p>
			<strong>Step ${loop.index +1}</strong>
		</p>
		<p>${ycommerce:encodeHTML(dashboard.stepName)}</p>
	</a>
</div>
