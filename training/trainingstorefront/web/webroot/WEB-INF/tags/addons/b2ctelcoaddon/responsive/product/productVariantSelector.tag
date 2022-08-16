<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="telcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>

<c:set var="showAddToCart" value="" scope="session"/>
<spring:htmlEscape defaultHtmlEscape="true" />

<c:if test="${product.multidimensional and not empty product.variantMatrix}">
    <c:set var="levels" value="${fn:length(product.categories)}"/>
    <c:set var="selectedIndex" value="0"/>

    <div class="variant-section">
        <div class="variant-selector">
            <c:forEach begin="1" end="${levels}" varStatus="loop">
                <c:set var="i" value="0"/>
                <div class=" clearfix">
                    <c:choose>
                        <c:when test="${loop.index eq 1}">
                            <c:set var="productMatrix" value="${product.variantMatrix }"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="productMatrix" value="${productMatrix[selectedIndex].elements }"/>
                        </c:otherwise>
                    </c:choose>
                    <div class="variant-name">${fn:escapeXml(productMatrix[0].parentVariantCategory.name)}</div>

                    <c:if test="${not empty productMatrix}">
                        <c:choose>
                            <c:when test="${productMatrix[0].parentVariantCategory.hasImage}">
                                <ul class="variant-list">
                                    <c:forEach items="${productMatrix}" var="variantCategory">
                                        <c:set var="isSelected" value="${variantCategory.variantOption.code eq product.code}"/>
                                        <c:set var="cssClass" value="tma-variant"/>
                                        <c:if test="${isSelected}">
                                            <c:set var="cssClass" value="tma-variant tma-variant-selected"/>
                                        </c:if>
                                        <li <c:if test="${isSelected}">class="selected"</c:if>>
                                            <c:url value="${variantCategory.variantOption.url}" var="productStyleUrl"/>
                                            <a href="${productStyleUrl}" class="${cssClass}"
                                               name="${variantCategory.variantOption.url}">
                                                <telcoProduct:variantImage product="${product}"
                                                                           variantOption="${variantCategory.variantOption}"
                                                                           format="styleSwatch"/>
                                            </a>
                                        </li>
                                        <c:if test="${(variantCategory.variantOption.code eq product.code)}">
                                            <c:set var="selectedIndex" value="${i}"/>
                                        </c:if>
                                        <c:set var="i" value="${i + 1}"/>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <ul id="priority${loop.index}" class="variant-list">
                                    <c:forEach items="${productMatrix}" var="variantCategory">
                                        <c:url value="${variantCategory.variantOption.url}" var="productStyleUrl"/>
                                        <c:set var="isSelected" value="${variantCategory.variantOption.code eq product.code}"/>
                                        <c:set var="cssClass" value="tma-variant"/>
                                        <c:if test="${isSelected}">
                                            <c:set var="cssClass" value="tma-variant tma-variant-selected"/>
                                        </c:if>
                                        <li>
                                            <a href="${productStyleUrl}" class="${cssClass}">
                                                    ${fn:escapeXml(variantCategory.variantValueCategory.name)}</a>
                                        </li>
                                        <c:if test="${(variantCategory.variantOption.code eq product.code)}">
                                            <c:set var="selectedIndex" value="${i}"/>
                                        </c:if>
                                        <c:set var="i" value="${i + 1}"/>
                                    </c:forEach>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>