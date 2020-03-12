//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {
    //left/right styles don't apply for streaming providers table
    $('table#providersTable td:nth-child(1)').removeClass("left");
    $('table#providersTable td:nth-child(2)').removeClass("right");

    //validate required fields on save
    $('#btnSubmit').click(function (evt) {
        var result = validateFields();
        if (!result) {
            blockEvt(evt);
            alertUser();
        }
        var type = $("select[name='streaming.prov.authn.type']").val();
        var aliasVal;
        if (type === 'OAUTH_1') {
            aliasVal = $("select[name='temp.alias1']").val();
            $("input[name='streaming.prov.authn.alias']").val(aliasVal);
        }
        else if (type === 'OAUTH_2') {
            aliasVal = $("select[name='temp.alias2']").val();
            $("input[name='streaming.prov.authn.alias']").val(aliasVal);
        }
    });

    $("a.deleteConfig").click(function (evt) {
        var prov = $(this).attr('name');
        var delUrl = $(this).attr('href');

        var deleteProv = false;
        var genericDelFn = function () {
            return confirm(getmsg("delete.streaming.provider", prov));
        };

        //make an ajax call to find out if this provider is used by any subscribers
        $.get("getStreamingSubscribersUsingProvider.dsp?name=" + prov, function (data) {
            var xmldoc = $.parseXML(data.substr(data.indexOf("<result>")));
            var names = $(xmldoc).find("result").text();
            if ($.trim(names).length !== 0) {
                deleteProv = confirm(getmsg("confirm.delete.provider", prov, names));
            }
            else {
                deleteProv = genericDelFn();
            }
            if (deleteProv) {
                location.href = delUrl;
            }

        });
        blockEvt(evt);
    });

    //display the appropriate destination config details based on the selected destination type
    $("select[name='streaming.prov.authn.type']").change(function () {
        var type = $(this).val();
        var typeTarget;
        var oauthVersionTarget;
        $("div#authnConfig table").hide();
        $("table#oauthAliasCfg select").hide();
        if (type === 'BASIC') {
            typeTarget = $("table#basicAuthCfg");
        }
        else if (type === 'OAUTH_1') {
            typeTarget = $("table#oauthAliasCfg");
            oauthVersionTarget = $("select#oauthV1Aliases");
        }
        else if (type === 'OAUTH_2') {
            typeTarget = $("table#oauthAliasCfg");
            oauthVersionTarget = $("select#oauthV2Aliases");
        }
        else if (type === 'ESB_CALLBACK') {
            typeTarget = $('table#esbServiceCfg');
        }
        if (typeTarget != undefined){ 
			typeTarget.addClass("tableView");
			typeTarget.show();
		}
        if (oauthVersionTarget != undefined) oauthVersionTarget.show();
    });

});

function validateFields() {
    var nameEl = $("input[name='streaming.prov.name']");
    var isNameValid = validateName(nameEl);
    //also ensure name doesn't contain any of the disallowed chars
    if (isNameValid) {
        var badChar = checkValidChars(nameEl);
        if (badChar) {
            var msg = getmsg("name.bad.char", badChar);
            nameEl.after("<span class='errmsg'>" + msg + "</span>");
            isNameValid = false;
        }
        else $("~ .errmsg", nameEl).remove();
    }

    var isEndpointValid = validateName($("input[name='streaming.prov.endpoint']"));
    return isNameValid && isEndpointValid;
}
