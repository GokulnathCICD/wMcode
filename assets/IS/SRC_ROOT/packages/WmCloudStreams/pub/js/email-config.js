//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
/**
 * @author mgunasek
 */

$(function() {

    //check the passwords
    $('input[name$="pg.email.password"]').change(function() {
        checkPasswords("pg.email.password", "check.pg.email.password");
    });

    //handle the test button click
    $('#btnTest').click(function() {
        $(this).after("<input type='hidden' name='action' value='test'/>");

        $(this).attr('value', getmsg('testing'));

        //store the passwd so we can render it back
        var pwd = $('input[name="pg.email.password"]').val();
        $(this).after("<input type='hidden' name='pwd' value='" + pwd + "'/>");

        //submit the form now
        $('form').submit();
    });

    setupTestRecipient();

});

//enable/disable the test button based on whether the test recipient field has a value or not
function setupTestRecipient() {
    var testField = $('input[name="pg.email.test.recipient"]');
    var testRec = testField.val();
    var testBtn = $('#btnTest')[0];
    if ($.trim(testRec) == "") {
        disableElement(0, testBtn);
    }
    testField.change(function() {
        var currVal = $(this).val();
        if ($.trim(currVal) != "") {
            enableElement(0, testBtn);
        }
        else {
            disableElement(0, testBtn);
        }
    });
}