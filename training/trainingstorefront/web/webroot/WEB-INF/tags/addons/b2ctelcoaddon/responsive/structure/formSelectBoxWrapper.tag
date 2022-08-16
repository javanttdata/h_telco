<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="idKey" required="true" type="java.lang.String"%>
<%@ attribute name="labelKey" required="true" type="java.lang.String"%>
<%@ attribute name="path" required="true" type="java.lang.String"%>
<%@ attribute name="mandatory" required="true" type="java.lang.Boolean"%>
<%@ attribute name="tabIndex" required="false" type="java.lang.String"%>
<%@ attribute name="items" required="true" type="java.util.List" %>
<%@ attribute name="disabled" required="false" type="java.lang.Boolean" %>
<%@ attribute name="skipBlankMessageKey" required="false" type="java.lang.String" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement"%>

<div class="col-xs-6">
	<formElement:formSelectBox idKey="${idKey}" selectCSSClass="form-control" labelKey="${labelKey}" path="${path}" mandatory="${mandatory}" skipBlank="false"
		skipBlankMessageKey="${skipBlankMessageKey}" items="${items}" tabindex="${tabIndex}" disabled="${disabled}" />
</div>


