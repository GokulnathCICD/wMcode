<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>List Listeners</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
        <link rel="stylesheet" TYPE="text/css" HREF="css/messages.css"></link>
        <link rel="stylesheet" TYPE="text/css" HREF="css/cloudstreams.css"></link>
        <script src="js/connectionfilter.js"></script>
		<script src="js/messages.js"></script>
        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<script src="js/connectionfilter.js" type="text/javascript"></script>
		<SCRIPT LANGUAGE="JavaScript">
            function confirmListenerDisable (aliasName)
            {                 
				var s1 = getmsg("confirm.listener.disable", aliasName);
                var isConfirmed = confirm (s1);
				if(isConfirmed){
					window.location.reload();
				}
                return isConfirmed;
            }
           
            function confirmListenerEnable (aliasName)
            {      
                var s1 = getmsg("confirm.listener.enable", aliasName);
                var isConfirmed = confirm (s1);
				if(isConfirmed){
					window.location.reload();
				}
                return isConfirmed;
            }
			$(document).ready(function(){
				replaceWS();
				showHideFilterCriteriaListener('searchListenerName');
				$('#listenerTable tr').removeClass('oddrow');
				$('#listenerTable tr').removeClass('evenrow');
				$('#listenerTable tr td').removeClass('left');
			});
			
			function replaceWS(){
				$("#replaceWsWithNbsp").html($("#replaceWsWithNbsp").text().replace(/\s+/g, '&nbsp;'));
			}
			
     </SCRIPT>
    </head>

    <BODY>
	
	<form name="form" action="connector-admin-nodes.dsp#tabs-2" method="POST">	
        <table id="listenerTable" width="100%">
        
		<!-- action processing -->
        %ifvar action%
            %switch action%
                %case 'enable'%
                    %invoke pub.cloudstreams.admin.listener:enable%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
                    %endinvoke%
					
				%case 'disable'%
                    %invoke pub.cloudstreams.admin.listener:disable%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
                    %endinvoke%	
				%case 'configure'%
                    %invoke wm.cloudstreams.listener.connection:update%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
					%endinvoke%
            %endswitch%
        %endif%
		
		<!-- Filter UI -->
		<tr>
            <td colspan=2>		
                <ul class="listitems">
                    <li><a href="connector-list.dsp?groupName=%value groupName%">Return to Connectors </a>				
					<li id="showfewListener" name="showfewListener"><a href="javascript:showFilterPanelListener(true)">Filter Listeners</a></li>					
					<li style="display:none" id="showallListener" name="showallListener"><a href="/WmCloudStreams/connector-admin-nodes.dsp?providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%#tabs-2" onClick="showAll(form, 'listener');">Show All Listeners</a></li>
					<DIV id="filterContainerListener" name="filterContainerListener" style="display:none;padding-top=2mm;">
					 <br>
					  <table>
					  <tr valign="top">
						<td>
							<span>Filter criteria</span><br>                    	
							<input id="searchListenerName" name="searchListenerName" value="%value searchListenerName%" onkeydown="return processKey(event, 'submitButtonListener')" />
						</td>
						<td>					
						 <br>
							<input id="submitButtonListener" name="Search" type="submit" value="Search" width="15" height="15" onClick="validateSearchCriteria('searchListenerName');return false;"/> 
						 </br>
						</td> 
					  </tr>
					  </table>
					 </br>  
					</DIV>
                </ul>				
            </td>
        </tr>
	
		<!-- connection display -->
		%invoke wm.cloudstreams.listener:list%
		<TR>
			<TD style="padding-left: 0px;">
				<TABLE class="tableView" WIDTH=100% id="head" name="head">
					<TR>
						<TD CLASS="heading" COLSPAN=8>Listeners</TD>
					</TR> 
					<tr class="subheading2"> 
						<td class="oddcol">Listener&nbsp;Name						
						<a id="ascLN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerName&listenerSortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerName&listenerSortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">
						</a>
						</td>
						<td class="oddcol">Package&nbsp;Name
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=packageName&listenerSortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=packageName&listenerSortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						<td class="oddcol">Connection&nbsp;Name
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerConnectionAlias&listenerSortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%&authenticationType=%value authenticationType%#tabs-2">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerConnectionAlias&listenerSortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%&authenticationType=%value authenticationType%#tabs-2">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						<td class="oddcol-l">Listener&nbsp;Connection&nbsp;Type
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerConnectionType&listenerSortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=listenerConnectionType&listenerSortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						
						<td class="oddcol">Enabled
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=state&listenerSortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchListenerName=%value searchListenerName%&listenerSortCriteria=state&listenerSortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-2">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						<td class="oddcol">Configure</td>
						<td class="oddcol">View</td>					
					</tr>
                    
        %ifvar listeners -notempty%
            %loop listeners%
            
                <tr class="row">
                    <script>writeTD('row-l');</script>%value alias%</td>
                    <script>writeTD('row-l');</script>%value packageName%</td>					
                    <script>writeTD('row-l');</script> <a href="/WmCloudStreams/connection-details.dsp?readOnly=true&connectionAlias=%value listenerConnectionAlias%&listenerAlias=%value alias%&providerName=%value /providerName%&groupName=%value /groupName%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true&authenticationType=%value authenticationType%">%value listenerConnectionAlias%</a></td>
                   <script>writeTD('row-l');</script><span id="replaceWsWithNbsp">%value connectionTypeDisplayName%</span></td>		
                    %switch state%
                        %case 'enabled'%
                            <script>writeTD('rowdata');</script>
                            <a class="imagelink" href="/WmCloudStreams/connector-admin-nodes.dsp?listenerAction=&action=disable&listenerAlias=%value alias%&searchListenerName=%value ../searchListenerName%&providerName=%value /providerName%&groupName=%value /groupName%&listenerConnectionType=%value listenerConnectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&authenticationType=%value authenticationType%#tabs-2"
							ONCLICK="return confirmListenerDisable('%value alias%');">
                                    <IMG SRC="/WmRoot/images/green_check.gif" border="0" height=13 width=13>Yes
                                </a>
    
                        %case 'disabled'%
                            <script>writeTD('rowdata');</script>
	                        <a class="imagelink" href="/WmCloudStreams/connector-admin-nodes.dsp?action=enable&listenerAlias=%value alias%&searchListenerName=%value ../searchListenerName%&providerName=%value /providerName%&groupName=%value /groupName%&listenerConnectionType=%value listenerConnectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&authenticationType=%value authenticationType%#tabs-2"
							ONCLICK="return confirmListenerEnable('%value alias%');">
                                    <img src="/WmRoot/images/blank.gif" border=0 title="Enable">No
                            </a>
    
                    %endswitch%
    
					%ifvar state equals('disabled')%
                        <script>writeTD('rowdata');</script>
                            <a href="/WmCloudStreams/listener-details.dsp?readOnly=false&listenerAlias=%value alias%&searchListenerName=%value ../searchListenerName%&listenerConnectionAlias=%value listenerConnectionAlias%&providerName=%value /providerName%&groupName=%value /groupName%&listenerConnectionType=%value listenerConnectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true&authenticationType=%value authenticationType%">
                                <img src="/WmCloudStreams/icons/config_edit.gif" title="Configure" border=0>
                            </a>
                        </td>
                    %else%
                        <script>writeTD('rowdata');</script>
                            <img src="/WmCloudStreams/icons/disabled_edit.gif" title="Disable Listener to Configure" border=0>
                        </td>
                    %endif%
	    
                    <script>writeTD('rowdata');</script>
                       <a href="/WmCloudStreams/listener-details.dsp?readOnly=true&listenerAlias=%value alias%&providerName=%value /providerName%&groupName=%value /groupName%&listenerConnectionType=%value listenerConnectionType%&listenerConnectionAlias=%value listenerConnectionAlias%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true&authenticationType=%value authenticationType%">
                        <img src="/WmRoot/icons/file.gif" title="View" border=0>
                        </a>
                    </td>                   
                </tr>
            %endloop%
        %else%
            <tr><td class="info" colspan=8>No listeners found</td></tr>
        %endif%		
		
        %onerror%
            %ifvar localizedMessage%
                <tr><td class="error">%value localizedMessage%</pre></td></tr>
            %else%
                %ifvar error%
                    <tr><td class="error">%value errorMessage%</pre></td></tr>
                %endif%
            %endif%
        %endinvoke%		
		</table>
		</td>
		</tr>
        </table>
		
	  <input type="hidden" name="connectorID" value="%value connectorID%">
      <input type="hidden" name="searchListenerName" value="%value searchListenerName%">
	  <input type="hidden" name="groupName" value="%value groupName%">
	  <input type="hidden" name="connectorName" value="%value connectorName%">
	  <input type="hidden" name="providerName" value="%value providerName%">
      <input type="hidden" name="authenticationType" value="%value authenticationType%">
	
	</form>
    </body>
</HTML>
