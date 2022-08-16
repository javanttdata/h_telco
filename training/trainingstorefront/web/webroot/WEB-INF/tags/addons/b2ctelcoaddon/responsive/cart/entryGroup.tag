<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ attribute name="entryGroup" required="false" type="de.hybris.platform.commercefacades.order.EntryGroupData" %>
<%@ attribute name="entry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@attribute name="entryValues" required="true" type="java.util.List<de.hybris.platform.commercefacades.order.data.OrderEntryData>" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/cart" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<tr>
    <td>
        <table>
            <c:if test="${not empty entry.validationMessages}">
                <tr class="entry-group-header">
                    <th class="error">
                        <div class="row">
                            <div class="col-md-10 col-lg-11 col-sm-9 left-align">
                                <p class="entry-group-error-message">
                                    <spring:theme code="basket.validation.invalidGroup"
                                                  text="This group is improperly configured. Please edit it."/>
                                </p>
                                <c:forEach items="${entry.validationMessages}" var="errorMessage">
                                    <p class="entry-group-error-message">
                                        <spring:theme code="${errorMessage.message}"/>
                                    </p>
                                </c:forEach>
                            </div>
                        </div>
                    </th>
                </tr>
            </c:if>
            <c:forEach items="${entryValues}" var="entry">
                <tr>
                    <td>
                        <cart:cartItem cartData="${cartData}" entry="${entry}"/>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </td>
</tr>

