<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>

<div class="item__menu">
    <c:if test="${orderEntry.updateable  or orderEntry.removeable}">
        <div class="btn-group js-cartItemDetailGroup">
            <button type="button" class="btn btn-default js-cartItemDetailBtn" aria-haspopup="true" aria-expanded="false"
                    id="editEntry_${orderEntry.entryNumber}">
                <span class="glyphicon glyphicon-option-vertical"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right">
                <form:form id="cartEntryActionForm" action="" method="post"/>
                <c:forEach var="entryAction" items="${orderEntry.supportedActions}">
                    <li><a href="#" onclick="ACC.cartTelco.submitRemove('${orderEntry.entryNumber}');"
                           id="Remove_${orderEntry.entryNumber}" class="submitRemove"> <spring:theme
                            code="basket.page.entry.action.REMOVE"
                            text="Remove"/>
                    </a></li>
                </c:forEach>
            </ul>
        </div>
    </c:if>
</div>
