<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>

<template:page pageTitle="${pageTitle}">
	<div class="row">
		<cms:pageSlot position="BpoGuidedSellingDashboardSlot" var="feature" element="div" class="product-list-bundle-dashboard-slot">
			<cms:component component="${feature}" element="div" class="col-xs-12 yComponentWrapper product-list-bundle-dashboard-slot" />
		</cms:pageSlot>
	</div>
	<div class="row">
		<div class="col-xs-3">
			<cms:pageSlot position="ProductLeftRefinements" var="feature" element="div" class="product-list-left-refinements-slot">
				<cms:component component="${feature}" element="div" class="yComponentWrapper product-list-left-refinements-component" />
			</cms:pageSlot>
		</div>
		<div class="col-sm-12 col-md-9">
			<div class="row">
				<div class="button-slot margin-top-20">
					<cms:pageSlot position="BpoGuidedSellingButtonSlot" var="feature" element="div" class="product-list-bundle-button-slot">
						<cms:component component="${feature}" element="div" class="col-xs-12 col-sm-3 pull-right  yComponentWrapper product-list-bundle-button-slot" />
					</cms:pageSlot>
				</div>
			</div>
			<cms:pageSlot position="BpoProductSelectorSlot" var="feature" element="div" class="product-list-right-slot">
				<cms:component component="${feature}" element="div" class="product__list--wrapper yComponentWrapper product-list-right-component" />
			</cms:pageSlot>
			<div class="row">
				<div class="button-slot">
					<cms:pageSlot position="BpoGuidedSellingButtonSlot" var="feature" element="div" class="product-list-bundle-button-slot">
						<cms:component component="${feature}" element="div" class="col-xs-12 col-sm-3 pull-right  yComponentWrapper product-list-bundle-button-slot" />
					</cms:pageSlot>
				</div>
			</div>
		</div>
	</div>
</template:page>