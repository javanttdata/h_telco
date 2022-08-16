ACC.guidedSelling = {

    bindAll: function ()
    {
        this.addAddons();
        this.dashboardMoreThenThreeLines();
        this.addDevice();
    },

    addAddons: function ()
    {
        if($('#box_expanded').length>0){
            var e=document.getElementById("refreshed");
            if(e.value=="no") {
                e.value="yes";
            }
            else {
                e.value="no";
                location.reload();
            };



            if ($("#globalMessages div.span-24 div").hasClass("negative")) {
                $(document).scrollTop(0).focus();
            }
            else {

                $(document).scrollTop( $("#box_expanded").focus().offset().top );
            };
        }
    },

    dashboardMoreThenThreeLines: function ()
    {
        if($('.dashboard').length>0){
            $('.dashboard div.dashboard-item:nth-child(3n)').addClass('row-extras');
            var count = $('.row-extras .dashboard-item-row-container').children().length;
            $('.row-extras .dashboard-item-row-container div.dashboard-item-row').hide();
            $('.row-extras .dashboard-item-row-container div.dashboard-item-row:lt(3)').show();
            var count_rest = count-3;
            if (count_rest > 0) {
                $('.row-extras').append('<div id="showall-extras"><div class="showall-extras-showing">Showing 3 of '+count+' Items</div><a href="#" id="showall-extras-showall">Show All</a></div>');
                $('.row-extras').append('<div id="hideall-extras"><a href="#" id="hideall-extras-hideall">Hide All</a></div>');
                $('#hideall-extras').hide();
                $('#showall-extras-showall').click(function() {
                    $('.row-extras .dashboard-item-row-container div.dashboard-item-row').show();
                    $('#showall-extras').hide();
                    $('#hideall-extras').show();
                });
                $('#hideall-extras-hideall').click(function() {
                    $('.row-extras .dashboard-item-row-container div.dashboard-item-row').hide();
                    $('.row-extras .dashboard-item-row-container div.dashboard-item-row:lt(3)').show();
                    $('#showall-extras').show();
                    $('#hideall-extras').hide();
                });
            }
        }
    },

    addDevice: function (){
        if($('.select-device').length>0) {
            $(".delayed-button").removeAttr("disabled")
            $(".delayed-button").click(function(event){
                event.preventDefault();
                var $this=$(this);
                $this.attr("disabled", "disabled").addClass("disabled").html("Please wait");

                setTimeout(function() {
                    $this.parents("form").submit();
                }, 200);
            });
        }
    }
};

$(document).ready(function ()
{
    ACC.guidedSelling.bindAll();
});
