ACC.producttocarttabs = {

    bindAll: function ()
    {
        if($('.prod-add-to-cart').length>0){

        	 ACC.producttocarttabs.productTabs = $('.prod-add-to-cart .tabs').accessibleTabs({
                wrapperClass: 'content',
                currentClass: 'current',
                tabhead: 'h2',
                fx:'show',
                fxspeed: null,
                currentInfoText: 'current tab: ',
                currentInfoPosition: 'prepend',
                currentInfoClass: 'current-info',
                autoAnchor:true
            });

            $(".prod-add-to-cart .sub-tabs").accessibleTabs({
                wrapperClass: 'content',
                currentClass: 'sub-current',
                tabhead:'h3',
                tabbody:'.sub-tabbody',
                fx:'show',
                fxspeed: null,
                currentInfoText: 'current tab: ',
                currentInfoPosition: 'prepend',
                currentInfoClass: 'current-info',
                autoAnchor:true
            });

            $(".prod-add-to-cart td.item-only-add button").click(function(){
                $("#cart_popup div.title a h3").focus();
            });

            $(".prod-add-to-cart .delayed-button").click(function(){
                $('.prod-add-to-cart').delay('50').queue(function () {
                    $(this).find('button.delayed-button[type=submit]').prop("disabled", true).addClass("disabled").html("Please wait").delay('2000').queue(function() {
                        $(this).prop("disabled", false).removeClass("disabled").html("Add to cart").dequeue();
                    });
                    $(this).dequeue();
                });
            });
        }
        	
        this.openActiveTabs();
		this.tabDeviceLogic();
		this.contractDisableLogic();
        
    },

    openActiveTabs: function() {
    	$("a[href='"+"#"+$('#preselected').closest('div').prop('id')+"']").click();
        $("a#preselected_sub").parents('.sub-tabs').find('.sub-tabbody').hide();
        $("a#preselected_sub").trigger('click');
    },
    
    tabDeviceLogic: function() {
    	var subtabList = $(".prod-add-to-cart .sub-tabs .tabs-list li");
    	
    	var flag = true;
    	
    	$(".prod-add-to-cart .sub-tabs .tabs-list li").on('click', function(event){
    		    if(flag == true){
    		    	subtabList.css('display','block');
        		    flag = false;
    		    }
    		    else{
    		    	subtabList.css('display','none');
    		    	$(".prod-add-to-cart .sub-tabs .tabs-list li.sub-current").css('display','inline-block');
    		    	flag = true;
    		    }
    		    $('html').on('click',function() {
    		 		subtabList.css('display','none');
    		   		$(".prod-add-to-cart .sub-tabs .tabs-list li.sub-current").css('display','inline-block');
    		   		flag = true;
    		   	});
		   		event.stopPropagation();    		 	
        });
    	
    	$('.plan-tab-container ul').first().addClass('plan-tab-headings');
    	var scrollPos = 0;
    	document.addEventListener("click", function() {
    		scrollPos = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;
		}, true);
    	$('.plan-tab-headings a').each(function(index){
			$(this).click(function(evt){
				$("body,html").scrollTop(scrollPos);	
			});
    	});
    	$(".plan-tab-container ul.plan-tab-headings li").click(function () {
    		subtabList.css('display','none');
			$(".prod-add-to-cart .sub-tabs .tabs-list li.sub-current").css('display','inline-block');
    		$('.plan-tab-container ul.plan-tab-headings li').not(this).each(function(){
    	         $(this).removeClass('active current');
    	     });    	
    	});
    	$(".page-bundleselection-plan .plan-tab-container ul.plan-tab-headings li a").click(function () {
    		var myTabText=$(this).clone().children().remove().end().text();
    		
    		$('.sub-navigation-list li').each(function() {
    			var mainNavCopy = $(this).find('a');
    	    	if(mainNavCopy.attr('title').toUpperCase() == myTabText.toUpperCase()){
    	    		output = mainNavCopy.attr('href');
    	    	    var obj = { Page: "page", Url: output };
    		 		history.pushState(obj, obj.Page, obj.Url);
    		 		return false;
    	    	}
    	    });
    	    
    	});
    	enquire.register("screen and (max-width:789px)", function () {
    		$('.plan-tab-headings').owlCarousel({
				navigation:true,
				navigationText : ["<span class='glyphicon glyphicon-chevron-left'></span>", "<span class='glyphicon glyphicon-chevron-right'></span>"],
				pagination:false,
				itemsDesktop : [5000,7], 
				itemsDesktopSmall : [1200,5], 
				itemsTablet: [820,4], 
				itemsTabletSmall: [620,3],
				itemsMobile : [480,2]
			});
        });
    	enquire.register("screen and (min-width:789px)", function () {
        	if($(".circle-section").parents(".subscribe-section").length == 1 ) {
         	    $(".donut-section").find(".owl-item").removeAttr("style").addClass('donut-grid');        	
         	}
    		if($('.plan-tab-headings').data("owlCarousel")){
    			$('.plan-tab-headings').data("owlCarousel").destroy(); 
    		}
    	});
    	enquire.register("screen and (max-width:480px)", function () {	
			if(($('.owl-carousel .owl-item').children('#accessibletabsnavigation0-2.current').length > 0) || ($('.owl-item').children('#accessibletabsnavigation0-3.current').length > 0)) {	  
			    $('.owl-carousel .owl-wrapper').addClass('mobiscroll_1');		        
			}
			else if(($('.owl-carousel .owl-item').children('#accessibletabsnavigation0-4.current').length > 0) || ($('.owl-item').children('#accessibletabsnavigation0-5.current').length > 0)) {
			          $('.owl-carousel .owl-wrapper').addClass('mobiscroll_2');			        
			}
    	});
      	enquire.register("screen and (min-width:767px)", function () {			
    		if(($('.owl-carousel .owl-item').children('#accessibletabsnavigation0-4.current').length > 0) || ($('.owl-item').children('#accessibletabsnavigation0-5.current').length > 0)) {
		        $('.owl-carousel .owl-wrapper').addClass('tabscroll');			        
		     }			  
    	});
    	 window.onpopstate = function(event) {    
			if(event && event.state) {
			      location.reload(); 	      
			  }
		}
    },
    contractDisableLogic: function() {
   	 $(".sub-tabs .tabs-list").each(function(){
   		    if ($(this).children('li').length == 1 ){
   		    	$(this).children('li').addClass('disabled');
   		    }
   	 });
    }
};

$(document).ready(function (){    
      ACC.producttocarttabs.bindAll(); 
      var $syncsort = $(".syncsort").on('change', function() {
		     $syncsort.not(this).get(0).selectedIndex = this.selectedIndex;
      });
      $(".prod-add-to-cart").find("#plan-tab-container").each(function() {
	       ACC.producttocarttabs.contractDisableLogic();
	       ACC.producttocarttabs.tabDeviceLogic();
	       $(window).resize(larg);
	   });
	   function larg(){
	       ACC.producttocarttabs.tabDeviceLogic();
	   }
});