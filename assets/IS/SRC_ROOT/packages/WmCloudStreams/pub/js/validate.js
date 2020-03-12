//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

var disallowedChars = /^[^- #&@^!%*:$./\\`;,~+=)(}{\][><"?]+$/;

//validate the given jquery element using the optional regex expression to match;
//if regex is not provided, check if value of element is ''; if result is false mark invalid,
//else mark as valid
function validateName(jqObj) {
    var isValid = true;
    var val = jqObj.val();
    var regxObj = arguments[1];
    if (regxObj != undefined && regxObj != null) {
        isValid = regxObj.test(val);
    }
    else isValid = ($.trim(val) != '');

    if (isValid) {
        markValid(jqObj);
    } else {
        markInvalid(jqObj);
    }
    return isValid;
}

//check if given jquery obj element value contains any of the disallowed chars
//if yes returns the first occurrence of the bad char
function checkValidChars(jqObj) {
    var badCh = undefined;
    var isValid = validateName(jqObj, disallowedChars);
    if (!isValid) {
        var input = $(jqObj).val();
        var badChPos = input.search(/[- #&@^!%*:$./\\`;,~+=)(|}{\][><"?]+/);
        badCh = input.charAt(badChPos);
    }
    return badCh;
}

//utility function that disables the given field; also resets the field if previously marked invalid
function disableField(index, el) {
    markValid(el);
    disableElement(index, el);
}

//mark the given dom element as invalid by adding optional 2nd argument css class or 'invalid'
function markInvalid(el) {
    var cssClass = arguments[1];
    if (cssClass == undefined || cssClass == null) cssClass = 'invalid';
    if (el != undefined && el != null) {
        $(el).addClass(cssClass);
    }
}

//mark the given dom element as valid by removing the optional 2nd argument css class or 'invalid'
function markValid(el) {
    var cssClass = arguments[1];
    if (cssClass == undefined || cssClass == null) cssClass = 'invalid';
    if (el != undefined && el != null) {
        $(el).removeClass(cssClass);
    }
}

//confirms the wire logging enablement 
function confirmWireLogging()
{
	var wireLogCheckBox = document.getElementById("wirelog");
	if(wireLogCheckBox.checked==true){
		var message = getmsg("log.enable.warning");
		//alert(message);
		var retVal = confirm(message);
		if(retVal == true){			
			return true;
		}else{		
			wireLogCheckBox.checked = false;
			return false;
		}
	}
 
}

//confirms the large binary stream enablement 
function confirmLargeBinaryStream()
{
	var binaryStreamEnabled = document.getElementById("binaryStreamEnabled");
	if(binaryStreamEnabled.checked==true){
		var message = getmsg("largeStream.enable.warning");
		//alert(message);
		var retVal = confirm(message);
		if(retVal == true){			
			return true;
		}else{		
			binaryStreamEnabled.checked = false;
			return false;
		}
	}
 
}