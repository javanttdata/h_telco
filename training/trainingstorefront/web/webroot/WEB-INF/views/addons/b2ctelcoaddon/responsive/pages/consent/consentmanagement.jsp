<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<spring:htmlEscape defaultHtmlEscape="true" />

<c:forEach var="consentTemplate" items="${consentTemplatesToDisplay}" varStatus="loop">
    <div class="consentmanagement-bar cookie-popup" data-code="${consentTemplate.id}">
        <div class="row">
            <div class="col-lg-6 col-md-7 col-xs-7">
                <h4>${ycommerce:sanitizeHTML(consentTemplate.description)}</h4>
            </div>
            <div class="col-lg-6 col-md-5 col-xs-5">
                <button class="btn btn-primary consent-reject newtrack-btn" data-index="${loop.index}">
                    <spring:theme code="text.consent.button.decline" text="Decline" htmlEscape="false"/>
                </button>
                <button class="btn btn-primary consent-accept newtrack-btn" data-index="${loop.index}">
                    <spring:theme code="text.consent.button.accept" text="Accept" htmlEscape="false"/>
                </button>
            </div>
        </div>
    </div>
</c:forEach>

