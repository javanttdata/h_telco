<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="order-entry" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/entry" %>
<%@ tag import="de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderCompositePriceData" %>
<%@ tag import="de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderOneTimeChargePriceData" %>
<%@ tag import="de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderPriceData" %>
<%@ tag import="de.hybris.platform.b2ctelcofacades.data.TmaAbstractOrderRecurringChargePriceData" %>
<%@ tag import="java.util.ArrayList" %>
<%@ tag import="java.util.List" %>

<%
    final List<TmaAbstractOrderRecurringChargePriceData> recurringCharges = new ArrayList<>();
    final List<TmaAbstractOrderOneTimeChargePriceData> oneTimeCharges = new ArrayList<>();

    if (orderEntry.getPrice() != null)
    {
        extractCharges(orderEntry.getPrice(), oneTimeCharges, recurringCharges);
    }
%>
<div class="item__price hidden-xs hidden-sm">
    <order-entry:otcpops oneTimeCharges="<%= oneTimeCharges %>"/>
    <order-entry:rcpops recurringCharges="<%= recurringCharges %>"/>
</div>

<div class="item__price pull-right visible-sm col-xs-6">
    <order-entry:otcpops oneTimeCharges="<%= oneTimeCharges %>"/>
    <order-entry:rcpops recurringCharges="<%= recurringCharges %>"/>
</div>

<div class="item__price visible-xs">
    <order-entry:otcpops oneTimeCharges="<%= oneTimeCharges %>"/>
    <order-entry:rcpops recurringCharges="<%= recurringCharges %>"/>
</div>
<%!
    private void extractCharges(final TmaAbstractOrderPriceData inputPop, final List<TmaAbstractOrderOneTimeChargePriceData>
            oneTimeCharges, final List<TmaAbstractOrderRecurringChargePriceData> recurringCharges)
    {
        if (inputPop instanceof TmaAbstractOrderCompositePriceData)
        {
            for (TmaAbstractOrderPriceData childPrice : ((TmaAbstractOrderCompositePriceData) inputPop).getChildPrices())
            {
                extractCharges(childPrice, oneTimeCharges, recurringCharges);
            }
        }
        if (inputPop instanceof TmaAbstractOrderOneTimeChargePriceData)
        {
            oneTimeCharges.add((TmaAbstractOrderOneTimeChargePriceData) inputPop);
        }
        if (inputPop instanceof TmaAbstractOrderRecurringChargePriceData)
        {
            recurringCharges.add((TmaAbstractOrderRecurringChargePriceData) inputPop);
        }
    }
%>
