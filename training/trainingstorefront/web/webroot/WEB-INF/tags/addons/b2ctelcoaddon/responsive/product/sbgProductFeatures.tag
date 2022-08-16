<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<div class="product-classifications">
	<div class="headline">
		<spring:theme code="product.sbgproduct.features" text="Features" />
	</div>
	<table class="table">
		<tbody>
			<tr>
				<td class="attrib">
					<spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency" />
				</td>
				<td>${ycommerce:encodeHTML(product.subscriptionTerm.billingPlan.billingTime.name)}</td>
			</tr>
			<tr>
				<td class="attrib">
					<spring:theme code="product.list.viewplans.price" text="Price" />
				</td>
				<td>
					<guidedselling:subscriptionPricesLister subscriptionData="${product}" />
				</td>
			</tr>
			<tr>
				<td class="attrib">
					<spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency" />
				</td>
				<td>
					<c:if test="${product.subscriptionTerm.termOfServiceNumber gt 0}">
						${ycommerce:encodeHTML(product.subscriptionTerm.termOfServiceNumber)} &nbsp;
					</c:if>
					${ycommerce:encodeHTML(product.subscriptionTerm.termOfServiceFrequency.name)}
				</td>
			</tr>
			<tr>
				<td class="attrib">
					<spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal" />
				</td>
				<td>${ycommerce:encodeHTML(product.subscriptionTerm.termOfServiceRenewal.name)}</td>
			</tr>
			<tr>
				<td class="attrib">
					<spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges" />
				</td>
				<td>
					<guidedselling:sbgUsageChargesLister product="${product}" />
				</td>
			</tr>
		</tbody>
	</table>
</div>
