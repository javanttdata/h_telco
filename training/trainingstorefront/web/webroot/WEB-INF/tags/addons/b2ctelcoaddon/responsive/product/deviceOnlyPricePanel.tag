<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="guidedselling" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/guidedselling" %>
<%@ taglib prefix="price" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/price" %>

<spring:htmlEscape defaultHtmlEscape="true"/>
<div class="device-only-panel">
    <div class="device-only-title">
        <h3><spring:theme code="product.deviceOnly" text="Device Only"/></h3>
    </div>
    <div class="device-only-body">
        <span class="device-only-price">
           <price:payNowPop priceData="${product.price}"/>
        </span>
        <hr/>
        <spring:theme code="product.deviceOnly.body" text="Carrier Free"/>
    </div>

    <guidedselling:addSpoToCartForm product="${product}" processType="DEVICE_ONLY"/>
</div>
