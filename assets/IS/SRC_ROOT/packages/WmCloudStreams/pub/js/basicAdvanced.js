//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

function HideFewFields(){
	var fields = document.getElementsByTagName("*");

	var fieldsCount=0;
	var fieldsRemovedCount=0;
	var previousGroupName="";
		
	var tables = document.getElementsByTagName("table");
	var table = tables[0];	
	resetColumnPrefix();	
	// hide the fields	
	for(var j = 0; j < fields.length; j++)
	{
		var fieldName = fields[j].name;
		var idName = fields[j].id;
		if (idName.match(/input/))
		{
			if(fieldName.match(/CPROP/g) != null && fields[j].style.visibility != "hidden")
			{
				var tokens = fieldName.split("$");
				var groupName = tokens[1];
				var basicAdvanced = tokens[2];
				
				if(previousGroupName == "") 
					previousGroupName=groupName;
				
				// Remove the group heading completely, if all fields under a group are removed.
				// if(groupName != previousGroupName && fieldsCount == fieldsRemovedCount)
				// {
					// var allRows = table.rows;
					// removeHeadingFromTable(allRows, previousGroupName);
					// fieldsCount=0;
					// fieldsRemovedCount=0;
					// previousGroupName=groupName;
				// }

				// Hide the field row completely
				if(basicAdvanced=="Advanced")
				{
					var row = fields[j].parentNode.parentNode;
					row.style.display="none";
				}
				else
				{
					paintRow(fields[j].parentNode.parentNode);
				}
			}
		}
	}
	
	// Toggle the link
	var x = document.getElementById('mainTable').rows[1].cells;
	x[1].innerHTML = getmsg('connection.view.basic')+" | <a href='javascript:void(0)' onclick='javascript:ShowAllFields(); showHeading()'>" +
		getmsg('connection.view.advanced') + "</a>";
	
	
	
}




function removeHeadingFromTable(allRows, previousGroupName)
{
	for(var m = 0; m < allRows.length; m++)
	{
		var rowColumns = allRows[m].getElementsByTagName("td");
		var column = rowColumns[0];
		if(column != null)
		{
			if(column.innerHTML == 'Connection Groups: '+previousGroupName)
			{
				column.parentNode.removeChild(column);
				break;
			}
		}
	}
}


function ShowAllFields(){
	var fields = document.getElementsByTagName("*");
	var tables = document.getElementsByTagName("table");
	var table = tables[0];
	resetColumnPrefix();
	for(var j = 0; j < fields.length; j++)
	{
		var fieldName = fields[j].name;
		var idName = fields[j].id;
		if (idName.match(/input/))
		{
			if(fieldName.match(/CPROP/g) != null && fields[j].style.visibility != "hidden" )
			{
				var tokens = fieldName.split("$");
				var groupName = tokens[1];
				var basicAdvanced = tokens[2];
				// show the advanced fields and paint the rows with alternate colour
				if(basicAdvanced == "Advanced")
				{
					var row = fields[j].parentNode.parentNode;
					row.style.display="";
					paintRow(fields[j].parentNode.parentNode);
				}
				else
				{
					paintRow(fields[j].parentNode.parentNode);
				}
			}
		}
	}
	
	// Toggle the link
	var x = document.getElementById('mainTable').rows[1].cells;
	x[1].innerHTML = "<a href='javascript:void(0)' onclick='javascript:HideFewFields(); hideHeading()'> "+ getmsg('connection.view.basic')+"</a> | " + getmsg('connection.view.advanced');
}


var columnPrefix = 'even';
var other = 'odd';
var swap = '';

function swapColumnPrefix()
{
	swap = columnPrefix;
	columnPrefix = other;
	other = swap;
}

function resetColumnPrefix()
{
	columnPrefix = 'even';
	other = 'odd';
	swap = '';
}

function paintRow(row)
{
	var allColumns = row.getElementsByTagName("td");
	allColumns[0].className = columnPrefix+"row";
	allColumns[1].className = columnPrefix+"row-l";
	swapColumnPrefix();

}


function showHeading()
{
	var inputs = document.getElementsByClassName('HIDDENGROUP');
	for (i=0; i<inputs.length; i++){		
		inputs[i].style.display='';
	}
}


function hideHeading()
{
	var inputs = document.getElementsByClassName('HIDDENGROUP');	
	for (i=0; i<inputs.length; i++){		
		inputs[i].style.display='none';
	}

}

