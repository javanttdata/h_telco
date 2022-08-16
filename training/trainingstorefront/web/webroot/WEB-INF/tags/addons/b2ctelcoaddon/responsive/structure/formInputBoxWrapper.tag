<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="idKey" required="true" type="java.lang.String"%>
<%@ attribute name="labelKey" required="true" type="java.lang.String"%>
<%@ attribute name="path" required="true" type="java.lang.String"%>
<%@ attribute name="mandatory" required="false" type="java.lang.Boolean"%>
<%@ attribute name="tabIndex" required="false " type="java.lang.String"%>
<%@ attribute name="autocomplete" required="false" type="java.lang.String"%>

<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement"%>

<div class="form-group">
	<formElement:formInputBox idKey="${idKey}" labelKey="${labelKey}" path="${path}" inputCSS="form-control" mandatory="${mandatory}"
	 tabindex="${tabIndex}" autocomplete="${autocomplete}"  disabled="${disabled}"/>
</div>
