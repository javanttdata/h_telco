<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="upgradePreviewData" required="true" type="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="subscription" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/account"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<div id="upgrade-billing-changes">
	<div class="small_popup_content">
		<subscription:proposedBilling subProdData="${subProdData}" upgradeData="${upgradeData}" />
		<subscription:upgradePreview upgradePreviewData="${upgradePreviewData}" />

		<div class="actions">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-sm-push-6">
					<subscription:upgradeNowButtonForm />
				</div>
				<div class="col-xs-12 col-sm-6 col-sm-pull-6">
					<a class="btn btn-default btn-block closeColorBox" href="#">
						<spring:theme code="text.cancel" text="Cancel" />
					</a>
				</div>
			</div>
		</div>
	</div>
</div>
