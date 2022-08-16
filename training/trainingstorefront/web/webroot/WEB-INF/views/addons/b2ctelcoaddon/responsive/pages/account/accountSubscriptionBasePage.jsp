<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account/subscription" %>
<%@ taglib prefix="breadcrumb" tagdir="/WEB-INF/tags/desktop/nav/breadcrumb"%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<div class="account-section-header">
    <h5><a href="${contextPath}/my-account/subscription"><span class="glyphicon glyphicon-chevron-left"></span> subscriptions</a></h5>
    <h4><spring:theme code="text.account.subscriptionBase" text=""/>${ycommerce:encodeHTML(subscriberIdentity)}</h4>
</div>
<c:set var="showPage" value="false" />
<c:forEach items="${subscriptionBaseServicesWithValue}"
	var="subscriptionBaseServicesWithValueMap">
	<c:set var="subscriptionBaseServicesAvarageValueList"
		value="${subscriptionBaseServicesWithValueMap.value}" />
	<c:if test="${subscriptionBaseServicesAvarageValueList.size() > 0}">
		<c:set var="showPage" value="true" />
	</c:if>
</c:forEach>
<c:choose>
	<c:when test="${showPage}">
   	  <subscription:subscriptionGraphDisplay subscriptionBaseServicesWithValueMap="${subscriptionBaseServicesWithValue}"/>
 	  <div class="container subscribe-section">
	  <div class="row">
      <div class="col-lg">
		<div class="account-section-content">
			<div class="account-orderhistory">
				<div class="account-overview-table">
				  <subscription:subscriptionBaseServicesAvgUsage subscriptionBaseServicesWithValueMap="${subscriptionBaseServicesWithValue}"/>
				</div>
			</div>
		</div>
	  </div>
	  </div>
	  </div>
	</c:when>
	<c:otherwise>
      <div class="account-section-content content-empty">
		<spring:theme code="text.account.subscriptions.noSubscriptions.usage" text="You don't have usage data available at this time. Please try later."/>
	  </div>  
	</c:otherwise>
</c:choose>
