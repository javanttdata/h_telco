<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/nav"%>
<%@ taglib prefix="store-pickup" tagdir="/WEB-INF/tags/responsive/storepickup"%>
<%@ taglib prefix="telco-product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/bpoguidedselling"%>

<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}"
	searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"
	numberPagesShown="${numberPagesShown}" />
<div class="tab-content">
	<div class="tab-pane" id="show_list">
		<div class="product__listing product__list disable_a_href prod_list_view">
			<div class="product__listing product__list">
				<c:forEach items="${searchPageData.results}" var="product">
					<telco-product:productOfferingListerListItem product="${product}" />
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="tab-pane" id="show_grid">
		<div class="product__listing product_wrapper product__list disable_a_href prod_grid_view">
			<c:forEach items="${searchPageData.results}" var="product">
				<telco-product:productOfferingListerGridItem product="${product}" />
			</c:forEach>
		</div>
	</div>
</div>
<div id="addToCartTitle" class="display-none">
	<div class="add-to-cart-header">
		<div class="headline">
			<span class="headline-text">
				<spring:theme code="basket.added.to.basket" text="Added to Your Shopping Cart" />
			</span>
		</div>
	</div>
</div>
<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}"
	searchPageData="${searchPageData}" searchUrl="${searchPageData.currentQuery.url}"
	numberPagesShown="${numberPagesShown}" />
<store-pickup:pickupStorePopup />