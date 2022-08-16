<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="isForceInStock"
		 value="${product.stock.stockLevelStatus.code eq 'inStock' and empty product.stock.stockLevel}"/>
<c:choose>
	<c:when test="${isForceInStock}">
		<c:set var="maxQty" value="FORCE_IN_STOCK"/>
	</c:when>
	<c:otherwise>
		<c:set var="maxQty" value="${product.stock.stockLevel}"/>
	</c:otherwise>
</c:choose>

<c:set var="qtyMinus" value="1"/>

<div class="addtocart-component">
	<c:if test="${empty showAddToCart ? true : showAddToCart}">
		<c:if test="${product.itemType ne 'SubscriptionProduct'}">
			<div class="qty-selector input-group js-qty-selector">
				<span class="input-group-btn">
					<c:if test="${qtyMinus <= 1}">
						<c:set var="disabled" value='disabled'/>
					</c:if>
					<button class="btn btn-default js-qty-selector-minus" type="button" ${disabled}>
						<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
					</button>
				</span>
				<input type="text" maxlength="3" class="form-control js-qty-selector-input" size="1" value="${qtyMinus}"
						 data-max="${maxQty}" data-min="1" name="pdpAddtoCartInput" id="pdpAddtoCartInput"/>
				<span class="input-group-btn">
					<button class="btn btn-default js-qty-selector-plus" type="button">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</button>
				</span>
			</div>
		</c:if>
	</c:if>

	<c:if test="${product.stock.stockLevel gt 0}">
		<c:set var="productStockLevel">${product.stock.stockLevel}&nbsp;
			<spring:theme code="product.variants.in.stock" text="In stock " />
		</c:set>
	</c:if>
	<c:if test="${product.stock.stockLevelStatus.code eq 'lowStock'}">
		<spring:theme code="product.variants.only.left" arguments="${product.stock.stockLevel}" var="productStockLevel"/>
	</c:if>
	<c:if test="${isForceInStock}">
		<spring:theme code="product.variants.available" var="productStockLevel" text="Available"/>
	</c:if>
	<div class="stock-wrapper clearfix">${productStockLevel}</div>
	<div class="actions">
		<c:forEach items="${component.actions}" var="action" varStatus="idx">
			<c:if test="${action.visible}">
				<div class="${ycommerce:encodeHTML(component.uid)}-${ycommerce:encodeHTML(action.uid)}"
					  data-index="${idx.index + 1}" class="">
					<cms:component component="${action}" parentComponent="${component}" evaluateRestriction="true"/>
				</div>
			</c:if>
		</c:forEach>
	</div>
</div>
