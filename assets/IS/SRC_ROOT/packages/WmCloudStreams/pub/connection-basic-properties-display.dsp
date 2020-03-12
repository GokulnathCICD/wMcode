%comment%----- Displays connection basic properties -----%endcomment%
    <script>resetRows();</script>

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
       <script>writeTD('row');</script>Connection Type*</td>
       <script>writeTD('rowdata-l');</script>
       <select name="connectionTypeSelect" id="connectionTypeDD" onChange="handleConnectionTypeChange(form);">
        %invoke wm.cloudstreams.connection.ui:listTypes%
            %ifvar connectionInfo -notempty%
                %loop connectionInfo%
                    <option name="%value connectionType%" %ifvar connectionType vequals(name)% selected="true" %endif% value="%value connectionType%">%value authenticationType%</option>
                %endloop%
            %endif%	
        </select></td>

	</tr>
    
	<tr>	
        <script>swapRows();writeTD('row');</script>Folder Name*</td>
        <script>writeTD('rowdata-l');</script>
        <input id=input size=30 name="connectionFolderName" value="%value connectionFolderName%"></input></td>
    </tr>

    <tr>
        <script>swapRows();writeTD('row');</script>Connection Name*</td>
        <script>writeTD('rowdata-l');</script>
        <input id=input size=30 name="connectionName" value="%value connectionName%"></input></td>
    </tr>
 
    %endinvoke%