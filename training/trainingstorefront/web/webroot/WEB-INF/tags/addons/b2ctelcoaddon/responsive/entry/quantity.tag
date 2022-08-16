<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="orderEntry" required="true"
	type="de.hybris.platform.commercefacades.order.data.OrderEntryData"%>
<%@ attribute name="consignmentEntryQuantity" required="false"
	type="java.lang.Integer"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<div class="item__quantity">
	<c:forEach items="${orderEntry.product.baseOptions}" var="option">
		<c:if test="${option.selected.url eq orderEntry.product.url}">
			<c:forEach items="${option.selected.variantOptionQualifiers}"
				var="selectedOption">
				<div>
					<span>${ycommerce:encodeHTML(selectedOption.name)}:</span> <span>${ycommerce:encodeHTML(selectedOption.value)}</span>
				</div>
			</c:forEach>
		</c:if>
	</c:forEach>
	<label class="visible-xs-inline visible-sm-inline"><spring:theme
			code="text.account.order.qty" text="QTY" />:</label> <span class="qtyValue">
		<c:choose>
			<c:when test="${not empty consignmentEntryQuantity}">
				${consignmentEntryQuantity}
			</c:when>
			<c:otherwise>
				${orderEntry.quantity}
			</c:otherwise>
		</c:choose>
	</span>
</div>

