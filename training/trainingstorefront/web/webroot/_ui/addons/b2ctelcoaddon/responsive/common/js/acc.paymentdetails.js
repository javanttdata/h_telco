ACC.paymentDetailsTelco = {

    bindAll: function ()
    {
        $('#selectall').prop('checked', true);

        $('#selectall').click(function(event) {  //on click for the selectall checkbox

             $('input:checkbox').not(this).prop('checked', this.checked);

          });

        $('input:checkbox').click(function(event) {  //on click for any checkbox other than the selectall checkbox

            if( $('#selectall').prop("checked") && $(this).prop("checked")==false)
            {
                 $('#selectall').prop('checked', false);
            }

          if($('input:checkbox').not($('#selectall')).not(':checked').length == 0)
            {
             $('#selectall').prop('checked', true);
            }

        });
        $(".subscriptions-table input[name='subscriptionsToChange']").click(function() {
      	  var pm = document.getElementById("change-pm").value; 
      	  var checked = $('.subscriptions-table').find(':checked').length;
      	  var button = document.getElementById("button-change-to");
	      	  if (!checked || pm == "") {
	      		 button.disabled = true;
	      	  }
      		  else {
      	         button.disabled = false;
      		  }
      	});
        $(".action-links.edit-payment").click(function () {
	    	var pmdetail = this.id
	        ACC.paymentDetailsTelco.submitEditPaymentInfo(pmdetail);
	    });
        $(document).on("change", "#change-pm", function () {
      	  var button = document.getElementById("button-change-to");
          var pm = document.getElementById("change-pm").value;
          var checked = $('.subscriptions-table').find(':checked').length;
	          if(pm == "" || checked <= 0) {
	          	button.disabled = true;
	          } 
	          else {
	          	button.disabled = false;
	          }
      });
    },
    submitEditPaymentInfo: function(id) {
    	$("a").attr("href", "javascript:void(0);")
        $('#formEditpaymentInfo'+id).get(0).submit();
    },    
    checkContractDuration: function() {
    	var id = $('.subscriptions-table tr.chekduration').attr('id');
    	var row = $('.subscriptions-table #extend-subscription-form');
    	    if (id == "No Contract") {   
      	      $(row).find('.sub_contract').prop("disabled",true);
      	    }
      	    else {
      	      $(row).find('.sub_contract').prop("disabled",false);   
            }
    }
};

$(document).ready(function () {
		    ACC.paymentDetailsTelco.bindAll();
			with (ACC.paymentDetailsTelco)
			{
				checkContractDuration();
			}
});