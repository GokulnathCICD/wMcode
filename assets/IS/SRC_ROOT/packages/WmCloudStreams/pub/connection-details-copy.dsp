<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
	    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>

        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<script src="js/messages.js" type="text/javascript"></script>
		<script src="js/basicAdvanced.js"></script>
		<script src="js/jquery-min.js"></script>
		<script src="js/csConnection.js"></script>
		<script type="text/javascript">
			function load()
			{		
				if (document.form.elements["CMGRPROP$poolable"]!=undefined && document.form.elements["CMGRPROP$poolable"].value == "false") {
					setEnabledFields(document.form, false);
				}
				if (document.form.elements["CMGRPROP$timeoutType"]!=undefined && document.form.elements["CMGRPROP$timeoutType"].value == "none") {
					setField(document.form.elements["CMGRPROP$sessionExpiry"], false);
				}
			}
			function showSuccessInfo() {
				$("#alert-info").show().delay(10000).fadeOut();
			}
			
		</script>

    </head>
    <body onload="load()">  
        <form name="form" action="connector-admin-nodes.dsp#tabs-1" method="POST" onSubmit="return validateForm(form)">
        <input type="hidden" name="action" value="saveConnection">
        <input type="hidden" name="passwordChange" value="false">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
		<input type="hidden" name="groupName" value="%value groupName%">
		<input type="hidden" name="providerName" value="%value providerName%">
        <input type="hidden" name="connectorID" value="%value connectorID%">
		<input type="hidden" name="connectorName" value="%value connectorName%">
        
		<div id="heading" class="breadcrumb">
		CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName% &gt; %value connectionAlias% &gt; Copy Connection
        </div>
		
        <table id="mainTable" class="tableView" width="100%">
          
            <tr>
				<td colspan=8 class="info" id="alert-info" style="display: none;">OAuth V2.0 fields are updated from the response.
				</td>
            </tr>
			<tr>
                <td colspan=1 width = "40%" style="align: left; border: 0px;">
                    <ul class="listitems">
                    <li><A HREF="connector-admin-nodes.dsp?searchConnectionName=%value searchConnectionName%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%#tabs-1">Return to %value connectorName% Connections</A>
                    </ul>
                </td>
				<td style="text-align: right; border: 0px;">Basic view| <a href="javascript:void(0); showHeading()" onclick="javascript:ShowAllFields()">Advanced view</a>
				</td>
            </tr>
           %invoke wm.cloudstreams.connection.ui:getConfiguration%
                <tr>
                    <td class="heading" colspan=2>%value connectionAlias% Details </td>
                </tr>
              
				
			  
                <tr>
                    <script>writeTD('row');</script>Connection Type</td>
                    <script>writeTD('rowdata-l');swapRows();</script>%value authenticationType%</td>
                </tr>

				<tr>
				   <script>writeTD('row');</script>Package</td>
				   <script>writeTD('rowdata-l');</script>
				   %invoke wm.server.packages:packageList%
						<select name="packageName">
						%loop packages%
						%ifvar enabled equals('true')%
							<option name="%value name%" %ifvar packageName vequals(name)% selected="true" %endif% >%value name%</option>
						%endif%	
						%endloop%
						</select></td>
					%endinvoke%	
				</tr>	
					
				<tr>	
					<script>swapRows();writeTD('row');</script>Folder Name*</td>
					<script>writeTD('rowdata-l');</script>
					<input size=30 name="connectionFolderName" value="%value connectionFolderName%"></input></td>
				</tr>

				<tr>
					<script>swapRows();writeTD('row');</script>Connection Name*</td>
					<script>writeTD('rowdata-l');</script>
					<input size=30 name="connectionName" value="%value connectionName%"></input></td>
				</tr>
            
                %include connection-properties-copy-edit.dsp%
                   
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%    
                %include connection-mgr-properties-edit.dsp%
                %comment%----------------------End ConnectionManagerProperties--------------%endcomment%  

			</table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                            <input type="submit" name="SUBMIT" value="Create" width=100></input>
                            <input type="hidden" name="connectionAlias" value="%value connectionAlias%">
							<input type="hidden" name="connectionType" value="%value connectionType%">
                            <input type="hidden" name="authenticationType" value="%value authenticationType%">
							<input type="hidden" name="connectorID" value="%value connectorID%">
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
