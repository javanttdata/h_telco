ACC.paymentInfo  = {
		_autoload: [
		    "accPaymentMethodFun"
        ],
		accPaymentMethodFun: function() {
			if ($('.acc-payment-method select[name=billTo_country]').val() == null) {
				$(".acc-payment-method #billingAddressForm").css('display','none');
			} else {

				$(".acc-payment-method #billingAddressForm").css('display','block');
			}
		}
};
$(document).ready(function () 
{
	$('.acc-payment-method select[name=billTo_country]').change(function() {
		ACC.paymentInfo.accPaymentMethodFun();
	});
   $(document).on("click", "#edit-with-subscriptions-account", function(){
   		$self=$(this);
        $.colorbox({
          href:$self.data("url"),
          close:'<span class="glyphicon glyphicon-remove"></span>',
          maxWidth:"100%",
  		  opacity:0.7,
  		  width:"auto",
  		  transition:"none",
          onComplete: function(){
              $.colorbox.resize();
          }
        });
   })
   $(document).on("click", "#editWithSubscriptions-manage", function(e){
       e.preventDefault();
	   if(isSessionAlive('../../'))
	   {
		   $self=$(this);
		   $.colorbox({
			   href:$self.data("url"),
			   close:'<span class="glyphicon glyphicon-remove"></span>',
	           maxWidth:"100%",
	      	   opacity:0.7,
	      	   width:"auto",
	      	   transition:"none",
			   onComplete: function(){
				   $.colorbox.resize();
			   }
		   });
	   }
	   else
	   {
		   location.reload();
	   }
   });

   $(document).on("click", "#payment-method-subscriptions .r_action_btn", function(e){
       e.preventDefault();
       $.colorbox.close();
   });
   
   $(document).on("click", "#payment-method-delete .r_action_btn", function(e){
       e.preventDefault();
       $.colorbox.close();
   });
   
   function isSessionAlive(prefix) {
   		var isAlive;
    	$.ajax({
			    url : prefix +"my-account/is-alive",
			    type: "GET",
			    async: false,
			    success: function(data, textStatus, jqXHR)
			    {
			        if(data == 'alive')
			        	{	
			        		isAlive = true;
			        	}
			        else
			        	{
				      	isAlive = false;
			        	}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	isAlive = false;
			    }
			});   
   		
   		return isAlive;
   }
   
   function submitSetDefault(id) {
		document.getElementById('setDefaultPaymentDetails'+id).submit();
   }
});