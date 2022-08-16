<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="orderEntryTotalPrice" required="true" type="de.hybris.platform.commercefacades.product.data.PriceData"%>
<%@ attribute name="orderEntryBasePrice" required="true"  type="de.hybris.platform.commercefacades.product.data.PriceData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<c:choose>
	<c:when test="${not empty orderEntryTotalPrice}">
		<c:if test="${(orderEntryBasePrice.value - orderEntryTotalPrice.value) > 0}">
			<del>
				<format:price priceData="${orderEntryBasePrice}" displayFreeForZero="false" />
			</del>
		</c:if>
		<format:price priceData="${orderEntryTotalPrice}" displayFreeForZero="false" />
	</c:when>
	<c:otherwise>
		&mdash;
	</c:otherwise>
</c:choose>
