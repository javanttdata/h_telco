<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="variantOption" required="true" type="de.hybris.platform.commercefacades.product.data.VariantOptionData" %>
<%@ attribute name="format" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="code" value="${variantOption.code}"/>
<c:set var="variantImage" value="${ycommerce:productCodeImage(product, code, format)}" />

<c:choose>
    <c:when test="${not empty variantImage}">
        <img src="${fn:escapeXml(variantImage.url)}" alt="${fn:escapeXml(code)}" title="${fn:escapeXml(code)}"/>
    </c:when>
    <c:otherwise>
        <div class="tma-variant-image">
            <theme:image code="img.missingProductImage.responsive.${format}" alt="${code}" title="${code}"/>
        </div>
    </c:otherwise>
</c:choose>
