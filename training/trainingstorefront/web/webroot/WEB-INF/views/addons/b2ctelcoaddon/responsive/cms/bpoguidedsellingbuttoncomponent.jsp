<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url var="nextUrl" value="/bpo/configure/{bpoCode}/{nextStep}/{parentEntryNumber}" htmlEscape="false">
	<spring:param name="bpoCode" value="${ycommerce:encodeHTML(bpoCode)}" />
	<spring:param name="nextStep" value="${ycommerce:encodeHTML(nextStep)}" />
	<spring:param name="parentEntryNumber" value="${parentEntryNumber}" />
</spring:url>
<spring:url var="cartUrl" value="/cart" htmlEscape="false" />

<c:choose>
	<c:when test="${not empty nextStep}">
		<a class="btn btn-block btn-primary" href="${nextUrl}">
			<spring:theme code="button.next" text="Next" />
		</a>
	</c:when>
	<c:when test="${empty nextStep}">
		<a class="btn btn-block btn-primary" href="${cartUrl}">
			<spring:theme code="button.done" text="Done" />
		</a>
	</c:when>
</c:choose>
