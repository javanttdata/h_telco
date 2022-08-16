ACC.productshowall = {
		showproducts: function (){
			var activeTab = sessionStorage.getItem('activeTab');
			if (activeTab == 'show_grid' || activeTab === null ) {
				$('a.btn-grid.glyphicon-th-large,.prod_grid_view').parent().addClass("active");    
				$('a.btn-grid.glyphicon-th-list').parent().removeClass("active");
			}    
			else { 
				  $('a.btn-grid.glyphicon-th-list,.prod_list_view').parent().addClass("active");    
				  $('a.btn-grid.glyphicon-th-large').parent().removeClass("active");    
			}  
			$('a.btn-grid.glyphicon-th-large').click(function(){
				sessionStorage.setItem('activeTab', $(this).attr('name'));
				$('a.btn-grid.glyphicon-th-large,.prod_grid_view').parent().addClass("active");
				$('a.btn-grid.glyphicon-th-list,.prod_list_view').parent().removeClass("active");   
				ACC.productoffers.setgridheight();
			});
			$('a.btn-grid.glyphicon-th-list').click(function(){
				sessionStorage.setItem('activeTab', $(this).attr('name'));
				$('a.btn-grid.glyphicon-th-list,.prod_list_view').parent().addClass("active");
				$('a.btn-grid.glyphicon-th-large,.prod_grid_view').parent().removeClass("active");
			});
		}		
};
$(document).ready(function (){    
	ACC.productshowall.showproducts(); 
});