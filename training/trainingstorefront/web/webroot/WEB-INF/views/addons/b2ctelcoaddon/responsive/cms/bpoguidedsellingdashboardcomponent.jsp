<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="bpo-dashboard" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/bpoguidedselling"%>
<spring:htmlEscape defaultHtmlEscape="true" />
<spring:url value="/cart/removeSpo" var="cartUpdateFormAction" htmlEscape="false" />

<div class="stepwizard">
	<div class="stepwizard-row setup-panel">
		<div class="left-arrow">
			<a href="#prev" class="glyphicon glyphicon-menu-left"></a>
		</div>
		<ul class="nav nav-tabs guided-tabs" role="tablist">
			<c:forEach var="dashboard" items="${dashboard.dashBoardEntries}" varStatus="loop">
				<c:choose>
					<c:when test="${not empty dashboard.dashBoardOrderEntries}">
						<c:set var="completedStep" value="complete" />
					</c:when>
					<c:otherwise>
						<c:set var="completedStep" value="" />
					</c:otherwise>
				</c:choose>
				<li role="presentation" class="${completedStep}"><bpo-dashboard:bpoGuidedSellingStepDetails
						dashboard="${dashboard}" loop="${loop}" /></li>
			</c:forEach>
		</ul>
		<div class="right-arrow">
			<a href="#next" class="glyphicon glyphicon-menu-right"> </a>
		</div>
	</div>
</div>
<div>
    <div class="step-content">
        <div>

            <div class="tab-pane" role="tabpanel">
                <div class="left-arrow">
                    <a href="#" class="glyphicon glyphicon-menu-left"></a>
                </div>

                <ul class="product-list">
                    <c:forEach var="dashboard" items="${dashboard.dashBoardEntries}">
                        <c:forEach var="dashBoardOrderEntry" items="${dashboard.dashBoardOrderEntries}">
                            <c:set var="entryNumber" value="${dashBoardOrderEntry.orderEntry.entryNumber}" />
                            <li class="product-item" id="${ycommerce:encodeHTML(dashboard.stepId)}"><a class="item-image"> <product:productPrimaryImage
                                    product="${dashBoardOrderEntry.orderEntry.product}" format="thumbnail" />
                            </a>
                                <div class="item-text">
                                    <div class="item-name">${ycommerce:encodeHTML(dashBoardOrderEntry.orderEntry.product.name)}</div>
                                    <div class="item-frequency">
                                        <div class="billing-event">
                                            <spring:theme code="entry.payoncheckout" text="Pay On Checkout:" var="billingTimeText"/>
                                                ${billingTimeText}
                                            <p>
                                                <format:price priceData="${dashBoardOrderEntry.orderEntry.totalPrice}"
                                                              displayFreeForZero="false" />
                                            </p>
                                            <c:if test="${(dashBoardOrderEntry.orderEntry.basePrice.value - dashBoardOrderEntry.orderEntry.totalPrice.value) > 0}">
                                                <del>
                                                    <p>
                                                        <format:price priceData="${dashBoardOrderEntry.orderEntry.basePrice}" displayFreeForZero="true" />
                                                    </p>
                                                </del>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="remove">
                                    <a href="#" id="${entryNumber}" class="submitSpoRemove">
                                        <span class="glyphicon glyphicon-remove-circle"></span>
                                    </a>
                                    <form:form id="deleteSpoForm${entryNumber}" action="${cartUpdateFormAction}" method="post"
                                               modelAttribute="updateQuantityForm${entryNumber}">
                                        <input type="hidden" name="entryNumber" value="${entryNumber}" />
                                        <input type="hidden" name="quantity" value="0" />
                                        <input type="hidden" name="groupId" value="${ycommerce:encodeHTML(dashboard.stepId)}" />
                                        <input type="hidden" name="bpoCode" value="${ycommerce:encodeHTML(bpoCode)}" />
                                        <input type="hidden" name="parentEntryNumber" value="${ycommerce:encodeHTML(parentEntryNumber)}" />
                                    </form:form>
                                </div>
                            </li>
                        </c:forEach>
                    </c:forEach>
                </ul>

                <div class="right-arrow">
                    <a href="#" class="glyphicon glyphicon-menu-right"> </a>
                </div>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>
</div>
