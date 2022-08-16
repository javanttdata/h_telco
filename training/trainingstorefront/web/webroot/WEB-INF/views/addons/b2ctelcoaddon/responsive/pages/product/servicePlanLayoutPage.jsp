<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<spring:htmlEscape defaultHtmlEscape="true"/>

<%--@elvariable id="pageTitle" type="java.lang.String"--%>
<%--@elvariable id="message" type="java.lang.String"--%>
<%--@elvariable id="bundleTabs" type="java.util.List<de.hybris.platform.b2ctelcofacades.data.BundleTabData>"--%>
<%--@elvariable id="selectProduct" type="java.lang.Boolean"--%>

<template:page pageTitle="${pageTitle}">
	<jsp:body>
		<div class="span-24">
			<div class="span-24 product-detail-viewplans">
				<guidedselling:viewAllServicePlans bundleTabs="${empty bundleTabs ? product.bundleTabs : bundleTabs}"
															  selectProduct="${empty selectProduct? true : selectProduct }"
															  showButtons="true"
															  horizontalLayout="${empty horizontalLayout? true: horizontalLayout}"/>
			</div>
		</div>
	</jsp:body>
</template:page>
