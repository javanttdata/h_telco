<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ attribute name="subscriptionBaseServicesWithValueMap" required="true" type="java.util.Map"%>
<%@ attribute name="subscriptionBaseServicesAvarageValueList"  type="java.util.Set" %>
<%@ attribute name="tmaSubscribedProduct" type="de.hybris.platform.b2ctelcofacades.data.TmaSubscribedProductData" %>
<%@ taglib prefix="component" tagdir="/WEB-INF/tags/shared/component" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<div class="container subscribe-section">
<div class="row circle-section">
	<div class="col-lg">
		<div class="carousel-wrap">
			<div class=" js-owl-carousel js-owl-Sub-carousel-donut owl-carousel owl-theme donut-section">
				<c:forEach items="${subscriptionBaseServicesWithValueMap}" var="subscriptionBaseServicesWithValue">
					<c:set var="tmaSubscribedProduct" value="${subscriptionBaseServicesWithValue.key}"/>
					<c:set var="subscriptionBaseServicesAvarageValueList" value="${subscriptionBaseServicesWithValue.value}" />
					<c:forEach items="${subscriptionBaseServicesAvarageValueList}" var="subscriptionBaseServicesAvarageValueList">			
						<c:set var="tmaProductSpecCharacteristicValueData" value="${subscriptionBaseServicesAvarageValueList.tmaProductSpecCharacteristicValueData}"/>
						<c:set var="tmaProductSpecCharacteristicUnitofMeasurment" value="${tmaProductSpecCharacteristicValueData.unitOfMeasurment}"/>
						<c:choose>
							<c:when test="${tmaProductSpecCharacteristicValueData.value.matches('[0-9]+') && subscriptionBaseServicesAvarageValueList.value.matches('[0-9]+')}">
	    							<fmt:parseNumber var = "eligblity" type = "number" value = "${tmaProductSpecCharacteristicValueData.value}" />
	    							<fmt:parseNumber var = "usage" type = "number" value = "${subscriptionBaseServicesAvarageValueList.convertedUnitValue}" />
	    							<c:set var="rightDegree" value="${(usage/eligblity)*100}"/>	    
							</c:when>
							<c:otherwise><!-- when usage is unlimited -->
								<c:set var="rightDegree" value="${1}"/>
							</c:otherwise>							
						</c:choose>					
						<div class="item">
								<div class="col-lg-6 col-sm-6  col-xs-6 circle-space">
									<label>${tmaProductSpecCharacteristicValueData.description}</label>
									<div class="set-size charts-container">
									<c:choose>
										<c:when test = "${rightDegree > 99}">
										  <div class="donut-progress-bar position" data-percent="100" data-duration="1000" data-color="#1abc9c,#e74c3c"></div>
										  <span class="label label-danger"><spring:theme code="text.account.subscriptions.overlimit" text="Over Used Data Limit"/></span>
	        				            </c:when>
										<c:otherwise>
										  <div class="donut-progress-bar position" data-percent="${rightDegree}" data-duration="1000" data-color="#1abc9c,#e74c3c"></div>
										</c:otherwise>
									</c:choose>
									</div>
									<label>${ycommerce:encodeHTML(tmaSubscribedProduct.name)}</label>
								</div>
							    <div class="col-lg-6 col-sm-6 col-xs-6 circle-space circle-carousel">	
								    <div class="squarewrap">
							           <div class="col-lg-1 col-sm-1 col-xs-1 no-side-padding">	
							              <li class="number fill-red"></li>
							           </div>	
							           <div class="col-lg-11 col-sm-11 col-xs-11 no-side-padding">									
										<ul class="square">
				 <!-- eligblity -->	      	<li class="number">${subscriptionBaseServicesAvarageValueList.value}</li><li class="unit">${ subscriptionBaseServicesAvarageValueList.unitOfMeasure}</li><li class="unit"> <spring:theme code="text.account.subscriptions.used" text="Used"/></li>									  
										</ul>
									   </div>
									   <div class="col-lg-1 col-sm-1 col-xs-1 no-side-padding">	
							              <li class="number fill-green"></li>
							           </div>	
							           <div class="col-lg-11 col-sm-11 col-xs-11 no-side-padding">
										<ul class="square">
				  <!-- Usage -->	       <li class="number">${tmaProductSpecCharacteristicValueData.value}</li><li class="unit">${tmaProductSpecCharacteristicUnitofMeasurment}</li> <li class="unit"><spring:theme code="text.account.subscriptions.subscribed" text="Subscribed"/></li>
										</ul>
									   </div>
									</div>									
							    </div>
			   			</div>
				    </c:forEach>
			   </c:forEach>
			</div>
		</div>
	</div>
</div>
</div>