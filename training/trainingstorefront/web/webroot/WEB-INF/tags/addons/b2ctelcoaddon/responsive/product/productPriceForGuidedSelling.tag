<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="productPrice" required="true" type="de.hybris.platform.commercefacades.product.data.PriceData" %>

<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set value="true" var="displayFreeForZero"/>
<c:if test="${productPrice.value < product.price.value}">
	<div class="product-price">
		<format:price priceData="${productPrice}" displayFreeForZero="${displayFreeForZero}"/>
	</div>
	<del><format:price priceData="${product.price}"/></del>

</c:if>
<c:if test="${productPrice.value eq null or productPrice.value >= product.price.value}">
	<div class="product-price padding-top-10">
		<format:price priceData="${product.price}" displayFreeForZero="${displayFreeForZero}"/>
	</div>
</c:if>
