<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="productData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="${productData.url}" var="productUrl" htmlEscape="false"/>

<li class="product__list--item list_view">
	<div class="row">
		<div class=" col-sm-2 col-md-1">
			<a class="product__list--thumb" href="${productUrl}" title="${ycommerce:encodeHTML(productData.name)}">
				<product:productPrimaryImage product="${productData}" format="thumbnail"/>
			</a>
		</div>
		<div class=" col-sm-10 col-md-11">
			<a class="product__list--name" href="${productUrl}" title="${ycommerce:encodeHTML(productData.name)}">
				${ycommerce:encodeHTML(productData.name)}
			</a>

			<c:if test="${not empty productData.colors}">
				<div class="tma-variant-colors-category-list">
					<table align="left">
						<tr>
							<c:forEach items="${productData.colors}" var="color">
								<td>
									<span style="background-color: ${color};"></span>
								</td>
							</c:forEach>
						</tr>
					</table>
				</div>
			</c:if>

			<div class="product__list--price-panel">
				<div class="product__listing--price">
					<div class="price-label">
						<spring:theme code="text.withinpackage" text="within specific package"/>
					</div>
					<ul class="price-block-list">
						<li class="center-right">

							<span class="center-line">
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
								        <c:set var="cycleStart" value="${componentPop.cycleStart}"/>

								        <c:if test="${empty cycleStart or cycleStart eq 1 or cycleStart eq 0}">
									        <c:set var="rcPriceValue" value="${componentPop.value}"/>
									        <c:set var="currencySymbol" value="${componentPop.currency.symbol}"/>
								        </c:if>
							        </c:if>
						        </c:forEach>

						        <c:set var="popValue" value="${otcPriceValue}"/>
						        <c:if test="${rcPriceValue > 0}">
							        <c:set var="popValue" value="${rcPriceValue}"/>
						        </c:if>

						        <price:price value="${popValue}" currencySymbol="${currencySymbol}" displayFreeForZero="true"/>
							</span>

							<span><spring:theme code="text.upfront" text="up front"/></span>
						</li>
					</ul>

					<c:if test="${productData.stock.stockLevelStatus.code eq 'outOfStock' }">
						<spring:theme code="text.addToCart.outOfStock" text="Out of Stock"/>
					</c:if>
				</div>
			</div>

			<c:choose>
				<c:when test="${not empty productData.summary}">
					<div class="product__listing--description pad-top-10">${ycommerce:sanitizeHTML(productData.summary)}</div>
				</c:when>
				<c:otherwise>
					<br/><br/>
				</c:otherwise>
			</c:choose>

			<telco-product:productListerClassifications product="${productData}"/>
		</div>
		<div class="clearfix">&nbsp;</div>
	</div>
</li>
