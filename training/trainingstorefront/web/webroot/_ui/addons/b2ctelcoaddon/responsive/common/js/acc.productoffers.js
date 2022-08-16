ACC.productoffers = {
    _autoload: [
        "bindOffers"  	
    ],

    bindOffers: function(){
        $('#subscription-selection').on('change', function () {
            var url = this.value;
            var offeringsPanel = $(".device-only-panel:eq(0)");
            offeringsPanel.html(ACC.productoffers.createCenterAlignedLabel('Loading offerings...'));
            $.ajax({
                url: url,
                cache: false,
                type: 'GET',
                success: function (response) {
                    setTimeout(function () {
                        offeringsPanel.html(response);
                        ACC.product.enableAddToCartButton();
                        ACC.product.bindToAddToCartForm();
                    }, 100);
                },
                error: function () {
                    offeringsPanel.html(ACC.productoffers.createCenterAlignedLabel('No offerings available.'));
                }
            });
        });
    },
    setgridheight: function () {
      $(".serviceplan-product").removeAttr("style");	
  	  $('.product_wrapper').each(function(){  
    		var jmediaquery = window.matchMedia( "(min-width: 640px)" )
      		if (jmediaquery.matches) {
      		    var $columns = $('.serviceplan-product',this);
    		     var maxHeight = Math.max.apply(Math, $columns.map(function(){
    		         return $(this).height();
    		     }).get());
    		     $columns.height(maxHeight); 
      		}
  	  });
    },
    createCenterAlignedLabel: function(message){
        return "<div class='centerAligned'><label>"+message+"</label></div>";
    }
};

$(document).ready(function (){    
	ACC.productoffers.setgridheight(); 
});