<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="upgradePreviewData" required="true" type="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:forEach items="${upgradePreviewData}" var="upgradePreview" >
	<table class="upgrade-preview-table">
		<thead>
			<tr>
				<th>
					<spring:theme code="text.account.upgrade.billingPeriod" text="Billing Period" />
				</th>
				<th>${ycommerce:encodeHTML(upgradePreview.billingPeriod)}</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<spring:theme code="text.account.upgrade.paymentAmount" text="Payment Amount" />
				</td>
				<td>${ycommerce:encodeHTML(upgradePreview.paymentAmount)}</td>
			</tr>
			<tr>
				<td>
					<spring:theme code="text.account.upgrade.billingDate" text="Billing Date" />
				</td>
				<td>${ycommerce:encodeHTML(upgradePreview.billingDate)}</td>
			</tr>
		</tbody>
	</table>
</c:forEach>