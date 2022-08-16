<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="termOfServiceNumber" required="false" type="java.lang.Integer"%>
<%@ attribute name="termOfServiceFrequencyName" required="false" type="java.lang.String"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${termOfServiceNumber gt 0}">
	${termOfServiceNumber} &nbsp;
</c:if>
${ycommerce:encodeHTML(termOfServiceFrequencyName)}
