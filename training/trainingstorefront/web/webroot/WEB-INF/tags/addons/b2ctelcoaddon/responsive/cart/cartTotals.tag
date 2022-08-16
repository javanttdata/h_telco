<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>
<%@ attribute name="showTaxEstimate" required="false" type="java.lang.Boolean"%>
<%@ attribute name="showTax" required="false" type="java.lang.Boolean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<table id="order-totals">
	<thead>
        <tr>
            <th>&nbsp;</th>
			<spring:theme code="product.payNow" text="Pay Now" var="billingTimeText"/>
                <th scope="col">${billingTimeText}</th>
        </tr>
	</thead>
	<tbody>
		<tr>
			<td class="cart-bundle-package"><spring:theme code="basket.page.totals.subtotal" text="Subtotal:"/></td>
				<td><format:price priceData="${cartData.subTotal}" /></td>
		</tr>

		<tr>
			<td class="cart-bundle-package"><spring:theme code="basket.page.totals.savings" text="Savings:"/></td>
				<td><format:price priceData="${cartData.totalDiscounts}" /></td>
		</tr>
	
		<tr>
			<td class="cart-bundle-package"><spring:theme code="basket.page.totals.delivery" text="Delivery:"/></td>
				<td><format:price priceData="${cartData.deliveryCost}" displayFreeForZero="TRUE" /></td>
		</tr>
	
		<tr>
			<td class="cart-bundle-package"><spring:theme code="basket.page.totals.grossTax.noArgs" text="Tax:"/></td>
				<td><format:price priceData="${cartData.totalTax}" displayFreeForZero="TRUE" /></td>
		</tr>
	
        <tr class="cartTotal">
            <td class="cart-bundle-package"></td>
                <td><format:price priceData="${cartData.totalPrice}" /></td>
        </tr>

		<cart:taxExtimate cartData="${cartData}" showTaxEstimate="${showTaxEstimate}" />
	</tbody>
</table>
