<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%--@elvariable id="processTypes" type="java.util.List<java.lang.String>"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/processTypes/selectProcessType" var="selectProcessTypeSubmitUrl"/>
<spring:theme code="processType.select.text" var="processTypeSelectText" />
<spring:theme code="processType.select.default" var="processTypeSelectDefault" />

<c:if test="${not empty processTypes}">
    <div class="tma-selection-panel">
        <c:set var="isDefaultSelected" value=""></c:set>
        <c:if test="${empty selectedProcessType}">
            <c:set var="isDefaultSelected" value="selected"></c:set>
        </c:if>
        <form:form id="tmaProcessTypeSelectionForm" method="post" modelAttribute="tmaProcessTypeForm" action="${selectProcessTypeSubmitUrl}">
            <label for="tma-process-type-selection">${processTypeSelectText}</label><br/>
            <form:select path="processTypeName" id="tma-process-type-selection">
                <option value="" ${isDefaultSelected} disabled="true" hidden>${processTypeSelectDefault}</option>
                <c:forEach items="${processTypes}" var="processType">
                    <c:set var="isSelected" value=""></c:set>
                    <c:if test="${processType eq selectedProcessType}">
                        <c:set var="isSelected" value="selected"></c:set>
                    </c:if>
                    <option value="${processType}" ${isSelected}>
                        <spring:message code="text.processType.${processType}" text="${processType}"/>
                    </option>
                </c:forEach>
            </form:select>
        </form:form>
    </div>
</c:if>
