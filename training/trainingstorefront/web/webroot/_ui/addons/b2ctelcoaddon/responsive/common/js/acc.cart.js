ACC.cartTelco = {
		
    submitBundleRemove: function(id) {
    	$("a").attr("href", "javascript:void(0);")
        $('#deleteBpoForm'+id).get(0).submit();
    },
    submitSpoRemove: function(id) {
    	$("a").attr("href", "javascript:void(0);")
		$('#deleteSpoForm'+id).submit();
	},
    
	submitRemove: function(id) {
    	$("a").attr("href", "javascript:void(0);")
		var productCode = $('#updateCartForm'+id).get(0).productCode.value;
		var initialCartQuantity = $('#updateCartForm'+id).get(0).initialQuantity.value;
		
		if(window.trackRemoveFromCart) {
			trackRemoveFromCart(productCode, initialCartQuantity);
		}

		$('#updateCartForm'+id+' input[name=quantity]').val(0);
		$('#updateCartForm'+id+' input[name=initialQuantity]').val(0);
		console.log($('#updateCartForm'+id+' input[name=quantity]').val());
		$('#updateCartForm'+id).submit();
	},

    showCartError: function () {
    	ACC.colorbox.open('Notification',{
            html: $("#cart-error-pop").html(),
            width:"600px",
            height:"265px"
        });
    }
};

$(document).ready(function(){
    /* Enable 'Add to cart' buttons after the whole page is loaded.
     * These buttons are initially disabled to prevent them from being clicked during page loading.
     * It causes redirection to json result instead of html */
    $('button.delayed-button[type=submit]').removeClass("disabled").enable(true);
    $(".submitRemoveBundle").click(function () {
    	var bpodetail = this.id
    	ACC.cartTelco.submitBundleRemove(bpodetail);
    });
    $(".submitSpoRemove").click(function () {
    	var spodetail = this.id
    	ACC.cartTelco.submitSpoRemove(spodetail);
    });
});
