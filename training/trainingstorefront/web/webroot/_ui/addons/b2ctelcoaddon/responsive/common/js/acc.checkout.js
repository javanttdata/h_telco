ACC.checkoutTelco = {
bindCheckO :function ()
{
	var cartEntriesError = false;
	
	// Alternative checkout flows options
	$('.doFlowSelectedChange').change(function ()
	{
		if ('multistep-pci' == $('#selectAltCheckoutFlow').val())
		{
			$('#selectPciOption').show();
		}
		else
		{
			$('#selectPciOption').hide();

		}
	});

	$('.js-continue-shopping-button').click(function ()
	{
		var checkoutUrl = $(this).data("continueShoppingUrl");
		window.location = checkoutUrl;
	});
	
	$('.js-create-quote-button').click(function ()
	{
		$(this).prop("disabled", true);
		var createQuoteUrl = $(this).data("createQuoteUrl");
		window.location = createQuoteUrl;
	});

	
	$('.expressCheckoutButton').click(function()
			{
				document.getElementById("expressCheckoutCheckbox").checked = true;
	});
	
	$(document).on("input",".confirmGuestEmail,.guestEmail",function(){
		  
		  var orginalEmail = $(".guestEmail").val();
		  var confirmationEmail = $(".confirmGuestEmail").val();
		  
		  if(orginalEmail === confirmationEmail){
		    $(".guestCheckoutBtn").removeAttr("disabled");
		  }else{
		     $(".guestCheckoutBtn").attr("disabled","disabled");
		  }
	});
	
	$('.js-continue-checkout-button').click(function ()
	{
		var checkoutUrl = $(this).data("checkoutUrl");
		
		
		
		if($( "#invalid-bundle-wizard" ).hasClass( "invalid-bundle-wizard" )){
			ACC.cartTelco.showCartError();
			return false;
		}
		
		cartEntriesError = ACC.pickupinstore.validatePickupinStoreCartEntires();
		if (!cartEntriesError)
		{
			var expressCheckoutObject = $('.express-checkout-checkbox');
			if(expressCheckoutObject.is(":checked"))
			{
				window.location = expressCheckoutObject.data("expressCheckoutUrl");
			}
			else
			{
				var flow = $('#selectAltCheckoutFlow').val();
				if ( flow == undefined || flow == '' || flow == 'select-checkout')
				{
					// No alternate flow specified, fallback to default behaviour
					window.location = checkoutUrl;
				}
				else
				{
					// Fix multistep-pci flow
					if ('multistep-pci' == flow)
					{
					flow = 'multistep';
					}
					var pci = $('#selectPciOption').val();

					// Build up the redirect URL
					var redirectUrl = checkoutUrl + '/select-flow?flow=' + flow + '&pci=' + pci;
					window.location = parseUrl(redirectUrl);
				}
			}
		}
		
		return false;
	});

}
};
ACC.checkout.bindCheckO = ACC.checkoutTelco.bindCheckO;