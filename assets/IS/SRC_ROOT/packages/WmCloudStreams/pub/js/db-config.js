//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {

    $('input#dbEnable').click(function () {
        var enabled = this.checked;
        toggleSettings(enabled);
        $(this).attr('value', enabled);
    });
});

function toggleSettings(isEnabled) {
    var fields = $("input#perfEnabled, input#reportInterval, input#pubEvents");
    if (isEnabled) {
        fields.removeAttr('disabled').removeAttr('readonly');
    }
    else fields.attr('disabled', 'disabled').attr('readonly', 'readonly');
}