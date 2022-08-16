<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/nav"%>
<%@ taglib prefix="telcoProduct" tagdir="/WEB-INF/tags/addons/b2ctelcoaddon/responsive/product"%>

<nav:pagination top="true" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
	searchUrl="${searchPageData.currentQuery.url}" numberPagesShown="${numberPagesShown}" />
<div class="tab-content">
   <div class="tab-pane" id="show_grid">
      <div class="product__listing product__list prod_grid_view" >
		   <c:forEach items="${searchPageData.results}" var="productData" varStatus="status">
			   <telcoProduct:productListerGridItem productData="${productData}" />
		   </c:forEach>
      </div>   
   </div>
   <div class="tab-pane" id="show_list">
      <div class="product__listing product__list prod_list_view" >
		   <c:forEach items="${searchPageData.results}" var="productData" varStatus="status">
			   <telcoProduct:productListerListItem productData="${productData}" />
		   </c:forEach>
      </div>
   </div>
</div>	
<nav:pagination top="false" supportShowPaged="${isShowPageAllowed}" supportShowAll="${isShowAllAllowed}" searchPageData="${searchPageData}"
	searchUrl="${searchPageData.currentQuery.url}" numberPagesShown="${numberPagesShown}" />
