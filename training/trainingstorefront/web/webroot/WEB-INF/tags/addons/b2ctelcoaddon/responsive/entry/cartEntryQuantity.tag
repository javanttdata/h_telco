<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="entry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/cart/update" var="cartUpdateFormAction" htmlEscape="false" />

<c:if test="${not empty entry.product}">
	<div class="item__quantity">
		<form:form id="updateCartForm${entry.entryNumber}" action="${cartUpdateFormAction}" method="post"
			modelAttribute="updateQuantityForm${entry.entryNumber}"
			data-cart='{"cartCode" : "${ycommerce:encodeHTML(cartData.code)}",
		"productPostPrice":"${entry.basePrice.value}","productName":"${ycommerce:encodeHTML(entry.product.name)}"}'>
			<input type="hidden" name="entryNumber" value="${entry.entryNumber}" />
			<input type="hidden" name="productCode" value="${ycommerce:encodeHTML(entry.product.code)}" />
			<input type="hidden" name="initialQuantity" value="${entry.quantity}" />
			<c:choose>
				<c:when test="${not entry.updateable}">
					<input type="hidden" name="quantity" class="item__quantity form-control" value="${entry.quantity}"/>
					<input type="text" disabled="${not entry.updateable}" class="form-control js-update-entry-quantity-input"
						   value="${entry.quantity}"/>
				</c:when>
				<c:otherwise>
					<form:label cssClass="skip" path="quantity" for="quantity${entry.entryNumber}">
						<spring:theme code="basket.page.quantity" text="Quantity" />
					</form:label>
					<form:input disabled="${not entry.updateable}" type="text" size="1" id="quantity${entry.entryNumber}"
						class="item__quantity form-control js-update-entry-quantity-input" path="quantity" />
				</c:otherwise>
			</c:choose>
		</form:form>
	</div>
</c:if>
