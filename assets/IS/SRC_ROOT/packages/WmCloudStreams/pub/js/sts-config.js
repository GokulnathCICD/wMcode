//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

/**
 * @author mgunasek
 */

$(function() {
    $('table#stsConfigList td:nth-child(1)').removeClass("left");
    $('table#stsConfigList td:nth-child(2)').removeClass("right");

    //make an Ajax POST call to get the list of aliases for the chosen keystore
    $("select[name='ksHandle']").bind('change', function() {
        var sel = this.options[this.selectedIndex].text;

        $('div#busy').css('display', 'inline');   //show busy

        //get the pk aliases
        $.post("getAliasesForSTSKeyStore.dsp",
        {
            "action": "getPKAliases",
            "ksName": sel
        }, function(data) {
            $("select[name='signingAlias']").html(data);
        });

        //get the cert aliases
        $.post("getAliasesForSTSKeyStore.dsp",
        {
            "action": "getCertAliases",
            "ksName": sel
        }, function(data) {
            $("select[name='encryptionAlias']").html(data);
        });

        $('div#busy').css('display', 'none');   //hide busy
    });

    $('div#busy').hide(); //initially hidden

    $('a#deleteConfig').bind('click', function(e) {
        var isConfirmed = confirm(getmsg("delete.config"));
        if (!isConfirmed) {
            e.preventDefault();
        }
    });

    //toggle the select elements based on the checkbox selection
    var isSignInput = $("input[name='isSignRequest']");
    isSignInput.bind("click", function() {
        updateSignSelect(isSignInput[0]);
    });

    var isEncInput = $("input[name='isEncRequest']");
    isEncInput.bind("click", function() {
        updateEncSelect(isEncInput[0]);
    });

    updateSignSelect(isSignInput[0]);
    updateEncSelect(isEncInput[0]);

    //validate some fields on save
    $('#btnSubmit').click(function(evt) {
        var result = validateFields();
        if (!result) {
            evt.preventDefault();
            evt.stopPropagation();
        }
        updateButtons();
    });

});

function validateFields() {
    var stsNameEl = $("input[name='stsName']");
    var epEl = $("input[name='endpoint']");
    var isNameValid = checkStsName(stsNameEl);
    var isEprValid = checkSTSEndpoint(epEl);

    //since ws and http username are optional, check only if specified
    var isHttpUserValid = true;
    var httpUserEl = $("input[name='httpUser']");
    if ($.trim(httpUserEl.val()) != '') {
        isHttpUserValid = checkUsername(httpUserEl);
    }
    var wsUserEl = $("input[name='wsUser']");
    var isWsUserValid = true;
    if ($.trim(wsUserEl.val()) != '') {
        isWsUserValid = checkUsername(wsUserEl);
    }

    return isNameValid && isEprValid && isWsUserValid && isHttpUserValid;
}

function checkUsername(userEl) {
    var isValid = true;
    var ch = checkValidChars(userEl);
    if (ch!=undefined) {
        isValid = false;
        alert(getmsg("username.bad.char", ch));
    }
    return isValid;
}

function checkStsName(stsNameEl) {
    var isValid = validateName(stsNameEl);
    if (!isValid) {
        alert(getmsg("sts.name.missing"));
    }
    else {
        var msg= "sts.name.bad.char";
        var ch = checkValidChars(stsNameEl);
        if (ch!=undefined) {
            isValid = false;
            alert(getmsg(msg, ch));
        }
    }
    return isValid;
}

function checkSTSEndpoint(epEl) {
    var isValid = validateName(epEl);
    if (!isValid) {
        alert(getmsg("sts.epr.missing"));
    }
    else {
        var urlPattern = /https?:\/\/[\w\d\.-]{3,}:\d{2,5}/;
        isValid = validateName(epEl, urlPattern);
        if (!isValid) {
            alert(getmsg("url.invalid"));
        }
    }
    return isValid;
}

function updateSignSelect(inputEl) {
    var signAliasEl = $("select[name='signingAlias']").get(0);
    if (inputEl != null && inputEl != undefined) {
        if (inputEl.checked) {
            enableElement(0, signAliasEl);
        }
        else {
            disableElement(0, signAliasEl);
            $(this).after("<input type='hidden' name=" + inputEl.name + " value='false' />");
        }
    }
}

function updateEncSelect(inputEl) {
    var encAliasEl = $("select[name='encryptionAlias']").get(0);
    if (inputEl != null && inputEl != undefined) {
        if (inputEl.checked) {
            enableElement(0, encAliasEl);
        }
        else {
            disableElement(0, encAliasEl);
            $(this).after("<input type='hidden' name=" + inputEl.name + " value='false' />");
        }
    }
}

