<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="productData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="productType" required="true" type="java.lang.String" %>
<%@ attribute name="processType" required="true" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/servicePlanList/show" var="rolloverPopupUrl" htmlEscape="false"/>
<spring:url value="/cart/add" var="addToCartUrl" htmlEscape="false"/>

<c:set var="pscv" value="${productData.productSpecDescription}"/>
<c:forEach items="${productData.price.productOfferingPrice.children}" var="componentPop">
	<c:if test="${componentPop['class'].simpleName eq 'TmaUsageProdOfferPriceChargeData'}">
		<c:set value="true" var="showUsageChargesRow"/>
	</c:if>
</c:forEach>

<li class="grid_view serviceplan-product  col-lg-3 col-md-4 col-sm-4 col-xs-12">
  <div class="visible-lg value visible-md visible-xs visible-sm service-plan-table">
    <h5 class="p-name">
		${ycommerce:encodeHTML(productData.name)}
    </h5>

    <div class="e-description">

	  <p class="characteristics p-feature">

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
		  <price:price value="${popValue}" currencySymbol="${currencySymbol}" displayFreeForZero="true"/>

	  </p>
    </div>

    <div class="e-description entitlements">
	  <p class="p-feature">
	   <spring:theme code="product.list.viewplans.entitlements" text="Entitlements"/>
	  </p>
	  <p class="characteristics p-feature">
	     <c:if test="${not empty pscv}">
				<c:forEach items="${pscv}" var="description">
						<div class="featureClass">${ycommerce:sanitizeHTML(description)}</div>
				</c:forEach>
		 </c:if>
		 <c:if test="${not empty pscv and not empty productData.description}">
		 </c:if>
		 <p>${ycommerce:sanitizeHTML(productData.description)}</p>
	  </p>
    </div>

	<c:if test="${showUsageChargesRow}">
	  <div class="value">
			<c:if test="${showUsageChargesRow}">
				  <p class=" p-feature">
				    <spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/>
				  </p>
				  <p class="characteristics">
					  <price:usagePopLister compositePop="${productData.price.productOfferingPrice}"/>
				  </p>
			</c:if>
	  </div>
	</c:if>
 </div>

 <div class="visible-lg visible-md visible-xs visible-sm buybutton">
	 <c:if test="${productType eq 'ServicePlan' && productData.hasParentBpos eq true}">
			<div class="modal-dialog service-plans-dialog"
				data-mini-cart-url="${rolloverPopupUrl}"
				data-mini-cart-spo="${productData.code}"
				data-mini-cart-name="<spring:theme code="text.packages" text="Packages"/>"
				data-mini-cart-empty-name="<spring:theme code="popup.cart.empty"/>"
				data-mini-cart-items-text="<spring:theme code="basket.items"/>">
				<button class="btn btn-block btn btn-block btn-primary btn-dark-style js-enable-btn" title="Buy now">
				<spring:theme code="text.buynow" text="Buy Now"/>
				</button>
			</div>
      </c:if>
	  <c:if test="${productData.hasParentBpos eq false}">
			<form:form method="post" class="add_to_cart_form" action="${addToCartUrl}">
				<input type="hidden" name="productCodePost" value="${ycommerce:encodeHTML(productData.code)}"/>
				<input type="hidden" name="processType" value="${processType}"/>
				<button type="submit" class="btn btn-block btn btn-block btn-primary btn-dark-style js-enable-btn">
				<spring:theme code="text.buynow" text="Buy Now"/>
				</button>
			</form:form>
	 </c:if>
 </div>
 <div class="clearfix"></div>
 <div id="addToCartTitle" class="display-none">
	 <div class="add-to-cart-header">
		<div class="headline">
			<span class="headline-text"><spring:theme code="basket.added.to.basket" text="Added to Your Shopping Cart"/></span>
		</div>
	 </div>
 </div>
</li>
