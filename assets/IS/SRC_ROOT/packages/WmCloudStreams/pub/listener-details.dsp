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
		<script src="js/csConnection.js"></script>
		<script src="js/jquery-min.js"></script>

    </head>
    <body>  
        <form name="form" action="connector-admin-nodes.dsp#tabs-2" method="POST" onSubmit="return validateForm(form)">
		<input type="hidden" name="action" value="configure">
		<input type="hidden" name="passwordChange" value="false">
		<input type="hidden" name="searchListenerName" value="%value searchListenerName%">
		<input type="hidden" name="groupName" value="%value groupName%">
		<input type="hidden" name="providerName" value="%value providerName%">
        <input type="hidden" name="connectorID" value="%value connectorID%">
		<input type="hidden" name="connectorName" value="%value connectorName%">
		
		<div id="heading" class="breadcrumb">
                    CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName% &gt; %ifvar readOnly equals('true')%View Listener%else%Edit Listener%endif%    
        </div>
		
            <table id="mainTable" class="tableView" width="100%">
            
				<tr /> <!-- DON'T DELETE THIS. This is required for Basic-Advanced view toggling -->
				<tr>
					<td colspan=1 width = "40%" style="border: 0px">
						<ul class="listitems">
						<li><A HREF="connector-admin-nodes.dsp?searchListenerName=%value searchListenerName%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%#tabs-2">Return to %value connectorName% Listener</A>
						</ul>
					</td>
					
					%invoke wm.cloudstreams.listener.connection:getConfiguration%
					<td style="text-align: right; border: 0px" width = "50%">
						%ifvar readOnly equals('true')%
							%ifvar basic equals('true')% 
								Basic view| <a href="listener-details.dsp?readOnly=true&basic=false&listenerName=%value listenerName%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&listenerConnectionAlias=%value listenerConnectionAlias%&listenerAlias=%value listenerAlias%&listenerConnectionType=%value listenerConnectionType%">Advanced view</a>
							%else%
								<a href="listener-details.dsp?readOnly=true&basic=true&listenerName=%value listenerName%&providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&listenerConnectionAlias=%value listenerConnectionAlias%&listenerAlias=%value listenerAlias%&listenerConnectionType=%value listenerConnectionType%">Basic view</a>
								 | Advanced view 
							%endif%
						%else%
							Basic view| <a href="javascript:void(0); showHeading()" onclick="javascript:ShowAllFields()">Advanced view</a>
						%endif%
					</td>
					
				</tr>
			   
				<tr>
					<td class="heading" colspan=2>%value listenerAlias% Details</td>
				</tr>	
					
				<tr>
					<script>writeTD('row');</script>Listener Connection Type</td>
					<script>writeTD('rowdata-l');swapRows();</script>%value connectionTypeDisplayName%</td>
				</tr>

				<tr>
					<script>writeTD('row');</script>Package Name</TD>
					<script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
				</tr> 
				
				<tr>
				   <script>writeTD('row');</script>Connection Alias</td>
				   <script>writeTD('rowdata-l');</script><a href="/WmCloudStreams/connection-details.dsp?readOnly=true&connectionAlias=%value listenerConnectionAlias%&providerName=%value /providerName%&groupName=%value /groupName%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true&authenticationType=%value authenticationType%">%value listenerConnectionAlias%</a>
				   </td>
				</tr>
				
				%include listener-connection-properties-edit.dsp%       
            
            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('false')%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100></input>
                            <input type="hidden" name="listenerAlias" value="%value listenerAlias%">
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
