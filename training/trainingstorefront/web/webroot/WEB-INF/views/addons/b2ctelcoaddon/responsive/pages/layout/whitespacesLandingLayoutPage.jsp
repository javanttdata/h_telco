<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>

<template:page pageTitle="${pageTitle}">
	<div class="row no-margin whitespace-full">
        <cms:pageSlot position="Section1" var="feature" class="no-access">
            <cms:component component="${feature}" />
        </cms:pageSlot>
	</div>
    <div class="row no-margin no-padding">
        <div class="col-xs-12 col-md-6 no-padding">
            <cms:pageSlot position="Section2A" var="feature" element="div" class="row no-margin no-padding">
                <cms:component component="${feature}" element="div" class="col-xs-12 col-sm-6 yComponentWrapper"/>
            </cms:pageSlot>
        </div>
        <div class="col-xs-12 col-md-6 no-padding">
            <cms:pageSlot position="Section2B" var="feature" element="div" class="row no-margin no-padding">
                <cms:component component="${feature}" element="div" class="col-xs-12 col-sm-6 yComponentWrapper"/>
            </cms:pageSlot>
        </div>
        <div class="col-xs-12">
            <cms:pageSlot position="Section2C" var="feature" element="div" class="landingLayout2PageSection2C">
                <cms:component component="${feature}" element="div" class="yComponentWrapper"/>
            </cms:pageSlot>
        </div>
    </div>

    <cms:pageSlot position="Section3" var="feature" element="div" class="row no-margin" >
        <cms:component component="${feature}" element="div" class="yComponentWrapper"/>
    </cms:pageSlot>

    <cms:pageSlot position="Section4" var="feature" element="div" class="row no-margin">
        <cms:component component="${feature}" element="div" class="col-xs-6 col-md-3 yComponentWrapper"/>
    </cms:pageSlot>

    <cms:pageSlot position="Section5" var="feature" element="div">
        <cms:component component="${feature}" element="div" class="yComponentWrapper"/>
    </cms:pageSlot>

</template:page>
