<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="processType" required="true" type="java.lang.String" %>
<%@ attribute name="parentBpoCode" required="true" type="java.lang.String" %>
<%@ attribute name="parentEntryNumber" required="false" type="java.lang.Integer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/cart/addSpo" var="addToBpoSelection" htmlEscape="false"/>
<c:set var="productCode" value="${ycommerce:encodeHTML(product.code)}"/>
<form:form id="addToBpoSelection_${parentBpoCode}_${productCode}" method="post" class="add_bpo_cart_form"
			  action="${addToBpoSelection}">
	<input type="hidden" name="rootBpoCode" value="${parentBpoCode}"/>
	<input type="hidden" name="productCodePost" value="${productCode}"/>
	<input type="hidden" name="processType" value="${processType}"/>
	<button type="submit" class="btn-block btn btn-block btn-primary btn-dark-style js-enable-btn">
		<spring:theme code="extras.configure.button" text="Configure"/>
	</button>
</form:form>
