<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleTabs" required="true" type="java.util.List" %>
<%@ attribute name="selectProduct" required="true" type="java.lang.Boolean" %>
<%@ attribute name="showButtons" required="true" type="java.lang.Boolean" %>
<%@ attribute name="horizontalLayout" required="true" type="java.lang.Boolean" %>
<%@ attribute name="product" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:theme code="extras.configure.button" text="Configure" var="configureBpo"/>

<div class="prod-add-to-cart">
	<div class="tabs js-tabs tabs-responsive plan-tab-container" id="plan-tab-container">
		<c:forEach items="${bundleTabs}" var="bundleTab">
			<div class="tabhead">
				<a href="" <c:if test="${bundleTab.preselected}"> id="preselected"</c:if>>
						${ycommerce:encodeHTML(bundleTab.parentBpo.name)}
				</a>
			</div>
			<div class="tabbody tma-service-plans">
				<c:choose>
					<c:when test="${not empty bundleTab.frequencyTabs}">
						<div class="headline-contract-length">
							<spring:theme code="product.subscription.termofservicefrequency" text="Contract Length :"/>
						</div>
						<div class="sub-tabs">
							<c:forEach items="${bundleTab.frequencyTabs}" var="frequencyTab">
								<h3 <c:if test="${frequencyTab.preselected}"> id="preselected_sub"</c:if>>
									<c:if test="${frequencyTab.termOfServiceNumber gt 0}">
										${frequencyTab.subscriptionTermName}
									</c:if>
								</h3>
								<c:if test="${horizontalLayout}">
									<%--ServicePlan--%>
									<guidedselling:servicePlanTable frequencyTab="${frequencyTab}" showButtons="${showButtons}"
																			  bundleTab="${bundleTab}" selectProduct="${selectProduct}"/>
								</c:if>

								<c:if test="${!horizontalLayout}">
									<c:choose>
										<c:when test="${not empty product}">
											<%--Device--%>
											<guidedselling:servicePlanTable frequencyTab="${frequencyTab}" showButtons="true"
																					  bundleTab="${bundleTab}"
																					  selectProduct="${selectProduct}"
																					  product="${product}"/>
										</c:when>
										<c:otherwise>
											<guidedselling:serviceAddOnDetails product="${product}" />

										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<c:if test="${product.purchasable and product.stock.stockLevelStatus.code ne 'outOfStock' }">
							<guidedselling:addToBpoConfiguration product="${productData}"
																			 parentBpoCode="${ycommerce:encodeHTML(bundleTab.parentBpo.id)}"
																			 processType="ACQUISITION"/>
						</c:if>
						<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock'}">
							<spring:theme code="text.addToCart.outOfStock" text="Out of Stock"/>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
		</c:forEach>
	</div>
</div>
