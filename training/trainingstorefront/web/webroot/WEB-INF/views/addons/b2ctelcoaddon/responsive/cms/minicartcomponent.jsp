<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%--@elvariable id="totalDisplay" type="java.lang.String"--%>
<%--@elvariable id="totalItems" type="java.lang.Integer"--%>
<%--@elvariable id="component" type="de.hybris.platform.acceleratorcms.model.components.MiniCartComponentModel"--%>

<spring:htmlEscape defaultHtmlEscape="true"/>

<spring:theme code="popup.cart.empty" text="Your Cart is empty" var="emptyCartMessage"/>
<spring:theme code="basket.items" text="Items" var="itemsTitle"/>
<spring:theme code="text.cart" text="Cart" var="cartTitle"/>

<spring:url value="/cart/miniCart/{/totalDisplay}" var="refreshMiniCartUrl" htmlEscape="false">
   <spring:param name="totalDisplay" value="${ycommerce:encodeHTML(totalDisplay)}"/>
</spring:url>
<spring:url value="/cart/rollover/{/componentUid}" var="rolloverPopupUrl" htmlEscape="false">
   <spring:param name="componentUid" value="${ycommerce:encodeHTML(component.uid)}"/>
</spring:url>
<spring:url value="/cart" var="cartUrl"/>

<div class="nav-cart">
   <a href="${cartUrl}" class="mini-cart-link js-mini-cart-link" data-mini-cart-url="${rolloverPopupUrl}"
      data-mini-cart-refresh-url="${refreshMiniCartUrl}" data-mini-cart-name="${cartTitle}"
      data-mini-cart-empty-name="${emptyCartMessage}" data-mini-cart-items-text="${itemsTitle}">
      <div class="mini-cart-icon">
         <span class="glyphicon glyphicon-shopping-cart"></span>
      </div>
      <div class="mini-cart-count js-mini-cart-count">        
         <span class="nav-items-total">
         	<span class="items-mobile hidden-xs hidden-sm"><spring:theme code="text.minicart.message1" text="(you have " /></span>
        	<span class="updatedcartitem">${totalItems lt 100 ? totalItems : "99+"}</span>
        	<span class="items-desktop hidden-xs">&nbsp;${itemsTitle}</span>
         	<span class="items-mobile hidden-xs hidden-sm"><spring:theme code="text.minicart.message2" text="in your cart)" /></span>
         </span>         
      </div>
   </a>
</div>
<div class="mini-cart-container js-mini-cart-container"></div>
