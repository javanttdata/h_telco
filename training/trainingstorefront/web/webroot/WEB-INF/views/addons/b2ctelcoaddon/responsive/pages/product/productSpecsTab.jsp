<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="telcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="tabhead">
	<a href="">${ycommerce:encodeHTML(title)}</a> <span class="glyphicon"></span>
</div>
<div class="tabbody">
	<div class="container-lg">
		<div class="row">
			<div class="col-md-6 col-lg-4">
				<div class="tab-container">
					<c:if test="${product.itemType eq 'SubscriptionProduct'}">
						<telcoProduct:sbgProductFeatures product="${product}" />
					</c:if>
					<product:productDetailsClassifications product="${product}" />
				</div>
			</div>
		</div>
	</div>
</div>
