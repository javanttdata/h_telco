<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="b2ctelcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>

<div class="product__listing product__list prod_grid_view">
    <c:forEach items="${bpoData}" var="productData">
        <b2ctelcoProduct:servicePlanSmallCard productData="${productData}" spo="${configurableSpo}"/>
    </c:forEach>
</div>
