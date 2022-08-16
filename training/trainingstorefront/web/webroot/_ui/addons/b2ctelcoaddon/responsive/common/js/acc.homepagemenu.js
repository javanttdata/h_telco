ACC.homepagemenu = {
		menutoggle: function (){
		      $('#signedInUserOptionsToggle').click(function (){
		    	  $(this).toggleClass('show');
		    	  $(".offcanvasGroup1").slideToggle(400);
		          if ($(this).hasClass('show')){
		              $(this).find('span').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
		          }
		          else {
		                $(this).find('span').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
		          }
		      });
		}		
};
$(document).ready(function (){    
	ACC.homepagemenu.menutoggle(); 
});