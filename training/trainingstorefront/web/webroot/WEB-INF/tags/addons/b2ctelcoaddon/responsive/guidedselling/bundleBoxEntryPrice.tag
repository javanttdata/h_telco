<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="bundleBoxEntry" required="true"
				  type="de.hybris.platform.b2ctelcofacades.data.BundleBoxEntryData" %>
<%@ attribute name="bundleNo" required="true" type="java.lang.String" %>
<%@ attribute name="bundleTemplateId" required="true" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<c:set value="${bundleBoxEntry.product.price.recurringChargeEntries.size()-1}" var="lastRecurringChargeIndex"/>
<c:set value="${bundleBoxEntry.product.price.recurringChargeEntries[lastRecurringChargeIndex]}"
		 var="lastRecurringCharge"/>

<div class="col-xs-8 col-sm-3 col-md-2 bundle-entry-price">
	<c:choose>
		<c:when test="${bundleBoxEntry.selected}">
			<c:forEach items="${bundleBoxEntry.orderEntry.orderEntryPrices}" var="orderEntryPrice">
				<c:if test="${orderEntryPrice.defaultPrice}">
					<p class="expand-price"><format:price priceData="${orderEntryPrice.totalPrice}"/></p>
					<p>
						<c:if test="${(orderEntryPrice.basePrice.value - orderEntryPrice.totalPrice.value) > 0}">
							<del><format:price priceData="${orderEntryPrice.basePrice}" displayFreeForZero="true"/></del>
						</c:if>
					</p>
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<p class="expand-price"><format:price priceData="${bundleBoxEntry.product.additionalSpoPriceInBpo}"/></p>
			<p>
				<c:if test="${(lastRecurringCharge.price.value - bundleBoxEntry.product.additionalSpoPriceInBpo.value) > 0}">
					<del><format:price priceData="${lastRecurringCharge.price}" displayFreeForZero="true"/></del>
				</c:if>
			</p>
		</c:otherwise>
	</c:choose>

	<div class="frequency">
		${ycommerce:encodeHTML(bundleBoxEntry.product.subscriptionTerm.billingPlan.billingTime.name)}
	</div>
</div>
