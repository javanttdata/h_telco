<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:url value="${product.url}" var="productUrl" htmlEscape="true" />
<c:set var="product" value="${product}" scope="request" />
<c:set value="${not empty product.potentialPromotions}" var="hasPromotion" />
<c:set var="isAnyProductSelected" value="${dashboard.isAnyProductSelected }" />
<li class="product__list--item list_view">
	<div class="row">
		<div class="col-sm-12">
			<c:choose>
				<c:when test="${empty parentEntryNumber}">
					<a class="product__list--thumb" href="${productUrl}" title="${ycommerce:encodeHTML(product.name)}">
						<product:productPrimaryImage product="${product}" format="thumbnail" />
					</a>
					<a class="product__list--name" href="${productUrl}">${ycommerce:sanitizeHTML(product.name)}</a>
				</c:when>
				<c:otherwise>
					<a class="product__list--thumb" title="${ycommerce:encodeHTML(product.name)}">
						<product:productPrimaryImage product="${product}" format="thumbnail" />
					</a>
					<a class="product__list--name">${ycommerce:sanitizeHTML(product.name)}</a>
				</c:otherwise>
			</c:choose>
			<div class="product__list--price-panel">
				<div class="product__listing--price">
					<div class="product-price pad-top-10">
						<price:oneTimePopLister compositePop="${product.prices[0].productOfferingPrice}"/>
                        <price:recurringPopLister compositePop="${product.prices[0].productOfferingPrice}"/>
					</div>
				</div>
			</div>
			<c:if test="${not empty product.summary}">
				<div class="product__listing--description">${ycommerce:sanitizeHTML(product.summary)}
					<c:if test="${product.addToCartDisabled}">
						<span class="product-disabled-message">
							<spring:theme code="product.list.cannotPurchaseReason" arguments="${product.addToCartDisabledMessage}"
								argumentSeparator="!!!!" />
						</span>
					</c:if>
				</div>
			</c:if>
			
		</div>
	</div>
	<div class="row">
		<div class="col-sm-9">
			<product:productListerClassifications product="${product}" />
		</div>
		<c:forEach items="${feature.actions}" var="action" varStatus="idx">
			<c:choose>
				<c:when
					test="${ (isAnyProductSelected == false) &&  (product.soldIndividually == false)}">
					<span class="product-disabled-message"> <spring:theme
							code="product.cannotPurchaseIndividiually"/>
					</span>
				</c:when>
				<c:otherwise>
					<div class="col-sm-3">
						<div
							class="${ycommerce:encodeHTML(feature.uid)}-${ycommerce:encodeHTML(action.uid)}"
							data-index="${idx.index + 1}">
							<div class="addtocart">
								<div
									id="actions-container-for-${ycommerce:encodeHTML(feature.uid)}">
									<cms:component component="${action}"
										parentComponent="${feature}" evaluateRestriction="true" />
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
</li>
