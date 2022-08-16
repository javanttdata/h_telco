<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="subProdData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ attribute name="upgradeData" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<spring:htmlEscape defaultHtmlEscape="true" />
<div class="change-compare clearfix">
	<div class="payment-box">
		<div class="title">
			<spring:theme code="text.account.upgrade.currentPlan" text="Proposed Billing Changes" />
		</div>
		<div class="plan">${ycommerce:encodeHTML(subProdData.name)}</div>
		<div class="term">${ycommerce:encodeHTML(subProdData.subscriptionTerm.name)}</div>
	</div>

	<div class="payment-box right">
		<div class="title">
			<spring:theme code="text.account.upgrade.upgradePlan" text="Proposed Billing Changes" />
		</div>
		<div class="plan">${ycommerce:encodeHTML(upgradeData.name)}</div>
		<div class="term">${ycommerce:encodeHTML(upgradeData.subscriptionTerm.name)}</div>
	</div>
</div>