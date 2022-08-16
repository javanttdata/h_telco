<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:if test="${not empty product.potentialPromotions}">
	<div class="bundle">
		<p>
			<c:choose>
				<c:when test="${not empty product.potentialPromotions[0].couldFireMessages}">
					${ycommerce:encodeHTML(product.potentialPromotions[0].couldFireMessages[0])}
				</c:when>
				<c:otherwise>
					${ycommerce:encodeHTML(product.potentialPromotions[0].description)}
				</c:otherwise>
			</c:choose>
		</p>
	</div>
</c:if>
