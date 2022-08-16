<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="telcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>

<template:page pageTitle="${pageTitle}">
	<cms:pageSlot position="Section1" var="comp" element="div" class="productDetailsPageSection1">
		<cms:component component="${comp}" element="div" class="productDetailsPageSection1-component"/>
	</cms:pageSlot>
	<telcoProduct:deviceProductDetailsPanel/>
	<div id="view-plans">
		<guidedselling:viewAllServicePlans bundleTabs="${product.bundleTabs}" product="${product}" selectProduct="false" showButtons="false" horizontalLayout="false"/>
	</div>
	<cms:pageSlot position="CrossSelling" var="comp" element="div" class="productDetailsPageSectionCrossSelling">
		<cms:component component="${comp}" element="div" class="productDetailsPageSectionCrossSelling-component"/>
	</cms:pageSlot>
	<cms:pageSlot position="Section3" var="comp" element="div" class="productDetailsPageSection3">
		<cms:component component="${comp}" element="div" class="productDetailsPageSection3-component"/>
	</cms:pageSlot>
	<cms:pageSlot position="UpSelling" var="comp" element="div">
		<cms:component component="${comp}" element="div"/>
	</cms:pageSlot>
	<product:productPageTabs />
    <cms:pageSlot position="DeviceContentPosition" var="feature" element="div" class="productDetailsPageSectionUpSelling">
      <cms:component component="${feature}"/>
  </cms:pageSlot>
</template:page>
