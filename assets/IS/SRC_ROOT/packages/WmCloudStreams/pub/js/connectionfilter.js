//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

function validateSearchCriteria(name){
	var searchConnectionName=document.getElementById(name).value;	
	if(searchConnectionName=="" || searchConnectionName == null || trim(searchConnectionName).length==0){	
       alert(getmsg("missing.filter.criteria"));
    }else if(specialCharacterCheck(searchConnectionName) == true){    	
    	form.submit();    	
    }
}

function specialCharacterCheck(searchConnectionName){
	var error = true;
	var iChars = "!@#$%^&()+=-[]\\\';,/{}|\"<>?";
	//var iChars = "!@#$%^&()+=-[]\\\';,./{}|\"<>?";	
	if(!searchConnectionName.match(/^\S+$/)) {
			//white space check.
	   		alert(getmsg("spcl.chars.in.filter"));
	   		error=false;
	}else{		
	for (var i = 0; i < searchConnectionName.length; i++) {
		if (iChars.indexOf(searchConnectionName.charAt(i)) != -1) {
	   		alert(getmsg("spcl.chars.in.filter"));
				error=false;
				break;
		}
	}
	}
	return error;	
 }
 
function showFilterPanelConnection(){
        var filtercontainer = document.getElementById("filterContainerConnection");
        var showall = document.getElementById("showallConnection");
        var showfew = document.getElementById("showfewConnection");
        showall.style.display="";
        showfew.style.display="none";
        filtercontainer.style.display="";

}
function showFilterPanelListener(){
        var filtercontainer = document.getElementById("filterContainerListener");
        var showall = document.getElementById("showallListener");
        var showfew = document.getElementById("showfewListener");
        showall.style.display="";
        showfew.style.display="none";
        filtercontainer.style.display="";

}
function trim(a){
        return a.replace(/^\s+|\s+$|\n+$/gm, '');

}

function showHideFilterCriteriaConnection(name) 
{
    var filtercontainer = document.getElementById("filterContainerConnection");
    var searchConnectionName=document.getElementById(name);            	               	    	 
    var showall = document.getElementById("showallConnection");
    var showfew = document.getElementById("showfewConnection");                  
    if(searchConnectionName!=null && searchConnectionName.value!="" && searchConnectionName.value!=undefined && searchConnectionName.value.length > 0){                                       
       showall.style.display="";
       showfew.style.display="none";
       filtercontainer.style.display="";
       //In order to encode the value so that %3A won't get displayed in case of :
       	document.getElementById(name).value=unescape(searchConnectionName.value);
    }
                   
}
function showHideFilterCriteriaListener(name) 
{
    var filtercontainer = document.getElementById("filterContainerListener");
    var searchConnectionName=document.getElementById(name);            	               	    	 
    var showall = document.getElementById("showallListener");
    var showfew = document.getElementById("showfewListener");                  
    if(searchConnectionName!=null && searchConnectionName.value!="" && searchConnectionName.value!=undefined && searchConnectionName.value.length > 0){                                       
       showall.style.display="";
       showfew.style.display="none";
       filtercontainer.style.display="";
       //In order to encode the value so that %3A won't get displayed in case of :
       	searchConnectionName.value=unescape(searchConnectionName.value);
    }
                   
}


function processKey(e, submitButtonId)
{
    if (null == e)
        e = window.event ;
    if (e.keyCode == 13)  {
        document.getElementById(submitButtonId).click();
        return false;
    }
}

function showAll(theForm, name) {
	if(name == "connection"){
		showHideFilterCriteriaConnection("searchConnectionName");
	}
	if(name == "listener"){
		showHideFilterCriteriaListener("searchListenerName");
	}
	window.location.reload(true);
}