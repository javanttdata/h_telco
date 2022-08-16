<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/responsive/storepickup" %>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:set var="qtyMinus" value="1"/>

<spring:url value="${product.url}" var="productUrl" htmlEscape="false"/>
<spring:url value="/cart/add" var="addToCartUrl" htmlEscape="false"/>

<div class="quick-view-popup">

	<div class="product-image">
		<a href="${productUrl}"> <product:productPrimaryImage product="${product}" format="product"/> </a>
	</div>
	<div class="product-details">
		<div class="name">
			<a href="${productUrl}">${ycommerce:encodeHTML(product.name)}</a>
		</div>
		<product:productReviewSummary product="${product}" showLinks="false" starsClass="quick-view-stars"/>
		<div class="summary">${ycommerce:sanitizeHTML(product.summary)}</div>
		<telco-product:potentialPromotions product="${product}"/>
		<div class="price"><format:fromPrice priceData="${product.price}"/></div>
	</div>

	<div class="addtocart-component">
		<product:quickViewProductVariantSelector/>

		<form:form method="post" class="add_to_cart_form" action="${addToCartUrl}">
			<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(product.code)}"/>
			<input type="hidden" name="processType" value="DEVICE_ONLY"/>

			<c:if test="${empty quickViewShowAddToCart ? true : quickViewShowAddToCart}">

				<div class="qty-selector input-group js-qty-selector">
					<span class="input-group-btn">
						<button class="btn btn-primary js-qty-selector-minus" type="button" <c:if test="${qtyMinus <= 1}"><c:out
								  value="disabled='disabled'"/></c:if>>
							<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
						</button>
					</span>
					<input type="text" maxlength="3" class="form-control js-qty-selector-input" size="1" value="${qtyMinus}"
							 data-max="${product.stock.stockLevel}"
							 data-min="1" id="qty" name="qty"/>
					<span class="input-group-btn">
						<button class="btn btn-primary js-qty-selector-plus" type="button">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</span>
				</div>

				<c:if test="${product.stock.stockLevel gt 0}">
					<c:set var="productStockLevel">${product.stock.stockLevel}&nbsp;
						<spring:theme code="product.variants.in.stock" text="In Stock"/>
					</c:set>
				</c:if>
				<c:if test="${product.stock.stockLevelStatus.code eq 'lowStock'}">
					<c:set var="productStockLevel">
						<spring:theme code="product.variants.only.left" arguments="${product.stock.stockLevel}"/>
					</c:set>
				</c:if>
				<c:if test="${product.stock.stockLevelStatus.code eq 'inStock' and empty product.stock.stockLevel}">
					<c:set var="productStockLevel">
						<spring:theme code="product.variants.available" text="available online"/>
					</c:set>
				</c:if>
				<div class="stock-status">${productStockLevel}</div>
				<c:choose>
					<c:when test="${product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
						<button id="addToCartButton" type="submit"
								  class="btn btn-primary btn-block js-add-to-cart js-enable-btn btn-icon glyphicon-shopping-cart"
								  disabled="disabled">
							<spring:theme code="basket.add.to.basket" text="Add To Basket"/>
						</button>
					</c:when>
					<c:otherwise>
						<button type="button"
								  class="btn btn-primary btn-block js-add-to-cart btn-icon glyphicon-shopping-cart outOfStock"
								  disabled="disabled">
							<spring:theme code="product.variants.out.of.stock" text="Out of Stock"/>
						</button>

					</c:otherwise>
				</c:choose>
			</c:if>
		</form:form>
	</div>
</div>
