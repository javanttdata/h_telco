<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="${productdata.url}" var="productDataUrl" htmlEscape="false" />
<c:if test="${not empty productdata}">
	<div class="container subscribe-section">
		<div class="row quad-section">
			<div class="col-xs-8 col-sm-9 col-lg-11">
				<h4>
					<a href="${productDataUrl}">
					<spring:theme code="upsell.bundleProductOffering.name" arguments="${ycommerce:encodeHTML(productdata.name)}" 
					htmlEscape="false" /></a>
				</h4>
				<p class="description">${ycommerce:sanitizeHTML(productdata.description)}</p>
				<a class="detail-link" href="${productDataUrl}">
				<spring:theme code="text.details" text="Details" />
				</a>
			</div>

			<div class="col-xs-4 col-sm-3 col-lg-1">
				<a class="quad-img" href="${productDataUrl}"> <product:productPrimaryImage
						product="${productdata}" format="thumbnail" /></a>
			</div>
		</div>
	</div>
</c:if>