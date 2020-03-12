//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {

    //make an Ajax POST call to get the list of aliases for the chosen keystore
    $("select[name='pg.keystore.keyStoreHandle']").bind('change', function () {
        var sel = this.options[this.selectedIndex].text;

        if (sel !== "") {
            $('div#busy').css('display', 'inline');   //show busy

            $.post("getAliases.dsp",
                {
                    "action": "getAliases",
                    "keyStore": sel
                }, function (data) {
                    var options = data.substr(data.indexOf("<option>"));
                    $("select[name='pg.rampartdeploymenthandler.signingCertAlias']").html(options);
                    $('div#busy').css('display', 'none');   //hide busy
                });
        }
        else {
            //remove the alias select options
            $("select[name='pg.rampartdeploymenthandler.signingCertAlias'] > option").each(function () {
                if ($(this).val() !== "") $(this).remove();
            })
        }
    });

    $('div#busy').hide(); //initially hidden

    $('input[name="pg.lb.http.url"], input[name="pg.lb.https.url"]').change(function () {
        validateUrl(this);
    });

    //bind the click handlers for Add and Remove links
    $('a#addHttp').click(function (e) {
        return !$('#availableHttpPorts :selected').remove().appendTo($('#selectedHttpPorts'));
    });
    $('a#removeHttp').click(function (e) {
        updateSelectedHttpPorts();
    });

    $('a#addHttps').click(function (e) {
        return !$('#availableHttpsPorts :selected').remove().appendTo($('#selectedHttpsPorts'));
    });
    $('a#removeHttps').click(function (e) {
        return !$('#selectedHttpsPorts :selected').remove().appendTo($('#availableHttpsPorts'));
    });

    //select all unselected values in the right select box - only selected values are sent to server
    $('#btnSubmit').click(function (evt) {
        $('#selectedHttpPorts :not(option[selected])').attr('selected', 'selected');
        $('#selectedHttpsPorts :not(option[selected])').attr('selected', 'selected');

        //if there are no https ports selected, send an empty value
        if ($('#selectedHttpsPorts option').length == 0) {
            $('#selectedHttpsPorts').after("<input type='hidden' name='pg.https.ports' value=''/>");
        }

        var result = validateFields();
        if (!result) {
            evt.preventDefault();
            evt.stopPropagation();
        }
    });


    //bind the dblclick handler for the select options
    moveOnDblClick('#availableHttpPorts', '#selectedHttpPorts');
    moveOnDblClick('#availableHttpsPorts', '#selectedHttpsPorts');
    moveOnDblClick('#selectedHttpPorts', '#availableHttpPorts');
    moveOnDblClick('#selectedHttpsPorts', '#availableHttpsPorts');

});

function moveOnDblClick(src, target) {
    $(src).dblclick(function (e) {
        //move non-primary ports only
        $(src + " option:selected").not($(".primary")).remove().appendTo($(target));
    });
}

function updateSelectedHttpPorts() {

    var selectedPorts = $('#selectedHttpPorts').val().join(",");
    //get the primary http port
    $.post("getPrimaryPort.dsp",
        function (data) {
            var xmldoc = $.parseXML(data.substr(data.indexOf("<result>")));
            var port = $(xmldoc).find("result").text();
            if (selectedPorts.indexOf(port) != -1) {
                var key = "port.remove.error";
                alert(getmsg(key, port));
                var selector = "#selectedHttpPorts option:contains('" + port + "')";
                $(selector).removeAttr('selected');
            }

            $('#selectedHttpPorts option:selected').remove().appendTo($('#availableHttpPorts'));

        });
}

function validateUrl(urlEl) {
    var result = true;
    var urlPattern = /https?:\/\/[\w\d\.-]{3,}:\d{2,5}/;

    if (urlEl != undefined && urlEl != null) {
        //reset the field first
        $(urlEl).removeClass('invalid');
        $(urlEl).next('span').remove();

        var val = $(urlEl).val();
        if (val.length > 0 && (val.search(urlPattern) == -1)) {
            result = false;
            $(urlEl).addClass('invalid');
            var msg = getmsg("url.invalid");
            $(urlEl).after("<span>" + msg + "</span>");
        }
    }
    return result;
}


//do any required field validation here
function validateHttpLBUrl() {
    return validateUrl($('input[name="pg.lb.http.url"]').get());
}
function validateHttpsLBUrl() {
    return validateUrl($('input[name="pg.lb.https.url"]').get());
}
function validateTargetName() {
    return validateName($('input[name="pg.policygateway.targetName"]'));
}
function validateFields() {
    var isValidTarget = validateTargetName();
    var isValidHttpLbUrl = validateHttpLBUrl();
    var isValidHttpsLbUrl = validateHttpsLBUrl();

    var result = isValidTarget && isValidHttpLbUrl && isValidHttpsLbUrl;
    if (!result) {
        alertUser();
    }
    return result;
}
