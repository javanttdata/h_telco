<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="${orderEntry.product.url}" var="productUrl"  htmlEscape="false"/>
<div class="item__image">
	<a href="${productUrl}">
		<product:productPrimaryImage product="${orderEntry.product}" format="thumbnail"/>
	</a>
</div>