<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="store-pickup" tagdir="/WEB-INF/tags/responsive/storepickup"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart"%>

<%--@elvariable id="groupedCartEntries" type="java.util.Map<de.hybris.platform.commercefacades.order.data.OrderEntryData, java.util.List<de.hybris.platform.commercefacades.order.data.OrderEntryData>>"--%>
<spring:htmlEscape defaultHtmlEscape="true" />

<ul class="item__list item__list__cart">
	<li class="hidden-xs hidden-sm">
		<ul class="item__list--header">
			<li class="item__image"></li>
			<li class="item__info">
				<spring:theme code="basket.page.item" text="Item (style number)" />
			</li>
			<li class="item__quantity">
				<spring:theme code="basket.page.qty" text="Qty" />
			</li>
			<li class="item__delivery">
				<spring:theme code="basket.page.delivery" text="Delivery" />
			</li>
				<li class="item__price">
					<spring:theme code="basket.page.price" text="Price"/>
				</li>
			<li class="item__remove"></li>
		</ul>
	</li>
	<c:forEach items="${groupedCartEntries.entrySet()}" var="entry" >
		<cart:rootEntryGroup cartData="${cartData}"  entry="${entry}"/>
		<p></p>
	</c:forEach>
</ul>

<product:productOrderFormJQueryTemplates />
<store-pickup:pickupStorePopup />
