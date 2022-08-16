<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="oneTimeCharges" required="true"
              type="java.util.List<de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderOneTimeChargePriceData>" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<c:forEach items="${oneTimeCharges}" var="oneTimePrice" varStatus="oneTimePricesCounter">
    <c:if test="${not oneTimePricesCounter.first}">
    </c:if>
    <div class="pay">
        <format:price priceData="${oneTimePrice.dutyFreeAmount}" displayFreeForZero="false"/>
        &nbsp; <b>${ycommerce:encodeHTML(oneTimePrice.billingTime.name)}</b>
    </div>
</c:forEach>
