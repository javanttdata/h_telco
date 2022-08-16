<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>

<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>

<c:if test="${product.baseProduct!=null and not empty product.variantMatrix}">
    <c:set var="variantCategory" value="${product.variantMatrix[0]}"/>
    <order-entry:variantCategoryDetails product="${product}" variantCategory="${variantCategory}"/>

    <c:forEach items="${variantCategory.elements}" var="variantCategory">
        <order-entry:variantCategoryDetails product="${product}"
                                            variantCategory="${variantCategory}"/>
        <c:set var="variantCategory" value="${variantCategory.elements}"/>
    </c:forEach>

</c:if>
