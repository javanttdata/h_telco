<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ attribute name="entryGroup" required="false" type="de.hybris.platform.commercefacades.order.EntryGroupData" %>
<%@ attribute name="entry" required="true" type="java.util.Map.Entry" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<c:set var="parentEntryNumber" value="${ycommerce:encodeHTML(entry.key.entryNumber)}"/>
<spring:url value="/cart/delete" var="bpoDeleteAction" htmlEscape="false"/>

<spring:url var="editUrl" value="/bpo/edit/configure/{/bpoCode}/{/parentEntryNumber}" htmlEscape="false">
    <spring:param name="parentEntryNumber" value="${ycommerce:encodeHTML(entry.key.entryNumber)}"/>
    <spring:param name="bpoCode" value="${ycommerce:encodeHTML(entry.key.product.code)}"/>
</spring:url>

<table>
    <c:choose>
        <c:when test="${not empty entry.value}">
            <tr class="entry-group-header">
                <th>
                    <div class="row">
                        <div class="col-md-10 col-lg-11 col-sm-9 left-align">${ycommerce:encodeHTML(entry.key.product.name)}
                            <div class="small-entry-group-header">
                                <spring:theme code="text.cart.processType.${entry.key.processType.code}"/>
                            </div>
                        </div>
                        <div class="col-md-2 col-lg-1 col-sm-3">
                            <form:form id="deleteBpoForm${parentEntryNumber}" action="${bpoDeleteAction}" method="post"
                                       modelAttribute="deleteBpoForm${parentEntryNumber}">
                                <input type="hidden" name="entryNumber" value="${parentEntryNumber}"/>
                                <spring:theme code="text.iconCartRemove" var="iconCartRemove" text="REMOVE"/>
                                <a href="#" title="Remove Offer" id="${parentEntryNumber}" class="submitRemoveBundle">
                                        ${iconCartRemove}
                                </a>
                            </form:form>
                            <a href="${editUrl}">
                                <spring:theme code="cart.groups.edit" text="EDIT"/>
                            </a>
                        </div>
                    </div>
                </th>
            </tr>
            <cart:entryGroup cartData="${cartData}" entry="${entry.key}" entryValues="${entry.value}"/>
        </c:when>

        <c:otherwise>
            <tr>
                <td>
                    <cart:cartItem cartData="${cartData}" entry="${entry.key}"/>
                </td>
            </tr>
        </c:otherwise>

    </c:choose>
</table>
