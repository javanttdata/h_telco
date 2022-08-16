<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleDisabledMessage" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<c:if test="${not empty bundleDisabledMessage}">
   <div class="telco-tooltip">${ycommerce:sanitizeHTML(bundleDisabledMessage)}</div>
</c:if>
