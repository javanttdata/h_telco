<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="variantCategory" required="true"
              type="de.hybris.platform.commercefacades.product.data.VariantMatrixElementData" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="telcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product" %>

<div class="variant-details">
    <strong>${fn:escapeXml(variantCategory.parentVariantCategory.name)}:</strong>
    <span> ${fn:escapeXml(variantCategory.variantValueCategory.name)}</span>
</div>
