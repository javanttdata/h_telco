<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/responsive/common" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<%--@elvariable id="pageTitle" type="java.lang.String"--%>
<%--@elvariable id="product" type="de.hybris.platform.commercefacades.product.data.ProductData"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<div class="prod-add-to-cart">
	<div class="tabs js-tabs tabs-responsive plan-tab-container">
		<div class="tabbody tma-service-plans">
			<table class="sub-tabbody-table">
				<tr>
					<th>&nbsp;</th>
					<th>${ycommerce:encodeHTML(product.name)}</th>
				</tr>
				<tr>
					<td><spring:theme code="product.list.viewaddon.description" text="Description"/></td>
					<td>${product.description}</td>
				</tr>
				<tr>
					<td>
						<spring:theme code="product.list.viewplans.price" text="Price"/>
					</td>
					<td>
						<guidedselling:subscriptionPricesLister subscriptionData="${product}"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

