ACC.modalDialog= {

    _autoload: [
        "bindDialogModal"
    ],

    bindDialogModal: function(){

        $(document).on("click",".modal-dialog", function(e){
            e.preventDefault();
            var po = $(this).data("miniCartSpo");
            var url = $(this).data("miniCartUrl") + "?spoCode=" + po;
            var cartName = ($(this).find(".js-mini-cart-count").html() != 0) ? $(this).data("miniCartName"):$(this).data("miniCartEmptyName");

            ACC.colorbox.open(cartName,{
                href: url,
                width:"80%",
                initialWidth :"80%",
                onComplete: function ()
                {
                    $(this).colorbox.resize();
                    ACC.product.bindToAddToCartForm();
                }
            });
        });

        $(document).on("click",".js-mini-cart-close-button", function(e){
            e.preventDefault();
            ACC.colorbox.close();
        });
    }
};
