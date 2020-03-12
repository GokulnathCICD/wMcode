/*
 * Copyright © 1996 - 2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
 */

// validates form inputs and throws error if any input missing for required fields
var requiredMetaFields = new Array();
var hostname = "";

function isValidForm() {
    updateParametersValue();
    if (missingFields.length > 0) {
		var missingRequiredFieldsError = getmsg("missing.required.field");
        var err = getErrorMessage(getmsg("missing.input.caption"), missingRequiredFieldsError + fieldsDisplayName(paramsDisplayNameArray, missingFields));
        errorMessageToggle(err, "show");
        return false;
    } else
        return true;
}
// Resize the IFrame according to the contents of the popup
function resizeFrame() {
    var body = document.body,
        html = document.documentElement;
    var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);
    if (height > 300) {
        height = 300;
    }
    parent.resizeIframe(height);
}

function closeIFrame(parent) {
    parent.showSuccessInfo();
    parent.document.getElementById("closeIFrameWindow").click();
}

function getParentPageElementByName(elementName) {
    return parent.document.getElementsByName(elementName)[0];
}

function fieldsDisplayName(paramsDisplayNameArray, missingFields) {
    var missingRequiredFields = [];
	
	var reqFields = requiredMetaFields.concat(parent.requiredFields);

    missingFields.forEach(function(missingField) {
        reqFields.forEach(function(requiredField) {

            if (requiredField.endsWith(missingField)) {
                var displayName = paramsDisplayNameArray[missingField].replace(/\*$/, '');
                missingRequiredFields.push(displayName);

            } else if (missingField.startsWith("jwt")) {
                var arr = missingField.split("."); // Split the string using dot as separator
                if (requiredField.endsWith(arr.pop())) {
                    var displayName = paramsDisplayNameArray[missingField].replace(/\*$/, '');
                    missingRequiredFields.push(displayName);
                }
            }
        });

    });
    return missingRequiredFields.join(", ");
}

function setParentFormFieldValue(fieldName, val) {
    if (val != undefined || val != 'undefined' || val != '') {
        getParentPageElementByName(fieldName).value = val;
    }
}

function triggerPasswordChangeEvent(passwordElement) {
    passwordElement.dispatchEvent(new Event('change'));
}

function errorMessageToggle(htmlText, cmd) {
    if (cmd == "hide") {
        $("#err_message_span").html("");
        $("#err_message_span").hide();
    } else {
        $("#err_message_span").html(htmlText);
        $("#err_message_span").show();
    }
}

function getErrorMessage(error, error_description) {
    return "<b>" + getmsg("error.caption") + error + ". " + getmsg("description.caption") + error_description + "</b>";
}

function getErrorRowTR() {
    return "<tr id='status'><td colspan=8 name='err_message_span' class='error' style='text-align: left; padding-left: 35pt;' id='err_message_span'></td></tr>";
}

function setHostname(hostname) {
	this.hostname = hostname.toLowerCase();
}

function getRedirectUri() {
	if(!hostname) {
		hostname =  location.hostname;
	}
    redirect_uri = location.protocol + "//" + hostname + (location.port ? ':' + location.port : '') + "/WmCloudStreams/oauth-redirect.dsp";
    return redirect_uri;
}

function pushFieldValue(map, key, value, fieldName) {
    if (value == null || value == "") {
		var reqFields = requiredMetaFields.concat(parent.requiredFields);
		var isRequired = reqFields.find(function(element) {
			return element.endsWith(fieldName);
		});

		if(isRequired) {
			if (fieldName != null || fieldName != "") {
				missingFields.push(fieldName);
			} else {
				missingFields.push(key);
			}
        }
    } else {
        map.push({
            'name': key,
            'value': value
        });
    }
}

function replaceServerURLInstance(sourceUrl, targetUrl) {
	var finalUrl = "";
    if (sourceUrl && targetUrl) {
        if (isUrlValid(sourceUrl)) {
			finalUrl = sourceUrl + targetUrl.substring(getPosition(targetUrl, "/", 3), targetUrl.length);
        }
    }
	if(isUrlValid(finalUrl))
		return finalUrl;
    
	return targetUrl;
}

function getPosition(string, subString, index) {
   return string.split(subString, index).join(subString).length;
}

function getAnchorElement(href) {
    var loc = document.createElement("a");
    loc.href = href;
    return loc;
}

function isUrlValid(urlInput) {
    var res = urlInput.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    if (res == null)
        return false;
    else
        return true;
}