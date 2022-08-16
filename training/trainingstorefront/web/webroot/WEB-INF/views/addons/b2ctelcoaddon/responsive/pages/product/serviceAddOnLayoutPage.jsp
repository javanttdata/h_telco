<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/responsive/common" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:htmlEscape defaultHtmlEscape="true"/>

<%--@elvariable id="product" type="de.hybris.platform.commercefacades.product.data.ProductData"--%>

<template:page pageTitle="${pageTitle}">
    <jsp:body>
        <guidedselling:serviceAddOnDetails product="${product}"/>
        <c:if test="${product.bundleTabs.size() > 1}">
            <br/><br/>
            <div class="prod-add-to-cart">
                <div class="tabs js-tabs tabs-responsive plan-tab-container">
                    <c:forEach items="${product.bundleTabs}" var="bundleTab">
                        <div class="tabhead">
                            <a href="" <c:if
                                    test="${bundleTab.preselected}"> id="preselected"</c:if>>${ycommerce:encodeHTML(bundleTab.parentBpo.name)}</a>
                        </div>
                        <div class="tabbody tma-service-plans">
                            <guidedselling:addToBpoConfiguration product="${product}"
                                                                 parentBpoCode="${ycommerce:encodeHTML(bundleTab.parentBpo.id)}"
                                                                 processType="ACQUISITION"/>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </jsp:body>
</template:page>
