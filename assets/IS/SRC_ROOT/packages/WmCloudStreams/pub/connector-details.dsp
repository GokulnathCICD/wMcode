<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connector Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
	    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>

        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
        <script src="js/jquery-min.js" type="text/javascript"></script>
		<script>
			$(document).ready(function() {
				$.ajax({
					url : "./copyright.html",
					dataType: "text",
					success : function (data) {
					   $('#copyrightContent').html(data);
					}
				});
			});
		</script>
    </head>
    <body>
        <form name="form" action="connector-details.dsp" method="POST" onSubmit="return validateForm(form)">

		<div id="heading" class="breadcrumb">
			CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName% &gt; View Details
		</div>
            <table id="mainTable" class="tableView" width=100%>
            
            <tr>
                <td colspan=2 style="border: 0px;">
                    <ul class="listitems">
						<li><A HREF="connector-list.dsp?providerName=%value providerName%&groupName=%value groupName%">Return to %value connectorName% Connectors</A>
                    </ul>
                </td>
            </tr>
           
		    %invoke wm.cloudstreams.connector.lifecycle.ui:view%
            <tr>
            	<td class="heading" colspan=2>Connector Details</td>
            </tr>

			%ifvar readOnly equals('true')%
                <tr>
                    <td class="evenrow" style="width: 1%; white-space: nowrap;">Copyright</td>
                    %ifvar vendor equals('Software AG')%
                         <td class='evenrowdata-l'>
                            <div id="copyrightContent"></div>
                        </td>
                    %else%
                        <script>writeTD('rowdata-l');swapRows();</script><pre>%value thirdPartyCopyright%</pre></td>
                    %endif%
                </tr>
              %loop connectorInfo%
				%loop properties%
                <tr>
                    <td class="evenrow" width=15%> %value name%</td>
                    <td class="evenrowdata-l"> %value value%</td>
                </tr>

                %endloop%           
              %endloop%
			%endif% 
                  
            </table>
			%onerror%
                %ifvar localizedMessage%
                    %comment%-- Localized error message supplied --%endcomment%
                    <div class="error">%value localizedMessage%</div>
                %else%
                    %ifvar error%
						<div class="error">%value errorMessage%</div>
                    %endif%
                %endif%
            %endinvoke%
			
        </form>    
    </body>
</html>

