<%@ page trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<%--@elvariable id="component" type="de.hybris.platform.acceleratorcms.model.components.SearchBoxComponentModel"--%>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="/search/" var="searchUrl" htmlEscape="false" />
<spring:url value="/search/autocomplete/{/componentuid}" var="autocompleteUrl" htmlEscape="false">
	<spring:param name="componentuid" value="${component.uid}" />
</spring:url>

<div class="ui-front">
	<form name="search_form_${ycommerce:encodeHTML(component.uid)}" method="get" action="${searchUrl}">
		<div class="input-group inner-addon left-addon">
			<spring:theme code="search.placeholder" var="searchPlaceholder" text="I'm looking for" />
			<i class="glyphicon glyphicon-search"></i> 
			<input type="text" id="js-site-search-input" class="form-control js-site-search-input" name="text" value="" 
			 maxlength="100" placeholder="${searchPlaceholder}" data-options='{"autocompleteUrl" : "${autocompleteUrl}","minCharactersBeforeRequest" : "${component.minCharactersBeforeRequest}",
				"waitTimeBeforeRequest" : "${component.waitTimeBeforeRequest}","displayProductImages" : ${component.displayProductImages}}'>
		</div>
	</form>
</div>