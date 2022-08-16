ACC.subcriptionDetails = {

    bindAll: function ()
    {
        this.subscriptionPopup();
        this.subscriptionTabs();
        this.subscriptionActions();
    },

    subscriptionPopup: function () {
        if($(".js-cancel-subscription").length>0){

            $(document).on("click",".js-cancel-subscription",function(e){
                e.preventDefault();
                	var title = $(this).data("help");
                    ACC.colorbox.open(title, {
                    	onOpen: function(){
                            $("#colorbox").addClass("subscription-popup");
                        },
                        html: $("#cancel-subscription-confirm").html(),
                        width: "400px"
                    });
            })

            $(document).on("click","#cancel-subscription-confirm .r_action_btn",function(e){
                e.preventDefault();
                $.colorbox.close();
            })
        }
    },

    subscriptionTabs: function () {
        $(".account-upgrade-subscription .tabs").accessibleTabs({
            tabhead:'h2',
            fx:"show",
            autoAnchor:true,
            fxspeed:null
        });
    },

    subscriptionActions: function () {

        $(document).on("click", ".view-potential-upgrade-billing-details", function(){
            $self=$(this);
            var popupTitle = $(this).data("popupTitle");
            
            ACC.colorbox.open(popupTitle,{
                href:$self.data("url"),
                close:'<span class="glyphicon glyphicon-remove"></span>',
                maxWidth:"100%",
        		opacity:0.7,
        		width:"auto",
                onComplete: function(){
                    $.colorbox.resize();

                    if($("#addUpgradeButton").hasClass("not-upgradable")){
                        $("#upgrade-billing-changes .confirm").attr("disabled","disabled").addClass("not-upgradable")
                    }
                }
            })
        })

        $(document).on("click", "#upgrade-billing-changes .r_action_btn", function(e){
            e.preventDefault();
            $.colorbox.close();
        })
    }
};

$(document).ready(function () {
    ACC.subcriptionDetails.bindAll();
	    subscriptionchart(); 
		$(".donut-progress-bar").loading();
		function subscriptionchart() {
		$.fn.loading = function () {	
			$(this).each(function () {
				var $target  = $(this);
				var opts = {
				backgroundColor: $target.data('color') ? $target.data('color').split(',')[0] : DEFAULTS.backgroundColor,
				progressColor: $target.data('color') ? $target.data('color').split(',')[1] : DEFAULTS.progressColor,
				percent: $target.data('percent') ? $target.data('percent') : DEFAULTS.percent,
				duration: $target.data('duration') ? $target.data('duration') : DEFAULTS.duration
				};
				$target.append('<div class="background"></div><div class="rotate"></div><div class="left"></div><div class="right"></div><div><span></span></div>');
				$target.find('.background,.left').css('background-color', opts.backgroundColor);
				$target.find('.rotate,.right').css('background-color', opts.progressColor);	
				var $rotate = $target.find('.rotate');
				setTimeout(function () {	
					$rotate.css({
						'transition': 'transform ' + opts.duration + 'ms linear',
						'transform': 'rotate(' + opts.percent * 3.6 + 'deg)'
					});
				},1);		
				if (opts.percent > 50) {
					var animationRight = 'toggle ' + (opts.duration / opts.percent * 50) + 'ms step-end';
					var animationLeft = 'toggle ' + (opts.duration / opts.percent * 50) + 'ms step-start';  
					$target.find('.right').css({
						animation: animationRight,
						opacity: 1
					});
					$target.find('.left').css({
						animation: animationLeft,
						opacity: 0
					});
				} 
			});
		}
	}    
});
$(window).resize(function(){
	var colorBoxWidth = $('#colorbox').width();
	if(colorBoxWidth > "550") {
		$.colorbox.resize({
			width: "600"
		});
	}
	else {
		$.colorbox.resize();
		
	}
});