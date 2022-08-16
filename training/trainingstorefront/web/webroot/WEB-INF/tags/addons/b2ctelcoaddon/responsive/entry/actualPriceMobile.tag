<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="orderEntryTotalPrice" required="true" type="de.hybris.platform.commercefacades.product.data.PriceData"%>
<%@ attribute name="orderEntryBasePrice" required="true"  type="de.hybris.platform.commercefacades.product.data.PriceData"%>
<%@ attribute name="orderEntryBillingName" required="true" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>

<c:choose>
	<c:when test="${not empty orderEntryTotalPrice}">
		<table class="price-table-mobile">
			<tr>
				<td>${orderEntryBillingName}</td>
				<c:if test="${(orderEntryBasePrice.value - orderEntryTotalPrice.value) > 0}">
					<td>
						<del>
							<format:price priceData="${orderEntryBasePrice}" displayFreeForZero="true" />
						</del>
					</td>
				</c:if>
				<td>
					<format:price priceData="${orderEntryTotalPrice}" displayFreeForZero="false" />
				</td>
			</tr>
		</table>
	</c:when>
	<c:otherwise>
		<span class="hidden-xs hidden-sm">&mdash;</span>
	</c:otherwise>
</c:choose>
