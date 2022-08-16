<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="showTax" required="false" type="java.lang.Boolean"%>
<%@ attribute name="showTaxEstimate" required="false" type="java.lang.Boolean"%>
<%@ attribute name="subtotalsCssClasses" required="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<div class="subtotals ${subtotalsCssClasses}">
	<div class="subtotal">
		<spring:theme code="entry.payoncheckout" text="Pay On Checkout:"/>
		<span>
				<format:price priceData="${cartData.totalPrice}"/>
			</span>
	</div>

	<c:if test="${cartData.totalDiscounts.value > 0}">
		<div class="subtotals__item--state-discount">
			<spring:theme code="text.account.order.discount" text="Discount:" />
			<span>
				<format:price priceData="${cartData.totalDiscounts}" displayNegationForDiscount="true" />
			</span>
		</div>
	</c:if>
	<c:if test="${cartData.net && cartData.totalTax.value > 0 && showTax}">
		<div class="tax">
			<spring:theme code="basket.page.totals.netTax" text="Tax:" />
			<span>
				<format:price priceData="${cartData.totalTax}" />
			</span>
		</div>
	</c:if>
	<c:if test="${not cartData.net}">
		<div class="realTotals">
			<p>
				<spring:theme code="basket.page.totals.grossTax.taxInclusive" text="Tax Inc." />
			</p>
		</div>
	</c:if>
	<c:if test="${cartData.net && not showTax }">
		<div class="realTotals">
			<p>
				<spring:theme code="basket.page.totals.noNetTax" text="*No taxes are included in the total" />
			</p>
		</div>
	</c:if>
</div>

