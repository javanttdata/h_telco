<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="/WEB-INF/common/tld/cmstags.tld"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="sbgproduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>

<template:page pageTitle="${pageTitle}">
	<cms:pageSlot var="feature" position="${slots['Section1']}">
		<div class="span-24 section1 advert">
			<cms:component component="${feature}" />
		</div>
	</cms:pageSlot>
	
	<div class="span-24 sbg-product-list">
		<sbgproduct:sbgProductWideView product="${product}" />
		<sbgproduct:sbgProductMobileView product="${product}" />
	</div>
</template:page>