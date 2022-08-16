<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="subscriptionData" required="true" 
	type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ attribute name="showEntitlementQuantity" required="false" type="java.lang.Boolean"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:forEach items="${subscriptionData.entitlements}" var="entitlement" varStatus="loop">
	<strong>${ycommerce:encodeHTML(entitlement.name)}</strong><br/>
	<c:choose>
		<c:when test="${empty entitlement.quantity}">
			<spring:theme code="product.list.viewplans.entitlements.true" text="true" />
			<br />
		</c:when>
		<c:when test="${showEntitlementQuantity}">
			<c:choose>
				<c:when test="${entitlement.quantity lt 0}">
					<spring:theme code="product.list.viewplans.entitlements.unlimited" text="unlimited" />
				</c:when>
				<c:when test="${entitlement.quantity gt 0}">
					${entitlement.quantity}
				</c:when>
			</c:choose>
			<c:if test="${!loop.last and entitlement.quantity != 0}">
				<br/>
			</c:if>
		</c:when>
	</c:choose>
</c:forEach>
