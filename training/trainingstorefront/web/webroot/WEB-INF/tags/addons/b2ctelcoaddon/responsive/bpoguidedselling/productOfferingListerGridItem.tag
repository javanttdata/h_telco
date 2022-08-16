<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:url value="${product.url}" var="productUrl" htmlEscape="true"/>
<c:set var="product" value="${product}" scope="request"/>
<c:set value="${not empty product.potentialPromotions}" var="hasPromotion"/>
<c:set var="isAnyProductSelected" value="${dashboard.isAnyProductSelected }"/>
<li class="grid_view serviceplan-product col-lg-3 col-md-4 col-sm-4 col-xs-12">
  <div class="visible-lg value visible-md visible-xs visible-sm service-plan-table">
    <div class="e-description">
		<c:choose>
				<c:when test="${empty parentEntryNumber}">
					<a href="${productUrl}" title="${ycommerce:encodeHTML(product.name)}">
						<product:productPrimaryImage product="${product}" format="thumbnail"/>
					</a>
				</c:when>
				<c:otherwise>
					<a  title="${ycommerce:encodeHTML(product.name)}">
						<product:productPrimaryImage product="${product}" format="thumbnail"/>
					</a>
				</c:otherwise>
			</c:choose>
    </div>
    <div class="e-description entitlements">
	  <p class="characteristics p-feature">
			<c:choose>
				<c:when test="${empty parentEntryNumber}">
					<a class="product__list--name" href="${productUrl}"
						title="${ycommerce:encodeHTML(product.name)}">${ycommerce:encodeHTML(product.name)}</a>
				</c:when>
				<c:otherwise>
					<a class="product__list--name"
						title="${ycommerce:encodeHTML(product.name)}">${ycommerce:encodeHTML(product.name)}</a>
				</c:otherwise>
			</c:choose>
	  </p>
    </div>
	<div class="value">	
	  <p class=" p-feature">
		 <p>${ycommerce:encodeHTML(product.summary)}</p>
			<div class="rating">
				<div class="rating-stars js-ratingCalc ${starsClass}" data-rating='{"rating":"${product.averageRating}","total":5}'>
					<div class="greyStars">
						<c:forEach begin="1" end="5">
							<span class="glyphicon glyphicon-star"></span>
						</c:forEach>
					</div>
					<div class="greenStars js-greenStars">
						<c:forEach begin="1" end="5">
							<span class="glyphicon glyphicon-star active"></span>
						</c:forEach>
					</div>
				</div>
			</div>
	     </p>
		 <p class="characteristics">
			  <div class="product-price pad-top-10">
					<price:oneTimePopLister compositePop="${product.prices[0].productOfferingPrice}"/>
					<price:recurringPopLister compositePop="${product.prices[0].productOfferingPrice}"/>
			  </div>
		 </p>		
	</div>
 </div>
 <div class="visible-lg visible-md visible-xs visible-sm buybutton">
		<c:forEach items="${feature.actions}" var="action" varStatus="idx">
			<c:if test="${action.visible}">
				<div class="${ycommerce:encodeHTML(feature.uid)}-${ycommerce:encodeHTML(action.uid)}" data-index="${idx.index + 1}">
					<c:choose>
						<c:when test="${product.addToCartDisabled}">
							<span class="product-disabled-message">
								<spring:theme code="product.list.cannotPurchaseReason" arguments="${product.addToCartDisabledMessage}"
												  argumentSeparator="!!!!"/>
							</span>
						</c:when>
						<c:when test="${ (isAnyProductSelected == false) &&  (product.soldIndividually == false)}">
							<span class="product-disabled-message">
								<spring:theme code="product.cannotPurchaseIndividiually"/>
							</span>
						</c:when>
						<c:otherwise>
							<div class="addtocart">
								<div id="actions-container-for-${ycommerce:encodeHTML(feature.uid)}" class="row">
									<div class="col-xs-12">
										<cms:component component="${action}" parentComponent="${feature}" evaluateRestriction="true"/>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</c:forEach>
 </div>
 <div class="clearfix"></div>
</li>
