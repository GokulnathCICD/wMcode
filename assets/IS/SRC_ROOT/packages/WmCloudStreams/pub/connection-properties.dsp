%comment%----- Displays Connection Parameters and Properties -----%endcomment%

<HTML> 
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
        <title>Connection Properties</title>
        <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></LINK>
	    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>

        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<script src="js/messages.js" type="text/javascript"></script>
		<script src="js/basicAdvanced.js"></script>
		<script src="js/csConnection.js"></script>
		<script src="js/jquery-min.js"></script>
		<script>
			function showSuccessInfo() {
				$("#alert-info").show().delay(10000).fadeOut();
			}
		</script>
    </head>

    <body onload="onConnectionPageLoad(form)">
        <form name="form" action="connector-admin-nodes.dsp#tabs-1" method="POST" onSubmit="return validateForm(form)">
        <input type="hidden" name="action" value="saveConnection">
        <!-- 
             WST-2019:passwordChange value is not being set correctly.
        -->
        <input type="hidden" name="passwordChange" value="%passwordChange%">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
		<input type="hidden" name="connectorID" value="%value connectorID%">
		<input type="hidden" name="providerName" value="%value providerName%">
		<input type="hidden" name="groupName" value="%value groupName%">
		<input type="hidden" name="connectorName" value="%value connectorName%">
        <input type="hidden" id="connectionType" name="connectionType" value="%value connectionType%">
        <input type="hidden" id="authenticationType" name="authenticationType" value="%value authenticationType%">
        <input type="hidden" id="authenticationDisplayName" name="authenticationDisplayName" value="%value authenticationDisplayName%">
        
		<div id="heading" class="breadcrumb">
			CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName% &gt; Configure Connection
		</div>
        <table id="mainTable" class="tableView" width="100%">
			<tr>
				<td colspan=8 class="info" id="alert-info" style="display: none;">OAuth V2.0 fields are updated from the response.
				</td>
            </tr>
            <tr>
                <td colspan=1 width = "45%" style="align: left; border: 0px;">
                    <ul class="listitems">
                       <!--  <li><a href="connection-list.dsp?searchConnectionName=%value searchConnectionName%">Return to %value connectorName% Connections</a> -->
					   <li><a href="connector-admin-nodes.dsp?providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&searchConnectionName=%value searchConnectionName%#tab-1">Return to %value connectorName% Connections</a>
                    </ul>
                </td>
				<td style="text-align: right; border: 0px;">Basic view| <a href="javascript:void(0)" onclick="javascript:ShowAllFields();showHeading()">Advanced view</a>
				</td>
            </tr>
           
            %comment%----------------------ConnectionProperties--------------%endcomment%     
            
            <tr>
                <td class="heading" colspan=2>Configure Connection &gt; %value /connectorName%
                </td>
            </tr>
            
            %include connection-basic-properties-display.dsp%   
                  
            %invoke wm.cloudstreams.connection.ui:getConfiguration%
            %ifvar connectionType%
            %include connection-properties-display.dsp%   
			%comment%----------------------ConnectionManagerProperties--------------%endcomment%   
			%ifvar connectionManagerProperties%
				<script>resetRows();</script>
				<tr><td class="heading" colspan=2>Connection Management Properties</td></tr>
				%loop connectionManagerProperties%
					%loop fields%
						<tr>
							<script>CMGRPROP.%value propertyKey%="%value defaultValue%";</script>
							<script>writeTD('row');</script>%value displayName%</td>

							%ifvar schemaType equals('int')%
								<script>populateValidationFields("CMGRPROP$%value propertyKey%")</script>
							%endif%

							%ifvar propertyKey equals('poolable')%
								<script>writeTD('rowdata-l');swapRows();</script>
								<select name="CMGRPROP$%value propertyKey%" 
									%ifvar propertyKey equals('poolable')%onChange="handlePoolableChange(form);"%endif%>
									<option value="true"  %ifvar defaultValue equals('true')%selected="true"%endif%>true</item>
									<option value="false" %ifvar defaultValue equals('false')%selected="true"%endif%>false</item>
								</select>
							%else%
								<script>writeTD('rowdata-l');swapRows();</script>
								%ifvar allowedValues%
									<select id=input name="CMGRPROP$%value propertyKey%"
										%ifvar propertyKey equals('timeoutType')%onChange="handleSessionManagementChange(form);"%endif%>
										%loop allowedValues%
											<option value="%value allowedValues%" 
												%ifvar allowedValues vequals(defaultValue)% selected %endif%>%value allowedValues%</option>
										%endloop%
									</select>
								%else%
									%ifvar propertyValue -notempty%
										<input id=input size=60 name="CMGRPROP$%value propertyKey%" value="%value propertyValue%"></input>
									%else%
										<input id=input size=60 name="CMGRPROP$%value propertyKey%" value="%value defaultValue%"></input>
									%endif%
									
								%endif%
								</td> </tr>
							%endif%
					%endloop%
				%endloop%
			%else%
				<tr><td class="error">Connection Management properties not found</td></tr>
			%endif%
			
        </table>
    
        <table width=100%>
        <td class="action" colspan="2">
            <input type="submit" name="SUBMIT" value="Save"></input>
            <input type="hidden" name="connectionType" value="%value connectionType%"> 
            <input type="hidden" name="authenticationType" value="%value authenticationType%"> 
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
