//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

var gvars = {
    okImg:"/WmRoot/images/green_check.gif",
    notOkImg:"images/warn.gif"
};

$(function () {

    $("input[name='selectIPAddress']").click(function () {
        toggleIPAddresses(this);
        updateSaveStatus();
    });

    $("input[name='selectTokens']").click(function () {
        toggleTokens(this);
    });

    $("input[name='selectCert']").click(function () {
        toggleCert(this);
        updateSaveStatus();
    });

    //validate required fields on save
    $("#btnSubmit").click(function (evt) {
        var result = validateFields();
        if (!result) {
            blockEvt(evt);
            alertUser();
        }
    });

    updateEnabledFields();

    $(document).on("click", ".addTokenImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            var newDiv = $("#tokenDivTemplate").clone();
            newDiv.removeAttr("id");
            $(this).parent().after(newDiv);
            newDiv.show();
        }
    });

    $(document).on("click", ".removeTokenImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            $(this).parent().remove();
        }
    });

    $(document).on("click", ".addRangeImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            var newDiv = $("#ipRangeDivTemplate").clone();
            newDiv.removeAttr("id");
            $(this).parent().after(newDiv);
            newDiv.show();
        }
    });

    $(document).on("click", ".removeRangeImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            $(this).parent().remove();
            updateSaveStatus();
        }
    });

    $(document).on("blur", "#ipAddressContainer input", function () {
        //validate only when focus moves from 'to' field
        if ($(this).attr("name") === 'to') {
            validateIPRange($(this).parent());
        }
    });

    $(document).on("blur", "#certFileContainer input", function () {
        checkCertFile(this);
    });

});

function updateSaveStatus() {
    //enable 'save' button only if there are no bad IP values specified and no invalid cert file
    var enableIP = $("input[name='selectIPAddress']").get(0);
    var isIPOk = (!enableIP.checked) || (enableIP.checked && $("img.badIP").length == 0);

    var enableCert = $("input[name='selectCert']").get(0);
    var isCertOk = (!enableCert.checked) || (enableCert.checked && $('.certNotOk').length == 0);

    var enableSave = (isIPOk && isCertOk);
    updateSave(enableSave);
}

function validateIPRange(ipDiv) {
    $(ipDiv).find('.badIP, .goodIP').remove();
    updateSaveStatus();

    var inputs = $(ipDiv).find("input");
    var from = $(inputs.get(0)).val();
    var to = $(inputs.get(1)).val();
    if ($.trim(from).length != 0 && $.trim(to).length != 0) {
        //make an ajax request to do server side ip validation
        $.post('consumer-checkip.dsp', {'from': from, 'to': to}, function (data) {
            var result = $(data.substr(data.indexOf("<result>"))).html(); //get the <result> element content that holds the value

            if (result === 'false') {
                var msg = getmsg("invalid.ip");
                $(ipDiv).append("<img class='badIP' src='" + gvars.notOkImg + "'/><span class='badIP'>" + msg + "</span>");
            }
            else {
                $(ipDiv).append("<img class='goodIP' src='" + gvars.okImg + "'/>");
            }
            updateSaveStatus();
        });
    }
}

function checkCertFile(certInputEl) {
    var path = $(certInputEl).val();
    $(certInputEl).parent().find(".certOk, .certNotOk, .invalidCert").remove();
    updateSaveStatus();

    if ($.trim(path).length != 0) {
        $.post('consumer-checkcert.dsp', {'certFile': path}, function (data) {
            var result = $(data.substr(data.indexOf("<result>"))); //get the <result> element that holds the status
            var isValidCert = $(result).find("certValid");
            if (isValidCert.text() === 'true') {
                $(certInputEl).after("<img class='certOk' src='" + gvars.okImg + "'/>");
            }
            else {
                $(certInputEl).after("<img class='certNotOk' src='" + gvars.notOkImg + "'/>" +
                    "<span class='invalidCert'>" + $(result).find("errMsg").text() + "</span>");
            }
            updateSaveStatus();
        });
    }
}

function validateFields() {
    var nameEl = $("#name");
    var isValid = validateName(nameEl);
    if (isValid) {
        var badChar = checkValidChars(nameEl);
        if (badChar) {
			$("~ .errmsg", nameEl).remove();
            var msg = getmsg("name.bad.char",badChar);
            nameEl.after("<span class='errmsg'>" + msg + "</span>");
            isValid = false;
        }
        else $("~ .errmsg", nameEl).remove();
    }
    return isValid;
}

function toggleIPAddresses(chkBoxEl) {
    toggleEnabled(chkBoxEl, $("#ipAddressContainer input, #ipAddressContainer img"));
}

function toggleTokens(chkBoxEl) {
    toggleEnabled(chkBoxEl, $("#tokensContainer input, #tokensContainer img"));
}

function toggleCert(chkBoxEl) {
    toggleEnabled(chkBoxEl, $("#certFileContainer input"));
}

function updateEnabledFields() {
    toggleIPAddresses($("input[name='selectIPAddress']").get(0));
    toggleTokens($("input[name='selectTokens']").get(0));
    toggleCert($("input[name='selectCert']").get(0));
}


