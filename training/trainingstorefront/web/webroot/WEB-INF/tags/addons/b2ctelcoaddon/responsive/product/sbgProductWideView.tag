<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="sbgproduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<c:set var="pageDataResult" value="${searchPageData.results}" />
<table class="sub-tabbody-table visible-lg visible-md service-plan-table">
	<tbody>
		<tr>
			<th></th>
			<c:forEach items="${pageDataResult}" var="product">
				<th>
					<sbgproduct:sbgProductListerGridItem product="${product}" />
				</th>
			</c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency" />
			</td>
		    <c:forEach items="${pageDataResult}" var="product">
			 <td>
               <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
				<p>${ycommerce:encodeHTML(subscriptionTerm.billingPlan.billingTime.name)}</p>
			   </c:forEach>
             </td>
            </c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.price" text="Price" />
			</td>
			<c:forEach items="${pageDataResult}" var="product">
				<td>
					<guidedselling:subscriptionPricesLister subscriptionData="${product}" />
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency" />
			</td>
			<c:forEach items="${pageDataResult}" var="product">
             <td>
               <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
                <p>
                 <c:if test="${subscriptionTerm.termOfServiceNumber gt 0}">${subscriptionTerm.termOfServiceNumber} &nbsp;
                 </c:if>${ycommerce:encodeHTML(subscriptionTerm.termOfServiceFrequency.name)} &nbsp;
                </p>
               </c:forEach>
             </td>
            </c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal" />
			</td>
			<c:forEach items="${pageDataResult}" var="product">
             <td>
               <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
                <p>${ycommerce:encodeHTML(subscriptionTerm.termOfServiceRenewal.name)}</p>
               </c:forEach>
             </td>
            </c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.entitlements" text="Entitlements" />
			</td>
			<c:forEach items="${pageDataResult}" var="product">
				<td>
					<c:if test="${not empty product.productSpecDescription}">
						<c:forEach items="${product.productSpecDescription}" var="productSpecDescription">
							<div>${ycommerce:sanitizeHTML(productSpecDescription)}</div>
						</c:forEach>
					</c:if>
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td>
				<spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges" />
			</td>
			<c:forEach items="${pageDataResult}" var="product">
				<td>
					<guidedselling:sbgUsageChargesLister product="${product}" />
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td></td>
			<product:addToCartTitle />
			<c:forEach items="${pageDataResult}" var="product">
				<td>
					<sbgproduct:sbgAddToCartForm product="${product}" processType="ACQUISITION"/>
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
