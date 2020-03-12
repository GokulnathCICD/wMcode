//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

var isErr = false;

$(function() {

     //whenever the checkbox is checked, set the value attribute to 'true', when it is unchecked send value as 'false'
    $('input[type=checkbox]').click(function() {
        var name = this.attributes.getNamedItem('name').value;
        if (this.checked) {
           $(this).attr('value', 'true');
        }
        else {
           $(this).after("<input type='hidden' name=" + name + " value='false' />");
        }
   });
     updatePasswordFields();

    //apply the css styles 'left' and 'right' to the table columns
    $('td:nth-child(1)').addClass("left");
    $('td:nth-child(2)').addClass("right");

    //add the zebra stripes
    $('tbody tr:even').addClass('evenrow');
    $('tbody tr:odd').addClass('oddrow');


    //Update the save button when clicked
    $('input#btnSubmit').click(function() {
        $(this).attr('value', getmsg("saving")).after("<input type='hidden' name='action' value='save'/>");
    });

    $('form').submit(function() {
        if (!isErr) {
			resetPasswordFields();
        }
        else {
            alertUser();
            return false;
        }
    });

});  //end DOM load callback function


function setDocPage(docUrl) {
    var helpLnk = $("#helpUrl", parent.frames.topmenu.document);
    if (helpLnk) {
        helpLnk.attr('href', docUrl);
    }
}

function launchHelp() {
	window.open(parent.frames.menu.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
}

/*
 name1 and name2 - pwd elements to be compared and checked
 pwdLen - optional password length to be enforced
 */
function checkPasswords(name1, name2, pwdLen) {

    var elem1 = eval("'input[name=" + name1 + "]'");
    var elem2 = eval("'input[name=" + name2 + "]'");

    elem1 = $(elem1)[0];
    var pwd1 = elem1.value;

    elem2 = $(elem2)[0];
    var pwd2 = elem2.value;

    var saveEl = $('input#btnSubmit')[0];

    if (pwd1 != pwd2) {
        isErr = true;
        $(elem2).addClass('invalid');
        $(elem2).siblings('span').remove();
        $(elem2).after("<span>" + getmsg("pwd.no.match") + "</span>");
        disableElement(0, saveEl);
    }
    else if (pwdLen != undefined && pwd1 == pwd2 && pwd1.length < pwdLen) { //enforce length check
        isErr = true;
        $(elem2).addClass('invalid');
        $(elem2).siblings('span').remove();
        $(elem2).after("<span>" + getmsg("pwd.wrong.len", pwdLen) + "</span>");
        disableElement(0, saveEl);
    }
    else {
        isErr = false;
        $(elem2).removeClass('invalid');
        $(elem2).siblings('span').hide();
        //add an input hidden field that indicates that this password field value has changed
        $(elem1).after("<input type='hidden' name='" + name1 + ".changed' value='true'/>");
        enableElement(0, saveEl);
    }

}

var dummyPwd = '*******';

function updatePasswordFields() {
    $('input[type=password]').each(function() {
        var currVal = $(this).attr('value');
		  var currname = $(this).attr('name');
        if (currVal == "") {    //if initial value is empty, replace with dummy pwd
            $(this).attr('value', dummyPwd);
        }
        else if (currVal != dummyPwd) {
            //add an input hidden element that indicates that this password field value has changed
            //this is for the case where the 'Test' button was clicked and then 'Save' is clicked
            $(this).after("<input type='hidden' name='" + this.name + ".changed' value='true'/>");
        }
    });
}

//Remove the '*' dummy password before sending to the server
function resetPasswordFields() {
    $('input[type=password]').each(function() {
        var pwd = this.value;
        if (pwd != null && pwd == dummyPwd) {
           // $(this).attr('value', '');
        }
    });
}

function enableElement(index, elem) {
    if (elem != null && elem != undefined) {
        elem.removeAttribute('disabled');
    }
}

function disableElement(index, elem) {
    if (elem != null && elem != undefined) {
        elem.setAttribute('disabled', 'true');
    }
}

function alertUser(msgkey) {
    if (msgkey==undefined) msgkey = "config.error";
    alert(getmsg(msgkey));
    updateButtons();
}

function updateButtons() {
    var saveBtn = $('#btnSubmit');
    saveBtn.attr('value', getmsg('save'));
}

function updateSave(flag) {
    var saveEl = $('input[type=submit]')[0];
    if (flag) {
        enableElement(0, saveEl);
    }
    else {
        disableElement(0, saveEl);
    }
}

function blockEvt(evt) {
    evt.preventDefault();
    evt.stopPropagation();
}

/*toggle the disabled attribute for the elements in elArr
based on whether the checkbox (chkBox) is checked or not*/
function toggleEnabled(chkBox, elArr) {
    $(elArr).each(function() {
        if (!chkBox.checked) $(this).attr('disabled', 'disabled');
        else $(this).removeAttr('disabled');
    })
}