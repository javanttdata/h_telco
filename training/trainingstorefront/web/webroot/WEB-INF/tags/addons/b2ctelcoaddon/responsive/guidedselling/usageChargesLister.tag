<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="subscriptionData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<spring:htmlEscape defaultHtmlEscape="true" />
<c:if test="${not empty subscriptionData.price and not empty subscriptionData.price.usageCharges}">
	<c:forEach items="${subscriptionData.price.usageCharges}" var="usageCharge" varStatus="loop">
		<span class="additional-usage">
			<b>${ycommerce:encodeHTML(usageCharge.name)}</b>
		</span>
		<br />
		<c:if test="${not empty usageCharge.usageChargeEntries}">
			<c:forEach items="${usageCharge.usageChargeEntries}" var="usageChargeEntry">
				<c:if test="${usageChargeEntry['class'].simpleName eq 'TierUsageChargeEntryData'}">
					<spring:theme code="product.list.viewplans.tierUsageChargeEntry"
						arguments="${usageChargeEntry.tierStart}^${usageChargeEntry.tierEnd}^^${usageChargeEntry.price.formattedValue}^${usageCharge.usageUnit.name}"
						argumentSeparator="^" />
					<br />
				</c:if>
				<c:if test="${usageChargeEntry['class'].simpleName eq 'OverageUsageChargeEntryData'}">
					<spring:theme code="product.list.viewplans.overageUsageChargeEntry" arguments="${usageChargeEntry.price.formattedValue},${usageCharge.usageUnit.name}" />
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${not loop.last}">
			<br />
			<br />
		</c:if>
	</c:forEach>
</c:if>
