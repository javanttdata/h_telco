<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<div class="tabhead">
	<a href="">${ycommerce:encodeHTML(title)}</a> <span class="glyphicon"></span>
</div>
<div class="tabbody">
	<div class="container-lg">
		<div class="row">
			<div class="col-md-6 col-lg-4">
				<div class="tab-container">
					<product:productDetailsTab product="${product}" />
				</div>
			</div>
		</div>
	</div>
</div>
