//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {
    //left/right styles don't apply for streaming subscribers table
    $('table#subscribersTable td:nth-child(1)').removeClass("left");
    $('table#subscribersTable td:nth-child(2)').removeClass("right");

    //validate required fields on save
    $('#btnSubmit').click(function (evt) {
        var result = validateFields();
        if (!result) {
            blockEvt(evt);
            alertUser();
        }
    });

    $("a.deleteConfig").click(function (evt) {
        var sub = $(this).attr('name');
        var result = confirm(getmsg("delete.streaming.subscriber", sub));
        if (!result) {
            blockEvt(evt);
        }
    });

    //disable fields if subscriber is not enabled
    var chkbox = $("input[name='streaming.sub.isenabled']");
    toggleFields(chkbox);

    chkbox.change(function () {
        toggleFields($(this));
    });

    //display the appropriate destination config details based on the selected destination type
    $("select[name='streaming.sub.dest.type']").change(function () {
        var type = $(this).val();
        var target;
        $("div#destinationConfig table").hide();
        if (type === 'ESB') {
            target = $("table#esbConfig");
        }
        else if (type === 'JOURNAL_LOG') {
            target = $("table#logConfig");
        }
        else if (type === 'JMS') {
            target = $("table#jmsConfig");
        }
        if (target != undefined){ 
			target.addClass("tableView");
			target.show();
		}
    });

    //enable request entity field only for PUT,POST,PATCH,OPTIONS methods
    $("select[name='streaming.sub.channel.method']").change(function () {
        var method = $(this).val();
        var isEntitySupported = (method == 'PUT' || method == 'POST' || method == 'PATCH' || method == 'OPTIONS');

        var ta = $("textarea[name='streaming.sub.channel.entity']");
        if (isEntitySupported) ta.removeAttr('disabled'); else ta.attr('disabled', 'disabled');
    });

    //handle http headers fields
    $(document).on("click", ".addHeaderImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            var newDiv = $("#headerTemplate").clone();
            newDiv.removeAttr("id");
            $(this).parent().after(newDiv);
            newDiv.show();
        }
    });

    $(document).on("click", ".removeHeaderImg", function () {
        var isDisabled = $(this).attr('disabled') !== undefined;
        if (!isDisabled) {
            $(this).parent().remove();
        }
    });

});

function toggleFields(chkBoxObj) {
    if (chkBoxObj !== undefined && chkBoxObj.length > 0) {
        var enabled = chkBoxObj.get(0).checked;
        var inputs = $("#mainCfg input[type!='hidden'], #mainCfg select, #mainCfg textarea");
        if (enabled) {
            inputs.not(chkBoxObj).each(function () {
                $(this).removeAttr('disabled');
            })
        }
        else inputs.not(chkBoxObj).each(function () {
            $(this).attr('disabled', 'disabled');
        });
    }
}

function validateFields() {
    var nameEl = $("input[name='streaming.sub.name']");
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

    var isProvValid = validateName($("select[name='streaming.sub.prov.name']"));
    
	
	//ESB Service Destination Configuration
	//To check non-empty service name.
	var nonEmptyService = true;
	var dest_type = $("select[name='streaming.sub.dest.type']");
    if(dest_type.val() === 'ESB'){
		var IS_Service = $("input[name='streaming.sub.dest.esb.service']");
		nonEmptyService = validateName(IS_Service);
	}
	
    return isNameValid && isProvValid && nonEmptyService;
}