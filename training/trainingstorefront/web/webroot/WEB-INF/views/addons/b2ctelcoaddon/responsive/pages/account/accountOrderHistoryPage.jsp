<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<spring:htmlEscape defaultHtmlEscape="true" />
<jsp:useBean id="billingname" class="java.util.LinkedHashMap" />
<jsp:useBean id="tdlist" class="java.util.LinkedHashMap" scope="page" />
<spring:url value="/my-account/order/" var="orderDetailsUrl" htmlEscape="false" />
<spring:url value="/my-account/orders?sort=${ycommerce:encodeUrl(searchPageData.pagination.sort)}" var="searchUrl"
	htmlEscape="false" />

<div class="account-section-header">
	<spring:theme code="text.account.orderHistory" text="Checkout Total" />
</div>
<c:if test="${empty searchPageData.results}">
	<div class="account-section-content content-empty">
		<spring:theme code="text.account.orderHistory.noOrders" text="No Orders Found" />
	</div>
</c:if>
<c:if test="${not empty searchPageData.results}">
	<div class="account-section-content	">
		<div class="account-orderhistory">
			<div class="account-orderhistory-pagination">
				<nav:pagination top="true" msgKey="text.account.orderHistory.page" showCurrentPageInfo="true" hideRefineButton="true"
					supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
					searchUrl="${searchUrl}" numberPagesShown="${numberPagesShown}" />
			</div>
			<div class="account-overview-table">
				<table class="orderhistory-list-table responsive-table">
					<tr class="account-orderhistory-table-head responsive-table-head hidden-xs">
						<th><spring:theme code="text.account.orderHistory.orderNumber" text="Order Number" /></th>
						<th><spring:theme code="text.account.orderHistory.orderStatus" text="Order Status" /></th>
						<th><spring:theme code="text.account.orderHistory.datePlaced" text="Date Placed" /></th>
						<th><spring:theme code="text.account.order.orderTotals.payNow" text="Pay on Checkout Total" /></th>
					</tr>
					<c:forEach items="${searchPageData.results}" var="order">
						<tr class="responsive-table-item">
							<td class="hidden-sm hidden-md hidden-lg"><spring:theme code="text.account.orderHistory.orderNumber"
									text="Order Number" /></td>
							<td class="responsive-table-cell"><a href="${orderDetailsUrl}${ycommerce:encodeHTML(order.code)}"
								class="responsive-table-link"> ${ycommerce:encodeHTML(order.code)} </a></td>
							<td class="hidden-sm hidden-md hidden-lg"><spring:theme code="text.account.orderHistory.orderStatus"
									text="Order Status" /></td>
							<td class="status"><spring:theme code="text.account.order.status.display.${order.statusDisplay}" /></td>
							<td class="hidden-sm hidden-md hidden-lg"><spring:theme code="text.account.orderHistory.datePlaced" text="Date Placed" />
							</td>
							<td class="responsive-table-cell"><fmt:formatDate value="${order.placed}" dateStyle="medium" timeStyle="short"
									type="both" /></td>
							<td class="responsive-table-cell"><format:price priceData="${order.total}" displayFreeForZero="false"/></td>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="account-orderhistory-pagination">
			<nav:pagination top="false" msgKey="text.account.orderHistory.page" showCurrentPageInfo="true" hideRefineButton="true"
				supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
				searchUrl="${searchUrl}" numberPagesShown="${numberPagesShown}" />
		</div>
	</div>
</c:if>
