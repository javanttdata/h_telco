<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleTemplateData" required="true"
              type="de.hybris.platform.configurablebundlefacades.data.BundleTemplateData" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.Integer" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>


<spring:htmlEscape defaultHtmlEscape="true"/>
<spring:url value="/cart" var="cartUrl" htmlEscape="false"/>

<input type="hidden" id="refreshed" value="no">
<c:forEach items="${bundleTemplateData.bundleBoxes}" var="bundleBox" >
   <c:if test="${bundleBox.expanded}">
      <c:set value="box_expanded" var="expandedCssClass"/>
      <c:set value="tabindex=\"0\"" var="expandedTabIndex"/>
   </c:if>

   <div class="bundle-box ${expandedCssClass}" ${expandedTabIndex}>
      <div class="row">
         <div class="col-xs-8 col-sm-10">
            <h2>${ycommerce:encodeHTML(bundleBox.component.name)}</h2>
         </div>
         <div class="col-xs-4 col-sm-2 review-area">
            <c:if test="${bundleBox.reviewButton}">
               <spring:url value="/bundle/edit-component/{/bundleNo}/component/{/componentId}" var="editComponentUrl"
                           htmlEscape="false">
                  <spring:param name="bundleNo" value="${ycommerce:encodeHTML(bundleNo)}"/>
                  <spring:param name="componentId" value="${ycommerce:encodeHTML(bundleBox.component.id)}"/>
               </spring:url>
               <a href="${editComponentUrl}"><spring:theme code="extras.review.button" text="Review Step"/></a>
            </c:if>
         </div>
      </div>
      <c:if test="${bundleBox.expanded}">
         <p class="sub-header">
            <spring:theme code="extras.package.message"
                          text="Add any of the following extras to your package:"/>
         </p>
      </c:if>

      <c:forEach items="${bundleBox.bundleBoxEntries}" var="bundleBoxEntry" varStatus="bundleBoxEntryCounter">
         <guidedselling:bundleBoxEntry bundleBoxEntry="${bundleBoxEntry}"
                                       bundleBoxEntryCounter="${bundleBoxEntryCounter.count}"
                                       bundleNo="${bundleNo}"
                                       bundleTemplateId="${bundleBox.component.id}"/>
      </c:forEach>
   </div>
   <c:if test="${bundleBox.expanded}">
      <spring:url value="/bundle/edit-component/{/bundleNo}/nextcomponent/{/componentId}" var="editNextComponentUrl"
                  htmlEscape="false">
         <spring:param name="bundleNo" value="${ycommerce:encodeHTML(bundleNo)}"/>
         <spring:param name="componentId" value="${ycommerce:encodeHTML(bundleBox.component.id)}"/>
      </spring:url>
      <a class="btn btn-primary btn-block btn-dark-style" href="${editNextComponentUrl}">
         <spring:theme code="extras.continue.button" text="Continue"/>
      </a>
   </c:if>
</c:forEach>
<div class="btn-bundle-done">
   <a class="btn btn-primary btn-block" href="${cartUrl}">
      <spring:theme code="extras.done.button" text="I'm Done"/>
   </a>
</div>
