<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="store-pickup" tagdir="/WEB-INF/tags/responsive/storepickup"%>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:set value="${ycommerce:encodeHTML(product.code)}" var="productCode" />
<product:addToCartTitle />
<div class="product-details page-title">
	<div class="name">
		${ycommerce:encodeHTML(product.name)}
		<span class="sku">
			<spring:theme code="product.device.id" text="ID" />
		</span>
		<span class="code">${productCode}</span>
	</div>
	<product:productReviewSummary product="${product}" showLinks="true" />
</div>
<div class="row">
	<div class="col-xs-10 col-xs-push-1 col-sm-6 col-sm-push-0 col-lg-4">
		<product:productImagePanel galleryImages="${galleryImages}" />
	</div>
	<div class="clearfix hidden-sm hidden-md hidden-lg"></div>
	<div class="col-sm-6 col-lg-8">
		<div class="product-main-info">
			<div class="row">
				<div class="col-lg-6">
					<div class="product-details">
						<product:productPromotionSection product="${product}" />
						<cms:pageSlot position="VariantSelector" var="component" element="div" class="page-details-variants-select">
							<cms:component component="${component}" element="div" class="yComponentWrapper page-details-variants-select-component" />
						</cms:pageSlot>
						<c:if test="${not empty product.summary}">
							<div class="description">${ycommerce:sanitizeHTML(product.summary)}</div>
						</c:if>
						<c:if test="${product.purchasable and product.stock.stockLevel le 0}">
							<spring:theme code="product.variants.out.of.stock" text="Out of Stock" />
						</c:if>
						<c:if test="${product.stock.stockLevel gt 0}">
							${ycommerce:sanitizeHTML(product.stock.stockLevel)}&nbsp;<spring:theme code="product.variants.in.stock" text="In Stock" />
						</c:if>
						<c:if test="${product.stock.stockLevelStatus.code eq 'inStock' and product.stock.stockLevel le 0}">
							<spring:theme code="product.variants.available" text="available online" />
						</c:if>
						<br/><br/>
						<cms:pageSlot position="ProcessTypeSelection" var="component" element="div">
							<cms:component component="${component}" element="div" class="yComponentWrapper" />
						</cms:pageSlot>
						<cms:pageSlot position="SubscriptionSelection" var="component" element="div">
							<cms:component component="${component}" element="div" class="yComponentWrapper" />
						</cms:pageSlot>
					</div>
				</div>
				<div class="col-sm-12 col-md-push-1 col-md-10 col-lg-push-0 col-lg-6">
					<c:if test="${product.soldIndividually}">
						<telco-product:deviceOnlyPricePanel product="${product}" />
						<div class="AddToCart-PickUpInStoreAction">
							<cms:pageSlot position="DevicePickupInStore" var="component" element="div">
								<cms:component component="${component}" element="div"  />
							</cms:pageSlot>
						</div>
					</c:if>
					<c:if test="${not empty product.bundleTabs}">
						<div class="view-all-plans-link">
							<spring:theme code="product.device.viewAllPlans" text="View All Plans" var="viewAllPlansText" />
							<a href="#view-plans" title="${viewAllPlansText}">${viewAllPlansText}</a>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
