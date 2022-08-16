<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--@elvariable id="subscriptions" type="java.util.Map<java.lang.String, java.util.List<de.hybris.platform.b2ctelcofacades.data.TmaSubscriptionSelectionData>>"--%>
<%--@elvariable id="processType" type="java.lang.String"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/offers" var="offers" htmlEscape="false"/>

<c:if test="${not empty processType}">
    <div class="tma-selection-panel">
        <label for="subscription-selection"><spring:theme code="subscription.select.text" text="Select your number:"/></label>
        <br/>

        <select id="subscription-selection" name="subscription-selection">
            <option value="" selected disabled hidden>
                <spring:theme code="subscription.select.default" text="Please select"/>
            </option>

            <c:forEach items="${subscriptions}" var="subscriptionEntry">
                <c:set var="subscriptionSelectionValue" value=""/>
                <c:set var="subscriberIdentities" value=""/>
                <c:set var="currentBpoCode" value=""/>

                <c:forEach items="${subscriptionEntry.value}" var="subscriptionSelection" varStatus="status">
                    <c:set var="subscriptionSelectionValue"
                           value="${subscriptionSelectionValue}${subscriptionSelection.subscriberIdentity}"/>
                    <c:set var="subscriberIdentities"
                           value="${subscriberIdentities}${subscriptionSelection.subscriberIdentity}__${subscriptionSelection.billingSystemId}"/>
                    <c:set var="currentBpoCode" value="${subscriptionSelection.bpoCode}"/>

                    <c:if test="${not status.last}">
                        <c:set var="subscriptionSelectionValue" value="${subscriptionSelectionValue}, "/>
                        <c:set var="subscriberIdentities" value="${subscriberIdentities}, "/>
                    </c:if>
                </c:forEach>

                <c:if test="${product !=null && product.code!=null }">
                    <option
                            value="${offers}/${processType}/${product.code}?bpoCode=${currentBpoCode}&subscriberIdentities=${subscriberIdentities}"> ${subscriptionSelectionValue}
                    </option>
                </c:if>
            </c:forEach>
        </select>
    </div>
</c:if>
