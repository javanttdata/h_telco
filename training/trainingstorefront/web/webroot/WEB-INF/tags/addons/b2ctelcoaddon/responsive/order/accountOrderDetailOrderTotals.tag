<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/responsive/order" %>
<%@ taglib prefix="telco-order" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/order" %>
<%@ taglib prefix="telco-checkout-order" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/order"%>
<c:if test="${not empty order}">
    <div class="account-orderdetail">
        <div class="account-orderdetail__footer">
            <div class="row">
                <div class="col-sm-6 col-md-7 col-lg-8">
                    <order:appliedVouchers order="${order}" />
                    <telco-checkout-order:receivedPromotions order="${order}" />
                </div>
                <div class="col-sm-6 col-md-5 col-lg-4">
                    <telco-order:orderTotalsItem order="${order}" />
                </div>
            </div>
        </div>
    </div>
</c:if>