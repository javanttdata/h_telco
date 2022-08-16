<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true"/>


<div class="cart-header">
    <div class="row">
        <div class="col-xs-12 col-sm-10">
            <div class="notification">
                <div class="notification-headline">
                    <div class="notification-emark"></div>
                    <div class="notification-headline-text">
                        <h2>
                            <spring:theme code="basket.page.notification" text="Notification"/>
                        </h2>
                    </div>
                </div>

                <c:forEach var="invalidMessage" items="${cartData.invalidMessages}">
                    <div class="notification-content">
                        <p>
                                ${invalidMessage}
                        </p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
