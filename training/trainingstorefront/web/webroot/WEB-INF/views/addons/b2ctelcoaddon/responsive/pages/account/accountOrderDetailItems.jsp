<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="telco-order" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/order"%>

<div class="account-orderdetail account-consignment">
	<c:if test="${not empty orderData.unconsignedEntries}">
		<telco-order:orderUnconsignedEntries order="${orderData}" />
	</c:if>
	<c:forEach items="${orderData.consignments}" var="consignment">
		<c:if test="${consignment.status.code eq 'WAITING' or consignment.status.code eq 'PICKPACK' or consignment.status.code eq 'READY'}">
			<telco-order:consignmentStatus consignmentCode="${ycommerce:encodeHTML(consignment.status.code)}" orderData="${orderData}" consignment="${consignment}"
				inProgress="true" />
		</c:if>
	</c:forEach>
	<c:forEach items="${orderData.consignments}" var="consignment">
		<c:if test="${consignment.status.code ne 'WAITING' and consignment.status.code ne 'PICKPACK' and consignment.status.code ne 'READY'}">
			<telco-order:consignmentStatus consignmentCode="${ycommerce:encodeHTML(consignment.status.code)}" orderData="${orderData}" consignment="${consignment}" />
		</c:if>
	</c:forEach>
</div>