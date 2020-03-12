//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {

    //validate required fields on save
    $("#btnSubmit").click(function (evt) {
        //clear out dummy value before validation
	    //resetPasswordFields();
        var result = validateFields();
        if (!result) {
            blockEvt(evt);
            alertUser();
        }
    });

    $("input[name='oauthVersion']").click(function () {
        toggleV20Display(refreshTokenCheck[0]);
    });
	
	var refreshTokenCheck = $("input[name='refreshTokenCheck']");
    refreshTokenCheck.bind("click", function() {
        updaterefreshTokenCheck(refreshTokenCheck[0]);
    });
	
	toggleV20Display(refreshTokenCheck[0])
	updaterefreshTokenCheck(refreshTokenCheck[0])
});

//  Avoid short-cutting validation so that all incorrect fields are highlighted.
//  This is required because it's the validation method that highights.
function validateFields() {
	var rcCommon = validateCommonFields();
    var versionIs10a = ( getSelectedVersion() == 'V10a' );
    var rcVer = ( versionIs10a ) ? validateV10aFields() : validateV20Fields();
    return rcCommon && rcVer
}

function validateCommonFields() {
    var rc1 = validateName($("#aliasName"));
    var rc2 = validateName($("#providerId"));
    var rc3 = validateName($("#clientId"));
    //var rc4 = validateName($("#clientSecret"));
    var rc5 = validateName($("#accessToken"));
    return rc1 && rc2 && rc3 && rc5;
}

function validateV10aFields() {
    return validateName($("#accessTokenSecret"));
}

function validateV20Fields() {
    var rc1 = validateName($("#accessToken"));
	if ($("input[name='refreshTokenCheck']").prop("checked")) {
		var rc2 = validateName($("#refreshToken"));
		var rc3 = validateName($("#refreshUrl"));
		var rc4 = document.getElementById("refreshAccessType");
		var selectedValue = rc4.options[rc4.selectedIndex].value;
		if (selectedValue == "ESB")
		{
		var rc5=validateName($("#refreshRequestTypeCustomService"));
		return rc1 && rc2 && rc3 && rc5;
		}
		return rc1 && rc2 && rc3;
	}
  return rc1
}


function toggleV20Display(inputEl) {
    if (getSelectedVersion() == "V20") {
        $("#clientSecretSpan").removeClass('required').hide();
        $("#instanceUrlRow").show().removeClass('evenrow oddrow').addClass('evenrow');
		$("#refreshTokenCheck").show().removeClass('evenrow oddrow').addClass('oddrow');
        $("#accessTokenSecretRow").hide();
		if (inputEl.checked) {
            $("#refreshTokenRow").show().removeClass('evenrow oddrow').addClass('evenrow');
			$("#refreshUrlRow").show().removeClass('evenrow oddrow').addClass('oddrow');
			$("#refreshURLAccessType").show().removeClass('evenrow oddrow').addClass('oddrow');
			var refreshAccessValue = document.getElementById("refreshAccessType");
			var selectedValue = refreshAccessValue.options[refreshAccessValue.selectedIndex].value;
			if (selectedValue == "ESB")
			{
				target = $("table#esbConfig");
				target.addClass("tableView");
				target.show();
			}
        }
        else {
            $("#refreshTokenRow").hide();
			$("#refreshUrlRow").hide();
        }
	}
    else {
		$("#refreshTokenCheck").hide();
        $("#refreshTokenRow").hide();
        $("#refreshUrlRow").hide() ;
        $("#instanceUrlRow").hide();
		$("#refreshURLAccessType").hide();
		$("table#esbConfig").hide();
		$("#clientSecretSpan").addClass('required').show();
		$("table#esbConfig").removeClass("tableView");
		$("#accessTokenSecretRow").show().removeClass('evenrow oddrow').addClass('evenrow');

    }
}

function getSelectedVersion() {
    return $("input[name='oauthVersion']:checked").val();
}

function updaterefreshTokenCheck(inputEl) {
	if (inputEl != null && inputEl != undefined) {
        if (inputEl.checked) {
            $("#refreshTokenRow").show().removeClass('evenrow oddrow').addClass('evenrow');
			$("#refreshUrlRow").show().removeClass('evenrow oddrow').addClass('oddrow');
			$("#refreshURLAccessType").show().removeClass('evenrow oddrow').addClass('evenrow');
			$("#esbCustomService").show().removeClass('evenrow oddrow').addClass('oddrow');
			
			$("select[name='refreshAccessType']").change(function () {
				var type = $(this).val();
				var target;
				$("div#destinationConfig table").hide();
				if (type === 'ESB') {
					target = $("table#esbConfig");
					target.addClass("tableView");
				}
				if (target != undefined) target.show();
			});
			var refreshAccessValue = document.getElementById("refreshAccessType");
			var selectedValue = refreshAccessValue.options[refreshAccessValue.selectedIndex].value;
				if (selectedValue == "ESB")
				{
				target = $("table#esbConfig");
				target.addClass("tableView");
				target.show();
				}

        }
        else {
            $("#refreshTokenRow").hide();
			$("#refreshUrlRow").hide();
			$("#refreshURLAccessType").hide();
			$("table#esbConfig").hide();
			$("table#esbConfig").removeClass("tableView");
        }
    }
    
}

