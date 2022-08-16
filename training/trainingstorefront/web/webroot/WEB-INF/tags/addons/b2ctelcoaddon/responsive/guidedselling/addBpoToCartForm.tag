<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="parentBpoCode" required="true" type="java.lang.String" %>
<%@ attribute name="spo1" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo2" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo3" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="spo4" required="false" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="processType" required="true" type="java.lang.String" %>
<%@ attribute name="subscriptionTermId" required="false" type="java.lang.String" %>
<%@ attribute name="subscriberIdentity" required="false" type="java.lang.String" %>
<%@ attribute name="subscriberBillingId" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/cart/addBpo" var="addBpoToCartUrl" htmlEscape="false"/>
<spring:theme code="basket.add.to.basket" text="Add To Basket" var="addToBasketText"/>


<c:choose>
	<c:when test="${not spo1.purchasable or spo1.stock.stockLevelStatus.code eq 'outOfStock' }">
		<c:set var="isPurchasableBpo" value="false"/>
	</c:when>
	<c:when test="${not empty spo2 and( not spo2.purchasable or spo2.stock.stockLevelStatus.code eq 'outOfStock')}">
		<c:set var="isPurchasableBpo" value="false"/>
	</c:when>
	<c:when test="${not empty spo3 and( not spo3.purchasable or spo3.stock.stockLevelStatus.code eq 'outOfStock')}">
		<c:set var="isPurchasableBpo" value="false"/>
	</c:when>
	<c:when test="${not empty spo4 and( not spo4.purchasable or spo4.stock.stockLevelStatus.code eq 'outOfStock') }">
		<c:set var="isPurchasableBpo" value="false"/>
	</c:when>
	<c:otherwise>
		<c:set var="isPurchasableBpo" value="true"/>
	</c:otherwise>
</c:choose>

<c:if test="${isPurchasableBpo}">
	<form:form action="${addBpoToCartUrl}" method="post">
		<button class="btn btn-block btn btn-block btn-primary btn-dark-style js-enable-btn"
				  title="${addToBasketText}">
				${addToBasketText}
		</button>
		<input type="hidden" name="rootBpoCode" value="${ycommerce:encodeHTML(parentBpoCode)}"/>
		<input type="hidden" name="processType" value="${ycommerce:encodeHTML(processType)}"/>
		<input type="hidden" name="simpleProductOfferings" value="${ycommerce:encodeHTML(spo1.code)}"/>
		<c:if test="${not empty subscriptionTermId}">
			<input type="hidden" name="subscriptionTermId" value="${ycommerce:encodeHTML(subscriptionTermId)}"/>
		</c:if>
		<c:if test="${not empty subscriberIdentity}">
			<input type="hidden" name="subscriberIdentity" value="${ycommerce:encodeHTML(subscriberIdentity)}"/>
		</c:if>
		<c:if test="${not empty subscriberBillingId}">
			<input type="hidden" name="subscriberBillingId" value="${ycommerce:encodeHTML(subscriberBillingId)}"/>
		</c:if>
		<c:if test="${not empty spo2}">
			<input type="hidden" name="simpleProductOfferings" value="${ycommerce:encodeHTML(spo2.code)}"/>
		</c:if>
		<c:if test="${not empty spo3}">
			<input type="hidden" name="simpleProductOfferings" value="${ycommerce:encodeHTML(spo3.code)}"/>
		</c:if>
		<c:if test="${not empty spo4}">
			<input type="hidden" name="simpleProductOfferings" value="${ycommerce:encodeHTML(spo4.code)}"/>
		</c:if>
	</form:form>
</c:if>
