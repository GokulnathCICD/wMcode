//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {
    //styles don't apply for streaming providers table
    $('table#providersTable td:nth-child(1)').removeClass("left");
    $('table#providersTable td:nth-child(2)').removeClass("right");

    //validate required fields on save
    $('#btnSubmit').click(function (evt) {
        var result = validateFields();
        if (!result) {
            blockEvt(evt);
            alertUser();
        }
    });

    $("a.deleteConfig").click(function (evt) {
        var prov = $(this).attr('name');
        var result = confirm(getmsg("delete.streaming.provider", prov));
        if (!result) {
           blockEvt(evt);
        }
    });

});

function validateFields() {
    var isNameValid = validateName($("input[name='streaming.prov.name']"));
    var isEndpointValid = validateName($("input[name='streaming.prov.endpoint']"));
    return isNameValid && isEndpointValid;
}