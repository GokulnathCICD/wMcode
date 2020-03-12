<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Connector Configuration</title>
	
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>

	<script src="js/jquery-min.js" type="text/javascript"></script>
	<script src="js/cloudstreams.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Providers &gt; %value groupName% &gt; Connectors &gt; %value connectorName% &gt; Configure Connector
</div>

<div id="container">

    %ifvar action equals('save')%
      %invoke wm.cloudstreams.connector.lifecycle.ui:configure%
        %ifvar status equals('false')%
           <div class="error">
              <span>Following errors were reported during save:</span>
              <ul class="listitems">
				<li>%value statusMessage%</li>
              </ul>
           </div>
        %else%
           <div class="success">
               <span>Successfully saved CloudStreams Connector configuration!</span>
           </div>
        %endif%
      %endinvoke%
    %endif%

    <ul class="listitems">
        <li><a href="connector-list.dsp?providerName=%value providerName%&connectorID=%value connectorID%&groupName=%value  groupName%&connectorName=%value connectorName%">Return to connector list</a></li>
    </ul>
	
    <div id="connectorConfig" class="config">

        <form name="saveConnectorConfig" method="POST" action="connector-config-edit.dsp">
		<input type="hidden" id="groupName" name="groupName" value="%value groupName%"/>
		<input type="hidden" id="connectorName" name="connectorName" value="%value connectorName%"/>		
		<input type="hidden" id="providerName" name="providerName" value="%value providerName%"/>
		<input type="hidden" id="connectorID" name="connectorID" value="%value connectorID%"/>
		
        %invoke wm.cloudstreams.connector.lifecycle.ui:listConfigurations%
		
        <table class="tableView" style="width: 45%">
            <thead>
            <tr>
                <th colspan="2" class="heading">Connector Configuration</th>
            </tr>
            </thead>
			
			<tbody>
				%ifvar properties -notempty%
				%loop properties%			
				<tr>
					<td nowrap>%value displayName%</td>
					%ifvar datatype equals('boolean')%
						<td>
						<input type='checkbox' align=center id='.CONFIGURATIONS.%value name%' name='.CONFIGURATIONS.%value name%' 
						%ifvar value equals('true')% checked='checked' value='true' %endif% />
					</td>					
					%else%
						<td nowrap>%value value%</td>
					%endif%				
				</tr>
				%endloop%	
				%else%
				<tr><td colspan="2" class="info" align="right">No configurations found</td></tr>
				%endif%	
				
            </tbody>

        </table>
		
		<div id="formButtons">
                <input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
         </div>

            <input type="hidden" id="action" name="action" value="save"/>

        </form>
    </div>

</div>
	%onerror%
			%ifvar localizedMessage%
				<div class="error">%value localizedMessage%</div>
			%else%
				%ifvar error%
					<div class="error">%value errorMessage%</div>
				%endif%
			%endif%
		
        %endinvoke%
</body>
</html>
