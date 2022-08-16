<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/responsive/storepickup" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<%--@elvariable id="pageTitle" type="java.lang.String"--%>
<%--@elvariable id="bundleNo" type="java.lang.String"--%>
<%--@elvariable id="componentId" type="java.lang.String"--%>
<%--@elvariable id="productType" type="java.lang.String"--%>
<%--@elvariable id="isShowPageAllowed" type="java.lang.Boolean"--%>
<%--@elvariable id="isShowAllAllowed" type="java.lang.Boolean"--%>
<%--@elvariable id="numberPagesShown" type="java.lang.Integer"--%>
<%--@elvariable id="dashboard" type="de.hybris.platform.b2ctelcofacades.data.DashboardData"--%>
<%--@elvariable id="searchPageData" type="de.hybris.platform.commerceservices.search.facetdata.ProductCategorySearchPageData"--%>

<spring:htmlEscape defaultHtmlEscape="true" />

<template:page pageTitle="${pageTitle}">
    <jsp:body>
        <div class="row">
            <div class="col-xs-3">
                <div class="search-list-page-left-refinements-slot">
                    <div class="search-list-page-left-refinements-component">
                        <div id="product-facet" class="hidden-sm hidden-xs product__facet js-product-facet">
                            <nav:categoryNav pageData="${searchPageData}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-9">
                <div class="search-list-page-right-result-list-slot">
                    <div class="search-list-page-right-result-list-component">
                        <div class="product__list--wrapper">

                            <div class="results">
                                <h1><spring:theme code="guidedselling.select.text.${ycommerce:encodeHTML(productType)}"/></h1>
                            </div>

                            <div class="searchSpellingSuggestionPrompt">
                                <nav:searchSpellingSuggestion spellingSuggestion="${searchPageData.spellingSuggestion}"/>
                            </div>

                            <nav:pagination top="true" supportShowPaged="${isShowPageAllowed}"
                                            supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
                                            searchUrl="${searchPageData.currentQuery.url}"  numberPagesShown="${numberPagesShown}"/>

                            <input type="hidden" id="refreshed" value="no">
                            <ul class="product__listing product__list">
                                <c:forEach items="${searchPageData.results}" var="product">
                                    <product:productListerGridItemForGuidedSelling product="${product}"
                                                                                   bundleNo="${bundleNo}"
                                                                                   componentId="${componentId}"/>
                                </c:forEach>
                            </ul>

                            <nav:pagination top="false" supportShowPaged="${isShowPageAllowed}"
                                            supportShowAll="${isShowAllAllowed}"
                                            searchPageData="${searchPageData}"
                                            searchUrl="${searchPageData.currentQuery.url}"
                                            numberPagesShown="${numberPagesShown}"/>
                            <storepickup:pickupStorePopup />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</template:page>
