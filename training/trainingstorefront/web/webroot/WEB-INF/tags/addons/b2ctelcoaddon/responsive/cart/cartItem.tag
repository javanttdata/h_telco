<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="entry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>

<c:if test="${not empty entry}">
    <li class="item__list--item">
        <order-entry:productImage orderEntry="${entry}"/>
        <order-entry:productDetails orderEntry="${entry}" order="${cartData}" showStock="false"/>
        <order-entry:cartEntryQuantity entry="${entry}"/>
        <order-entry:delivery orderEntry="${entry}"/>
        <order-entry:price orderEntry="${entry}"/>
        <order-entry:menu orderEntry="${entry}"/>
    </li>
</c:if>
