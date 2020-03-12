/*
 * Copyright © 1996 - 2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
 */
var connection_provider_url_name = "CPROP$connection$Basic$cn.providerUrl";
var connection_jwt_issuer = "CPROP$oauth_v20_jwt$Basic$oauth_v20.iss";
var connection_jwt_subject = "CPROP$oauth_v20_jwt$Basic$oauth_v20.sub";
var jwtclaim_iss = "jwt.claim.iss";
var jwtclaim_sub = "jwt.claim.sub";
var keystore_alias_field = "pg.keystore.keyStoreHandle";
var key_alias_field = "pg.rampartdeploymenthandler.signingCertAlias";
var issuerLabel = "";

var authorizationServerUrl = "";
var authenticationServerUrl = "";
var missingFields = [];
var headers = [];
var headersMap = [];
var claims = [];
var claimsMap = [];
var paramsDisplayNameArray = {};
var keyStoreAlias = "";
var keyAlias = "";
var proxyAlias = "";
var accessTokenJSONResponse = null;

$(document).ready(function() {

    buildTableContent();
	checkAuthorizeSettings();
    resizeFrame();
    fetchParentTableOAuthFields();
    errorMessageToggle("", "hide");

    //make an Ajax POST call to get the list of aliases for the chosen keystore
    $("select[name='" + keystore_alias_field + "']").bind('change', function() {
        var sel = this.options[this.selectedIndex].text;

        if (sel !== "") {
            $('div#busy').css('display', 'inline'); //show busy

            $.post("getAliases.dsp", {
                "action": "getAliases",
                "keyStore": sel
            }, function(data) {
                var options = data.substr(data.indexOf("<option>"));
                $("select[name='" + key_alias_field + "']").html(options);
                $('div#busy').css('display', 'none'); //hide busy
            });
        } else {
            //remove the alias select options
            $("select[name='" + key_alias_field + "'] > option").each(function() {
                if ($(this).val() !== "") $(this).remove();
            });
        }
    });

    // Access Token
    $("#getToken").click(function() {
        if (isValidForm()) {
            invokeService();
        }
    });
	// Authorize
    $("#authorize").click(function() {
        if (getIssuer()) {
            var window_settings = 'location=yes,height=480,width=800,scrollbars=yes,status=yes';
            childWindow = window.open(constructAuthorizationUrl(), '_blank', window_settings);
        } else {
			alert(getmsg("missing.required.field") + issuerLabel);
		}
    });
});


// function which builds the table form with meta fields from OAuth 2.0 (JWT Flow) connection group
function buildTableContent() {
    issuerLabel = getParentPageElementByName(connection_jwt_issuer).parentNode.parentNode.cells[0].innerHTML;
    var subjectLabel = getParentPageElementByName(connection_jwt_subject).parentNode.parentNode.cells[0].innerHTML;
    paramsDisplayNameArray[jwtclaim_iss] = issuerLabel;
    paramsDisplayNameArray[jwtclaim_sub] = subjectLabel;

    var tableRows = getErrorRowTR(); // add error row
    tableRows += "<tr><td class=heading colspan=2>Claims</td></tr>";
    tableRows += "<tr><td>" + issuerLabel + "</td><td><input id='" + jwtclaim_iss + "' size=60 name='" + jwtclaim_iss + "' ><input id=authorize type=button value=Authorize /><div id='redirect'><b>" + getRedirectUri() + "</b><br><small>" 
			+ getmsg("redirect.uri.note") +"</small></div></td></tr>";
    tableRows += "<tr><td>" + subjectLabel + "</td><td><input id='" + jwtclaim_sub + "' size=60 name='" + jwtclaim_sub + "' ></td></tr>";

    var elements = parent.document.getElementsByClassName('meta');
    for (var i = 0; i < elements.length; i++) {
        var elementDisplayName = $(elements[i]).find(':first-child')[0];
        var element = $(elements[i]).find(':last-child')[1];
        var elementName = element.name;
        paramsDisplayNameArray[elementName] = elementDisplayName.innerHTML;

        if ($(element).attr("name") == 'jwt.authorizationServerUrl') {
            authorizationServerUrl = $(element).val();
            continue;
        } else if ($(element).attr("name") == 'jwt.authenticationServerUrl') {
            authenticationServerUrl = $(element).val();
            continue; // no need to add the URLs to the form table
        }

        if (elementName.startsWith("jwt.header")) {
            headers.push(elementName);
        } else if (elementName.startsWith("jwt.claim")) {
            claims.push(elementName);
        }
        // add only if meta field user input is required
        if ($(element).attr('type') == 'hidden') {
            tableRows += '<tr style="display: none;">' + elements[i].innerHTML + '</tr>';
        } else {
            tableRows += '<tr>' + elements[i].innerHTML + '</tr>';
        }
		if ($(element).attr('type') == 'password') {
            $(element).val('');
        }

    }

    var tableRef = document.getElementById('mainTable');
    tableRef.innerHTML = tableRows; // Insert OAuth fields rows
}

function checkAuthorizeSettings() {
	if(!authorizationServerUrl) {
		$("#authorize").hide();
		$("#redirect").hide();
	}
}

function constructAuthorizationUrl() {
    var authorization_url = authorizationServerUrl;
    return authorization_url + "?response_type=code&" + "client_id=" + getIssuer() + "&redirect_uri=" + getRedirectUri();
}

function getIssuer() {
	return $("[name='" + jwtclaim_iss + "']").val();
}

// invokes service with request body parameters (headers and claims array) with keystore details. 
// The service creates an encrypted token and send it to JWT Token server (authenticationServerUrl)
function invokeService() {

    var requestParams = {
        authenticationServerUrl: authenticationServerUrl,
        headers: headersMap,
        claims: claimsMap,
        keyStoreAlias: keyStoreAlias,
        keyAlias: keyAlias,
        proxyAlias: proxyAlias
    }

    $.ajax({
        type: 'POST',
        url: '/invoke/cloudstreams.oauth:jsonWebTokenFlow',
        data: JSON.stringify(requestParams),
        //dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        accepts: {
            text: "application/json"
        },
        async: false,
        success: function(data) {
            var closeOnSuccess = false;
            var failureMessage = "";
            $.each(data, function(key, value) {
                if (key == 'status' && value == 200) {
                    closeOnSuccess = true;
                }
                if (key == 'JSONResponse') {
                    accessTokenJSONResponse = JSON.parse(value);
                }
            });
            if (closeOnSuccess) {
                updateResponseFieldValues();
                closeIFrame(parent);
            } else {
                var err = getErrorMessage(accessTokenJSONResponse['error'], accessTokenJSONResponse['error_description']);
                errorMessageToggle(err, "show");
            }
        },
        error: function(xhr, status) {
            $("#err_message_span").html("Error: " + xhr.responseText);
        }
    });
}

function updateResponseFieldValues() {
    setParentFormFieldValue(connection_jwt_issuer, $("[name='" + jwtclaim_iss + "']").val());
    setParentFormFieldValue(connection_jwt_subject, $("[name='" + jwtclaim_sub + "']").val());
    setParentFormFieldValue(getElementFullName('oauth.accessToken'), accessTokenJSONResponse['access_token']);
    triggerPasswordChangeEvent(getParentPageElementByName(getElementFullName('oauth.accessToken')));
    setParentFormFieldValue(getElementFullName('oauth_v20.instanceURL'), accessTokenJSONResponse['instance_url']);
    setParentFormFieldValue(getElementFullName('oauth_v20.authorizationHeaderPrefix'), accessTokenJSONResponse['token_type']);
    
	//replace server url instance with response Instance URL
    //var serverUrl = getParentPageElementByName(connection_provider_url_name).value;
	//serverUrl = replaceServerURLInstance(accessTokenJSONResponse['instance_url'], serverUrl);
    //setParentFormFieldValue(connection_provider_url_name, serverUrl);
}

// gets issuer and subject field values from connection page
function fetchParentTableOAuthFields() {
    $("[name='" + jwtclaim_iss + "']").val(getParentPageElementByName(connection_jwt_issuer).value);
    $("[name='" + jwtclaim_sub + "']").val(getParentPageElementByName(connection_jwt_subject).value);
}

function updateParametersValue() {
    // clear arrays
    missingFields = new Array();
    claimsMap = new Array();
    headersMap = new Array();

    // issuer field 
    var issuer = $("[name='" + jwtclaim_iss + "']").val();
    var subject = $("[name='" + jwtclaim_sub + "']").val();
    pushFieldValue(claimsMap, jwtclaim_iss, issuer, jwtclaim_iss);
    pushFieldValue(claimsMap, jwtclaim_sub, subject, jwtclaim_sub);

    for (var i = 0; i < headers.length; i++) {
        var value = $("[name='" + headers[i] + "']").val();
        pushFieldValue(headersMap, headers[i], value, headers[i]);
    }
    for (var i = 0; i < claims.length; i++) {
        var value = $("[name='" + claims[i] + "']").val();
        pushFieldValue(claimsMap, claims[i], value, claims[i]);
    }

    keyStoreAlias = $("select[name='" + keystore_alias_field + "']").val();
    keyAlias = $("select[name='" + key_alias_field + "']").val();
    proxyAlias = $("select[name='proxyAlias']").val();
}

function getElementFullName(elementName) {
    var basicElementName = 'CPROP$oauth_v20_jwt$Basic$' + elementName;
    var advancedElementName = 'CPROP$oauth_v20_jwt$Advanced$' + elementName;

    var basicElement = getParentPageElementByName(basicElementName);
    var advancedElement = getParentPageElementByName(advancedElementName);

    if (basicElement != undefined && basicElement != null) {
        return basicElement.name;
    } else {
        return advancedElement.name;
    }
}