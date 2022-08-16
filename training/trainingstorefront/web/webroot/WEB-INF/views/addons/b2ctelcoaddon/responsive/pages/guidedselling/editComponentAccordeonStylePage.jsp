<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<%--@elvariable id="pageTitle" type="java.lang.String"--%>
<%--@elvariable id="bundleNo" type="java.lang.String"--%>
<%--@elvariable id="dashboard" type="de.hybris.platform.b2ctelcofacades.data.DashboardData"--%>
<%--@elvariable id="productType" type="java.lang.String"--%>
<%--@elvariable id="bundleTemplateData" type="de.hybris.platform.configurablebundlefacades.data.BundleTemplateData"--%>

<template:page pageTitle="${pageTitle}">
	<jsp:body>
		<div class="container-fluid">
			<h1 class="guided-selling-headline"><spring:theme code="guidedselling.select.text.${productType}"/></h1>
			<guidedselling:editComponentAccordeonStyle bundleTemplateData="${bundleTemplateData}" bundleNo="${bundleNo}"/>

			<cms:pageSlot var="comp" position="${slots.CrossSelling}">
				<cms:component component="${comp}"/>
			</cms:pageSlot>

			<cms:pageSlot var="comp" position="${slots.Accessories}">
				<cms:component component="${comp}"/>
			</cms:pageSlot>
		</div>
	</jsp:body>
</template:page>
