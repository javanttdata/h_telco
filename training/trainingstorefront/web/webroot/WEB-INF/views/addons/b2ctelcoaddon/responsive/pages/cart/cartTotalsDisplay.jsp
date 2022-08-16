<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart"%>

<div class="row">
	<div class="col-xs-12 col-md-5 col-lg-6"></div>
	<div class="col-xs-12 col-md-7 col-lg-6">
		<div class="cart-totals">
			<cart:cartTotals cartData="${cartData}" showTaxEstimate="${taxEstimationEnabled}" />
		</div>
	</div>
</div>
