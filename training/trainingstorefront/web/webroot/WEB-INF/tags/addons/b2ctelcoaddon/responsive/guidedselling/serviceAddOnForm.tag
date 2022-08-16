<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="bundleTab" required="true" type="de.hybris.platform.b2ctelcofacades.data.BundleTabData"%>
<%@ attribute name="product" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ attribute name="plansCount" required="false" type="java.lang.String"%>
<%@ attribute name="planCode" required="false" type="java.lang.String"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="/bundle/addEntry" var="addToCartBundle" htmlEscape="false" />
<spring:theme code="basket.add.to.basket" text="Add To Basket" var="addToBasketText" />

<c:set var="planCode" value="${ycommerce:encodeHTML(planCode)}"/>

<form:form action="${addToCartBundle}" method="post">
	<div id="${ycommerce:encodeHTML(bundleTab.parentBundleTemplate.id)}_${planCode}">
		<button type="submit" class="btn btn-block btn-primary btn-dark-style" title="${addToBasketText}">${addToBasketText}</button>
	</div>
	<input type="hidden" name="productCodePost" value="${planCode}" />
	<input type="hidden" name="quantity" value="1" />
	<input type="hidden" name="bundleNo" value="-1" />
	<input type="hidden" name="bundleTemplateId" value="${ycommerce:encodeHTML(bundleTab.sourceComponent.id)}" />
	<input type="hidden" name="navigation" value="PREVIOUS" />
</form:form>