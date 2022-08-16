ACC.configurableguidedsellingaddon = {

    _autoload: [
        "initPageEvents"
    ],
    initPageEvents: function () { 
    	var pageURL = parseURL $(location). attr("href");
    	 var stepid = pageURL;
    	 if (stepid.indexOf('s') > -1)  {
    		 stepid = pageURL.split("/");
    	 }
    	 if (stepid.indexOf('d') > -1)  {
    		 stepid = pageURL.split("/");
    	 }
    	 
    	 stepid = stepid[stepid.length - 2];
    	 
    	 $('.step-content .tab-content .tab-pane').each(function() {
    		 if($(this).attr('id') == stepid) {
    			
    			 $(this).addClass('active');
 	    	}
 	    });
    	 
    	 var flag = false;
    	 $('.stepwizard .nav-tabs li').each(function() {
    		 var mainNavCopy = $(this).find('a');
    		 if(pageURL.indexOf(mainNavCopy.attr('href')) > -1) {
    			 $(this).addClass('active');
    		 }
    		 if($(this).is(".active")) { 
    			 flag = true;
    		 }
    		 if ( $(this).is(".complete") ) { 
    			 var completeText = "<span class='glyphicon glyphicon-ok-sign'></span>"; 
    			 $(this).find('a p').last().append(completeText); 	 
    		}
 	    });
    	 if(flag == false) { 
    		 $('.stepwizard .nav-tabs li').first().addClass('active');
		 }
    	 $(".tab-pane ul.product-list").each(function(){
 		    if ($(this).children('li').length < 1 ){
 		    	$(this).closest( ".tab-pane.active" ).css('display','none');
 		    }
    	 });
    	 var productListWidth = 0;
     	$(".tab-pane.active ul.product-list li").each(function() {      		
     		productListWidth += $(this).outerWidth();
     		$(this).closest( "ul" ).width(productListWidth+200);
     	});       	
     	var navTabWidth = 0;
    	$(".stepwizard .nav-tabs li").each(function() { navTabWidth += $(this).outerWidth(); });
    	$(".stepwizard .nav-tabs").width(navTabWidth+7);
    	
    	 $(".left-arrow").click(function() {
    		 $(this).parent().animate({scrollLeft: "-="+206});
    	 });
    	 $(".right-arrow").click(function(){
    		 $(this).parent().animate({scrollLeft: "+="+206});
    	 });
    }
};