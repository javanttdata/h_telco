<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>


<template:page pageTitle="${pageTitle}">
		<cms:pageSlot position="SideContent" var="feature" class="accountPageSideContent">
			<cms:component component="${feature}" />
		</cms:pageSlot>
        <cms:pageSlot position="MandatoryContent" var="feature" element="div" class="accountPageMandatoryContent">
            <cms:component component="${feature}" />
        </cms:pageSlot>

        <div class="account-section">
            <cms:pageSlot position="OptionalContent" var="feature" element="div" class="accountSectionOptionalContent">
                <cms:component component="${feature}" />
            </cms:pageSlot>
        </div>

        <cms:pageSlot position="BottomContent" var="feature" element="div" class="accountPageBottomContent">
            <cms:component component="${feature}" />
        </cms:pageSlot>
</template:page>