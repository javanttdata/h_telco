<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="${product.url}" var="productUrl" htmlEscape="false" />
<c:set value="${ycommerce:encodeHTML(product.name)}" var="productName" />

<div class="sbg-prod">
	<div class="row visible-lg visible-md">
		<div class="col-md-4">
			<div class="thumb simple-responsive-banner-component">
				<a href="${productUrl}" title="${productName}">
					<product:productPrimaryImage product="${product}" format="product" />
				</a>
			</div>
		</div>

		<div class="col-md-8">
			<div class="name">
				<a href="${productUrl}" title="${productName}">${productName}</a>
			</div>
		</div>

		<div class="col-md-8">
			<div class="summary">${ycommerce:sanitizeHTML(product.summary)}</div>
		</div>
	</div>

	<div class="row hidden-lg hidden-md">
		<div class="col-md-8">
			<div class="name">
				<p class="product-heading ">
					<a href="${productUrl}" title="${productName}">${productName}</a>
				</p>
			</div>
		</div>

		<div class="col-md-4">
			<div class="thumb simple-responsive-banner-component">
				<a href="${productUrl}" title="${productName}">
					<product:productPrimaryImage product="${product}" format="product" />
				</a>
			</div>
		</div>

		<div class="col-md-8">
			<div class="summary">${ycommerce:sanitizeHTML(product.summary)}</div>
		</div>
	</div>
</div>
<product:productListerClassifications product="${product}" />
