<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.String" %>
<%@ attribute name="componentId" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="addToCartBundle" value="/bundle/addEntry" htmlEscape="false"/>
<c:set var="productCode" value="${ycommerce:encodeHTML(product.code)}"/>
<c:set var="productName" value="${ycommerce:encodeHTML(product.name)}"/>
<c:set var="billingTimeName" value="${ycommerce:encodeHTML(product.subscriptionTerm.billingPlan.billingTime.name)}"/>

<li class="product__list--item">
	<div class="row">
		<div class=" col-sm-2 col-md-1">
			<div class="product__list--thumb">
				<product:productPrimaryImage product="${product}" format="thumbnail"/>
			</div>
		</div>
		<div class=" col-sm-10 col-md-11">
			<div class="product__list--name">${productName}</div>

			<div class="product__list--price-panel">
				<div class="product__listing--price">
					<telco-product:productPriceForGuidedSelling product="${product}" productPrice="${product.additionalSpoPriceInBpo}"/>
					<c:if test="${not empty billingTimeName}">
						<div class="price-frequency"> ${billingTimeName} </div>
					</c:if>
				</div>
			</div>

			<c:if test="${not empty product.summary}">
				<div class="product__listing--description padding-top-10">
						${ycommerce:sanitizeHTML(product.summary)}
					<c:if test="${product.disabled}">
				<span class="product-disabled-message">
					<spring:theme code="product.list.cannotPurchaseReason"
									  arguments="${product.disabledMessage}" argumentSeparator="!!!!"/>
				</span>
					</c:if>
				</div>
			</c:if>

			<c:if test="${not product.disabled}">
				<div class="addtocart">
					<div id="actions-container-for-ProductListComponent" class="row">
						<div class="col-md-3 pull-right">
							<form:form action="${addToCartBundle}" method="post">
								<div id="${productCode}" class="select-device">
									<spring:theme code="guidedselling.select.device.select.button" text="Select" var="buttonText"/>
									<button type="submit" class="btn btn-primary btn-block" title="${buttonText}">
											${buttonText}
									</button>
								</div>
								<input type="hidden" name="productCodePost" value="${productCode}"/>
								<input type="hidden" name="quantity" value="1"/>
								<input type="hidden" name="bundleNo" value="${ycommerce:encodeHTML(bundleNo)}"/>
								<input type="hidden" name="bundleTemplateId" value="${ycommerce:encodeHTML(componentId)}"/>
								<input type="hidden" name="removeCurrentProducts" value="true"/>
								<input type="hidden" name="navigation" value="NEXT"/>
							</form:form>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<product:productListerClassifications product="${product}"/>
	<div class="clearfix">&nbsp;</div>
</li>
