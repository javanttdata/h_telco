<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<spring:htmlEscape defaultHtmlEscape="true"/>
<div id="cart-error-pop" class="hidden">
    <div class="notification-popup-content">
        <div>
            <c:if test="${cartData.invalidMessages != null}">
                <p>${ycommerce:sanitizeHTML(cartData.invalidMessages)}</p>
            </c:if>
            <p>
                <spring:theme code="basket.page.message.howProceed" text="How do you wish to proceed?"/>
            </p>
        </div>
        <div>
            <button type="button" class="btn btn-block btn-default" onclick="jQuery.colorbox.close();">
                <spring:theme code="basket.page.message.returnCheckout" text="Return to Checkout"/>
            </button>
        </div>
    </div>
</div>
