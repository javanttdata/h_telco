<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="structure" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/structure" %>
<%@ attribute name="subscriptionBaseServicesAvarageValueList" required="false" type="java.util.Set" %>
<%@ attribute name="tmaSubscribedProduct" required="true" type="de.hybris.platform.b2ctelcofacades.data.TmaSubscribedProductData" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="tmaSubscribedProductStatus" value="${fn:toUpperCase(tmaSubscribedProduct.subscriptionStatus)}"/>
<c:forEach items="${subscriptionBaseServicesAvarageValueList}" var="subscriptionBaseServicesAvarageValueList">
	<c:set var="tmaPscvData" value="${subscriptionBaseServicesAvarageValueList.tmaProductSpecCharacteristicValueData}"/>
	<c:set var="tmaServiceUsageValue" value="${ycommerce:encodeHTML(subscriptionBaseServicesAvarageValueList.value)}"/>
	<c:set var="tmaServiceUnitOfMeasurment" value="${ycommerce:encodeHTML(subscriptionBaseServicesAvarageValueList.unitOfMeasure)}"/>
	<c:set var="tmaPscValue" value="${ycommerce:encodeHTML(tmaPscvData.value)}"/>
	<c:set var="tmaPscDescription" value="${ycommerce:sanitizeHTML(tmaPscvData.description)}"/>
	<c:set var="tmaPscUnitOfMeasurment" value="${ycommerce:sanitizeHTML(tmaPscvData.unitOfMeasurment)}"/>
	<tr>
		<structure:hiddenTitleCell titleCode="text.account.subscription.services.serviceName" titleDefaultText="Service Name">
			${ycommerce:encodeHTML(tmaSubscribedProduct.name)}
		</structure:hiddenTitleCell>
		<structure:hiddenTitleCell titleCode="text.account.subscription.services.startDate" titleDefaultText="Start Date">
			<fmt:formatDate value="${tmaSubscribedProduct.startDate}" dateStyle="long" timeStyle="short" type="date"/>
		</structure:hiddenTitleCell>
		<structure:hiddenTitleCell titleCode="text.account.subscription.services.endDate" titleDefaultText="End Date">
			<fmt:formatDate value="${tmaSubscribedProduct.endDate}" dateStyle="long" timeStyle="short" type="date"/>
		</structure:hiddenTitleCell>
		<structure:hiddenTitleCell titleCode="text.account.subscription.services.status" titleDefaultText="Status">
			${ycommerce:encodeHTML(tmaSubscribedProductStatus)}
		</structure:hiddenTitleCell>
		<structure:hiddenTitleCell titleCode="text.account.subscription.services.usage" titleDefaultText="Usage">
			<spring:theme code="text.account.subscription.services.usageValue" arguments="${tmaServiceUsageValue},${tmaServiceUnitOfMeasurment},${tmaPscValue},${tmaPscUnitOfMeasurment},${tmaPscDescription}" />
		</structure:hiddenTitleCell>
	</tr>
</c:forEach>
