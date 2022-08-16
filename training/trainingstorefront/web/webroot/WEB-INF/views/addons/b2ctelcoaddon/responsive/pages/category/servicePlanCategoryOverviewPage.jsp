<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="/WEB-INF/common/tld/cmstags.tld"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

<template:page pageTitle="${pageTitle}">
	<div class="span-24 plans-overview" id="product-detail-updateable">
		<div class="row">
			<cms:pageSlot var="banner" position="Section2">
				<div class="col-xs-12 col-sm-6 col-lg-4 border-box">
					<cms:component component="${banner}" />
				</div>
			</cms:pageSlot>
		</div>
	</div>
</template:page>