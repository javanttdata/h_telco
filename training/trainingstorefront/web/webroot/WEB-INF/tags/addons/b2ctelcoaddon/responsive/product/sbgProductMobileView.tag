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
<div class="hidden-md hidden-lg">
	<div class="service-table-container">
		<table class="guided-selling-table">
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<spring:url value="${product.url}" var="productUrl" htmlEscape="false" />
					<td>
						<sbgproduct:sbgProductListerGridItem product="${product}" />
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<td>
						<strong>
							<spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency" />
						</strong>
                           <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
				            <p>${ycommerce:encodeHTML(subscriptionTerm.billingPlan.billingTime.name)}</p>
			               </c:forEach>
                  </c:forEach>     
			</tr>
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<td>
						<strong>
							<spring:theme code="product.list.viewplans.price" text="Price" />
						</strong>
						<p>
							<guidedselling:subscriptionPricesLister subscriptionData="${product}" />
						</p>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<td>
						<strong>
						 <spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency" />
						</strong>
                          <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
                            <p>
                             <c:if test="${subscriptionTerm.termOfServiceNumber gt 0}">
                             ${subscriptionTerm.termOfServiceNumber} &nbsp;
                             </c:if>${ycommerce:encodeHTML(subscriptionTerm.termOfServiceFrequency.name)} &nbsp;
                            </p>
                          </c:forEach>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<td>
						<strong>
							<spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal" />
						</strong>
                          <c:forEach items="${product.price.subscriptionTerms}" var="subscriptionTerm">
                           <p>${ycommerce:encodeHTML(subscriptionTerm.termOfServiceRenewal.name)}</p>
                          </c:forEach>	
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pageDataResult}" var="product">
					<td>
						<strong>
							<spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges" />
						</strong>
						<p>
							<guidedselling:sbgUsageChargesLister product="${product}" />
						</p>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<product:addToCartTitle />
				<c:forEach items="${pageDataResult}" var="product">
					<td>
                        <sbgproduct:sbgAddToCartForm product="${product}" processType="ACQUISITION"/>
					</td>
				</c:forEach>
			</tr>
		</table>
	</div>
</div>
