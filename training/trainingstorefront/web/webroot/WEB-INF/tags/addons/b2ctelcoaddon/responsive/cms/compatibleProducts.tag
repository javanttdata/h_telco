<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="productAccessories" required="true" type="java.util.List"%>
<%@ attribute name="title" required="true" type="java.lang.String"%>
<%@ attribute name="maximumNumberProducts" required="true" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component"%>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:theme code="popup.quick.view.select" text="Select Options" var="quickViewText" />
<c:choose>
	<c:when test="${not empty productAccessories and maximumNumberProducts > 0}">
		<div class="carousel-component">
			<div class="headline">${ycommerce:encodeHTML(title)}</div>
			<div class="carousel js-owl-carousel js-owl-lazy-reference js-owl-carousel-reference">
				<c:forEach end="${component.maximumNumberProducts}" items="${productAccessories}" var="compatibleProduct">
					<spring:url value="${compatibleProduct.url}/quickView" var="productUrl" htmlEscape="false" />
					<div class="item">
						<a href="${productUrl}" class="js-reference-item" data-quickview-title="${quickViewText}">
							<div class="thumb">
								<product:productPrimaryReferenceImage product="${compatibleProduct}" format="product" />
							</div>
							<c:if test="${component.displayProductTitles}">
								<div class="item-name">${ycommerce:encodeHTML(compatibleProduct.name)}</div>
							</c:if>
							<c:if test="${component.displayProductPrices}">
								<div class="priceContainer">
									<price:payNowPop priceData="${compatibleProduct.price}" />
								</div>
							</c:if>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<component:emptyComponent />
	</c:otherwise>
</c:choose>