<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:url value="/cart/addSpo" var="addToEntryGroupUrl" />
<c:choose>
	<c:when test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
		<div class="oos-button">
			<spring:theme code="product.grid.outOfStock" />
		</div>
	</c:when>
	<c:otherwise>
		<form:form id="addToEntryGroupForm${fn:escapeXml(product.code)}" action="${addToEntryGroupUrl}" method="POST"
			class="configure_form">
			<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(product.code)}" />
			<input type="hidden" name="rootBpoCode" value="${ycommerce:encodeHTML(bpoCode)}" />
			<input type="hidden" name="parentEntryNumber" value="${parentEntryNumber}" />
			<input type="hidden" name="currentStep" value="${ycommerce:encodeHTML(currentStep)}" />
			<input type="hidden" name="processType" value="${ycommerce:encodeHTML(cgsProcessType)}" />
			
			<c:catch var="errorException">
               <spring:eval expression="searchPageData.currentQuery.query"
                            var="dummyVar"/>
               <input type="hidden" name="q" value="${ycommerce:encodeHTML(searchPageData.currentQuery.query.value)}"/>
            </c:catch>
            <input type="hidden" name="page" value="${ycommerce:encodeHTML(searchPageData.pagination.currentPage)}" />
               
			<c:choose>
				<c:when test="${product.addToCartDisabled}">
					<c:out value="${product.addToCartDisabledMessage}" />
				</c:when>
				<c:otherwise>
					<button type="submit" class="btn btn-primary btn-block glyphicon js-enable-btn" disabled="disabled">
						<spring:theme code="basket.select.product" text="Select" />
					</button>
				</c:otherwise>
			</c:choose>
		</form:form>
	</c:otherwise>
</c:choose>
