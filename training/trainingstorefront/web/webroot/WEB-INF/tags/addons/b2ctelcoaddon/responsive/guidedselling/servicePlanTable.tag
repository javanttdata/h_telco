<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="frequencyTab" required="true" type="de.hybris.platform.b2ctelcofacades.data.FrequencyTabData" %>
<%@ attribute name="bundleTab" required="true" type="de.hybris.platform.b2ctelcofacades.data.BundleTabData" %>
<%@ attribute name="showButtons" required="true" type="java.lang.Boolean" %>
<%@ attribute name="selectProduct" required="true" type="java.lang.Boolean" %>
<%@ attribute name="processType" required="false" type="java.lang.Boolean" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:set var="tabServicePlans" value="${frequencyTab.products}"/>

<div class="sub-tabbody">
	<table class="sub-tabbody-table visible-lg visible-md service-plan-table">
		<tr>
			<th>&nbsp;</th>
			<c:forEach items="${tabServicePlans}" var="plan">

                <c:forEach items="${plan.price.productOfferingPrice.children}" var="componentPop">

                    <c:if test="${componentPop['class'].simpleName eq 'TmaUsageProdOfferPriceChargeData'}">
                        <c:set var="showUsageChargesRow" value="true"/>
                    </c:if>
                </c:forEach>

				<th>${ycommerce:encodeHTML(plan.name)}</th>
			</c:forEach>
		</tr>
		<tr>
			<td><spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency"/></td>
			<c:forEach items="${tabServicePlans}" var="plan">
				<td> ${ycommerce:encodeHTML(plan.subscriptionTerm.billingPlan.billingTime.name)} </td>
			</c:forEach>
		</tr>
		<tr>
			<td><spring:theme code="product.list.viewplans.price" text="Price"/></td>
			<c:forEach items="${tabServicePlans}" var="plan">
				<td><guidedselling:subscriptionPricesLister subscriptionData="${plan}"/></td>
			</c:forEach>
		</tr>
		<tr>
			<td><spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency"/></td>
			<c:forEach items="${tabServicePlans}" var="plan">
				<td>
					<guidedselling:serviceNumber termOfServiceNumber="${plan.subscriptionTerm.termOfServiceNumber}"
														  termOfServiceFrequencyName="${plan.subscriptionTerm.termOfServiceFrequency.name}"/>
				</td>
			</c:forEach>
		</tr>
		<tr>
			<td><spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal"/></td>
			<c:forEach items="${tabServicePlans}" var="plan">
				<td>${ycommerce:encodeHTML(plan.subscriptionTerm.termOfServiceRenewal.name)}</td>
			</c:forEach>
		</tr>
		<c:if test="${showUsageChargesRow}">
			<tr>
                <td><spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/></td>
                <c:forEach items="${tabServicePlans}" var="plan">
                    <td>
                        <price:usagePopLister compositePop="${plan.price.productOfferingPrice}"/>

                    </td>
                </c:forEach>
			</tr>
		</c:if>
		<c:if test="${showButtons}">
			<tr>
				<td>&nbsp;</td>
				<c:forEach items="${tabServicePlans}" var="plan">
					<td>
						<guidedselling:productAddToCartForm spo1="${plan}" spo2="${product}" parentBpo="${bundleTab.parentBpo}"
																		processType="${processType}"
																		subscriptionTermId="${plan.subscriptionTerm.id}"/>
					</td>
				</c:forEach>
			</tr>
		</c:if>
	</table>
	<div class="clearfix"></div>
	<div class="hidden-md hidden-lg">
		<div class="service-table-container">
			<table class="guided-selling-table">
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td><p class="product-heading">${ycommerce:encodeHTML(plan.name)}</p></td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td>
							<p><b><spring:theme code="product.list.viewplans.billingFrequency" text="Billing Frequency"/></b></p>
							<p>${ycommerce:encodeHTML(plan.subscriptionTerm.billingPlan.billingTime.name)}</p>
						</td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td>
							<p><b><spring:theme code="product.list.viewplans.price" text="Price"/></b></p>
							<p><guidedselling:subscriptionPricesLister subscriptionData="${plan}"/></p>
						</td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td>
							<p>
								<b>
									<spring:theme code="product.list.viewplans.termOfServiceFrequency" text="Term of service frequency"/>
								</b>
							</p>
							<p>
								<guidedselling:serviceNumber termOfServiceNumber="${plan.subscriptionTerm.termOfServiceNumber}"
																	  termOfServiceFrequencyName="${plan.subscriptionTerm.termOfServiceFrequency.name}"/>
							</p>
						</td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td>
							<p>
								<b><spring:theme code="product.list.viewplans.termOfServiceRenewal" text="Term of service renewal"/></b>
							</p>
							<p>${ycommerce:encodeHTML(plan.subscriptionTerm.termOfServiceRenewal.name)}</p>
						</td>
					</c:forEach>
				</tr>
				<c:if test="${showUsageChargesRow}">
					<tr>
						<c:forEach items="${tabServicePlans}" var="plan">
							<td>
								<p><b><spring:theme code="product.list.viewplans.usage.charges" text="Usage Charges"/></b></p>
								<p>
                                    <price:usagePopLister compositePop="${plan.price.productOfferingPrice}"/>
                                </p>
							</td>
						</c:forEach>
					</tr>
				</c:if>
				<tr>
					<c:forEach items="${tabServicePlans}" var="plan">
						<td>
							<c:if test="${showButtons}">
								<div>
									<guidedselling:productAddToCartForm spo1="${plan}" spo2="${product}" parentBpo="${bundleTab.parentBpo}"
																					processType="${processType}"
																					subscriptionTermId="${plan.subscriptionTerm.id}"/>
								</div>
							</c:if>
						</td>
					</c:forEach>
				</tr>
			</table>
		</div>
	</div>
</div>
