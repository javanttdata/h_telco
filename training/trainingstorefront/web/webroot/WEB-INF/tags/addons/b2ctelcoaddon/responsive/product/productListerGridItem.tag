<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="productData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="${productData.url}" var="productDataUrl" htmlEscape="false"/>

<c:set var="productName" value="${ycommerce:encodeHTML(productData.name)}"/>

<li class="grid_view product__list--items col-lg-3 col-md-4 col-sm-4">
	<div class="full-grid" onclick="location.href='${productDataUrl}'">
		<div class="prod-wrapper">
			<div class="prod-img">
				<a class="product__list--thumb" href="${productDataUrl}" title="${productName}">
					<product:productPrimaryImage product="${productData}" format="thumbnail"/>
				</a>
			</div>
			<div class="prod-content">
				<strong class="product__list--name" href="${productDataUrl}" title="${productName}">${productName}</strong>
				<div class="rating">
					<div class="rating-stars js-ratingCalc" data-rating='{"rating":"${productData.averageRating}","total":5}'>
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
				<div class="product__listing--price">

					<c:set var="otcPriceValue" value="0"/>
					<c:set var="rcPriceValue" value="0"/>
					<c:set var="currencySymbol" value=""/>

					<c:forEach var="componentPop" items="${productData.price.productOfferingPrice.children}">
						<c:if test="${componentPop['class'].simpleName eq 'TmaOneTimeProdOfferPriceChargeData'}">
							<c:if test="${componentPop.priceEvent.code eq 'paynow'}">
								<c:set var="otcPriceValue" value="${otcPriceValue + componentPop.value}"/>
								<c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
							</c:if>
						</c:if>

						<c:if test="${componentPop['class'].simpleName eq 'TmaRecurringProdOfferPriceChargeData'}">
							<c:set var="billingTime" value="${componentPop.priceEvent.name}"/>
							<c:set var="cycleStart" value="${componentPop.cycleStart}"/>

							<c:if test="${empty cycleStart or cycleStart eq 1 or cycleStart eq 0}">
								<c:set var="rcPriceValue" value="${componentPop.value}"/>
								<c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
							</c:if>
						</c:if>
					</c:forEach>

					<spring:theme code="entry.payoncheckout" text="Pay On Checkout:" var="priceMessage"/>
					<c:set var="popValue" value="${otcPriceValue}"/>
					<c:if test="${rcPriceValue > 0}">
						<c:set var="priceMessage" value="${billingTime}"/>
						<c:set var="popValue" value="${rcPriceValue}"/>
					</c:if>

					<div class="pay">${ycommerce:encodeHTML(priceMessage)}</div>

					<div class="product-price">
						<price:price value="${popValue}" currencySymbol="${currencySymbol}" displayFreeForZero="true"/>
					</div>
					<c:if test="${productData.stock.stockLevelStatus.code eq 'outOfStock' }">
						<spring:theme code="text.addToCart.outOfStock" text="Out of Stock"/>
					</c:if>
				</div>
			</div>

			<table class="tma-variant-colors-category-grid" align="center">
				<c:choose>
					<c:when test="${not empty productData.colors}">
						<tr>
							<c:forEach items="${productData.colors}" var="color">
								<td>
									<span style="background-color: ${color};"></span>
								</td>
							</c:forEach>
						</tr>
					</c:when>
				</c:choose>
			</table>

			<div class="price-details">
				<a class="btn btn-primary add-cart-btn" href="${productDataUrl}">
					<spring:theme code="text.buynow" text="Buy Now"/>
				</a>
			</div>
		</div>
	</div>
</li>
