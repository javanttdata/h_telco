<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleBoxEntry" required="true" type="de.hybris.platform.b2ctelcofacades.data.BundleBoxEntryData" %>
<%@ attribute name="bundleBoxEntryCounter" required="true" type="java.lang.Integer" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.String" %>
<%@ attribute name="bundleTemplateId" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:url var="addToCart" value="/bundle/addEntry" htmlEscape="false"/>
<spring:url var="removeCartEntryAction" value="/bundle/removeEntry" htmlEscape="false"/>
<spring:theme var="removeFromCartText" code="basket.icon.cart.remove" text="Remove"/>

<c:if test="${not bundleBoxEntry.selected and not bundleBoxEntry.disabled}">
	<c:set value="remove_selected" var="additionalCssClass"/>
</c:if>
<c:if test="${bundleBoxEntry.selected}">
	<c:set value="selected" var="additionalCssClass"/>
</c:if>
<c:set var="productCode" value="${ycommerce:encodeHTML(bundleBoxEntry.orderEntry.product.code)}"/>
<c:set var="uniqueFormId" value="${productCode}${bundleBoxEntry.orderEntry.entryNumber}"/>

<div class="row bundle-box-entry ${additionalCssClass}">
	<div class="col-xs-12 col-sm-6 col-md-8">
		<h3>${ycommerce:encodeHTML(bundleBoxEntry.product.name)}</h3>
		<p class="description">${ycommerce:sanitizeHTML(bundleBoxEntry.product.description)}</p>
	</div>

	<guidedselling:bundleBoxEntryPrice bundleBoxEntry="${bundleBoxEntry}"
												  bundleNo="${bundleNo}"
												  bundleTemplateId="${bundleTemplateId}"/>

	<div class="col-xs-4 col-sm-3 col-md-2 bundle-entry-button">
		<form:form action="${addToCart}" method="post">
			<input type="hidden" name="quantity" value="1"/>
			<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(bundleBoxEntry.product.code)}"/>
			<input type="hidden" name="bundleNo" value="${ycommerce:encodeHTML(bundleNo)}"/>
			<input type="hidden" name="bundleTemplateId" value="${ycommerce:encodeHTML(bundleTemplateId)}"/>
			<input type="hidden" name="navigation" value="CURRENT"/>

			<spring:theme var="addToCartText" code="basket.add.to.basket" text="Add To Cart"/>
			<c:if test="${not bundleBoxEntry.selected and not bundleBoxEntry.disabled}">
				<button type="submit" class="btn btn-block btn-primary" title="${addToCartText}">
					<span class="btn-cart-glyphicon"></span>
					<span class="btn-cart-text">${addToCartText}</span>
				</button>
			</c:if>
			<c:if test="${not bundleBoxEntry.selected and bundleBoxEntry.disabled}">
				<div class="telco-tooltip-container">
					<button type="submit" class="btn btn-block btn-default" disabled="disabled" title="${addToCartText}">
						<span class="btn-cart-glyphicon"></span>
						<span class="btn-cart-text">${addToCartText}</span>
					</button>
					<guidedselling:bundleDisabledMessage bundleDisabledMessage="${bundleBoxEntry.disabledMessage}"/>
				</div>
			</c:if>
		</form:form>
		<c:if test="${bundleBoxEntry.selected and bundleBoxEntry.removable}">
			<form:form id="updateCartForm${uniqueFormId}" action="${removeCartEntryAction}" method="post">
				<input type="hidden" name="entryNumber" value="${bundleBoxEntry.orderEntry.entryNumber}"/>
				<input type="hidden" name="productCode" value="${productCode}"/>
				<input type="hidden" name="initialQuantity" value="${bundleBoxEntry.orderEntry.quantity}"/>
				<input type="hidden" name="bundleNo" value="${ycommerce:encodeHTML(bundleNo)}"/>
				<input type="hidden" name="componentId" value="${ycommerce:encodeHTML(bundleTemplateId)}"/>
				<input type="hidden" name="quantity" value="0"/>
				<button type="submit" class="btn btn-block btn-link" id="REMOVE_${productCode}"
						  title="${removeFromCartText}">
						${removeFromCartText}
				</button>
			</form:form>
		</c:if>
		<c:if test="${bundleBoxEntry.selected and not bundleBoxEntry.removable}">
			<div class="telco-tooltip-container">
				<button type="submit" class="btn btn-block btn-default" id="REMOVE_${productCode}" disabled="disabled"
						  title="${removeFromCartText}">
						${removeFromCartText}
				</button>
				<guidedselling:bundleDisabledMessage bundleDisabledMessage="${bundleBoxEntry.disabledMessage}"/>
			</div>
		</c:if>
	</div>
</div>
