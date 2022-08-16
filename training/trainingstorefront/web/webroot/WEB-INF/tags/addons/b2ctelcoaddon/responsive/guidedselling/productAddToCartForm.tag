<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="spo1" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo2" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo3" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo4" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="processType" required="false" type="java.lang.String" %>
<%@ attribute name="subscriptionTermId" required="false" type="java.lang.String" %>
<%@ attribute name="parentBpo" required="false" type="de.hybris.platform.b2ctelcofacades.data.BpoData" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>

<c:if test="${empty processType}">
	<c:set var="processType" value="ACQUISITION"/>
</c:if>
<c:if test="${not empty parentBpo}">
	<c:set var="parentBpoCode" value="${parentBpo.id}"/>
</c:if>

<c:choose>
	<c:when test="${not empty parentBpoCode and (not empty spo2 or not empty spo3 or not empty spo4)}">
		<guidedselling:addBpoToCartForm parentBpoCode="${parentBpo.id}" spo1="${spo1}" spo2="${spo2}" spo3="${spo3}"
												  spo4="${spo4}"
												  processType="${processType}"
												  subscriptionTermId="${subscriptionTermId}"/>
	</c:when>
	<c:otherwise>
		<guidedselling:addSpoToCartForm product="${spo1}" processType="${processType}" parentBpoCode="${parentBpoCode}"
												  subscriptionTermId="${subscriptionTermId}"/>
	</c:otherwise>
</c:choose>
