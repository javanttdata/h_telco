<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="productAddons" required="true" type="java.util.Set"%>
<%@ attribute name="title" required="true" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component"%>

<spring:htmlEscape defaultHtmlEscape="true" />
	<div class="container subscribe-section">
	<div class="row comp-addons">
	<div class="col-lg">
<c:choose>
	<c:when test="${not empty productAddons}">
			<div class="carousel-wrap">
			<div class="headline">
			<div class="account-section-header"><h4>${ycommerce:encodeHTML(title)}</h4></div></div>
			<div class="js-owl-carousel js-owl-Sub-carousel-addon owl-carousel owl-theme addons-section">
				<c:forEach items="${productAddons}" var="compatibleProduct">
					<spring:url value="${compatibleProduct.url}" var="productUrl" htmlEscape="false" />
					<div class="item">
						<a href="${productUrl}" class="carousel__item" onclick="location.href='${productUrl}'">
								<product:productPrimaryReferenceImage product="${compatibleProduct}" format="product" />
							<c:if test="${component.displayProductTitles}">
								<label class="item-name">${ycommerce:encodeHTML(compatibleProduct.name)}</label>
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
</div>
</div>
</div>