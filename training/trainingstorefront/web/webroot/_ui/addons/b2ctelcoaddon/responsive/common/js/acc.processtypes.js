ACC.processTypes = {

    _autoload: [
        "bindProcessTypeSelection"
    ],

    bindProcessTypeSelection: function(){
        $('#tma-process-type-selection').on('change', function () {
            $('#tmaProcessTypeSelectionForm').submit();
        });
    }
};


