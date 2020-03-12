<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
	    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<script src="js/messages.js" type="text/javascript"></script>
        <script src="js/basicAdvanced.js"></script>
		<script src="js/jquery-min.js"></script>
		<script src="js/csConnection.js"></script>
		<script type="text/javascript">
			function showSuccessInfo() {
				$("#alert-info").show().delay(10000).fadeOut();
			}
			function load()
			{		
				if (document.form.elements["CMGRPROP$poolable"]!=undefined && document.form.elements["CMGRPROP$poolable"].value == "false") {
					setEnabledFields(document.form, false);
				}
				if (document.form.elements["CMGRPROP$timeoutType"]!=undefined && document.form.elements["CMGRPROP$timeoutType"].value == "none") {
					setField(document.form.elements["CMGRPROP$sessionExpiry"], false);
				}
			}
		</script>

    </head>
    <body onload="load()">  
        <form name="form" action="connector-admin-nodes.dsp#tabs-1" method="POST" onSubmit="return validateForm(form)">
			<input type="hidden" name="action" value="updateConnection">
			<input type="hidden" name="passwordChange" value="false">
			<input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
			<input type="hidden" name="groupName" value="%value groupName%">
			<input type="hidden" name="providerName" value="%value providerName%">
			<input type="hidden" name="connectorID" value="%value connectorID%">
			<input type="hidden" name="connectorName" value="%value connectorName%">
			
			<div id="heading" class="breadcrumb">
						CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName% &gt; %value connectionAlias% &gt; %ifvar readOnly equals('true')%View Connection%else%Edit Connection%endif%    
			</div>
			
            <table id="mainTable" class="tableView" width="100%">
            
            <tr>
				<td colspan=8 class="info" id="alert-info" style="display: none;">OAuth V2.0 fields are updated from the response.
				</td>
            </tr>
            <tr>
                <td colspan=1 width = "40%" style="border: 0px">
                    <ul class="listitems">
                    <li><A HREF="connector-admin-nodes.dsp?searchConnectionName=%value searchConnectionName%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%#tabs-1">Return to %value connectorName% Connections</A>
                    </ul>
                </td>
				
				%invoke wm.cloudstreams.connection.ui:getConfiguration%
				<td style="text-align: right; border: 0px" width = "50%">
					%ifvar readOnly equals('true')%
						%ifvar basic equals('true')% 
							Basic view| <a href="connection-details.dsp?readOnly=true&basic=false&connectionAlias=%value connectionAlias%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&connectionType=%value connectionType%&authenticationType=%value authenticationType%">Advanced view</a>
						%else%
							<a href="connection-details.dsp?readOnly=true&basic=true&connectionAlias=%value connectionAlias%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&connectionType=%value connectionType%&authenticationType=%value authenticationType%">Basic view</a>
							 | Advanced view 
						%endif%	
					%else%
						Basic view| <a href="javascript:void(0); showHeading()" onclick="javascript:ShowAllFields()">Advanced view</a>
					%endif%
				</td>
				
            </tr>
           
			<tr>
				<td class="heading" colspan=2>%value connectionAlias% Details </td>
			</tr>	
				
				
			
			
		  
			<tr>
				<script>writeTD('row');</script>Connection Type</td>
				<script>writeTD('rowdata-l');swapRows();</script>%value authenticationType%</td>
			</tr>

			<tr>
				<script>writeTD('row');</script>Package Name</TD>
				<script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
			</tr>    
            
                %include connection-properties-edit.dsp%
                   
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%    
                %include connection-mgr-properties-edit.dsp%
                %comment%----------------------End ConnectionManagerProperties--------------%endcomment%  
            
            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('false')%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100></input>
                            <input type="hidden" name="connectionAlias" value="%value connectionAlias%">
                        %endif%        
                    </td>    
                </tr>
            </table>
			
			  %onerror%
                %ifvar localizedMessage%
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
