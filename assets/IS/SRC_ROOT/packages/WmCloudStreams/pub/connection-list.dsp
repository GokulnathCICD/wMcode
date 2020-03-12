<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>List Connections</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
        <link rel="stylesheet" TYPE="text/css" HREF="css/messages.css"></link>
        <link rel="stylesheet" TYPE="text/css" HREF="css/cloudstreams.css"></link>
        <!--script src="js/connectionfilter.js"></script-->		
		<script src="js/messages.js" type="text/javascript"></script>        
        <SCRIPT SRC="/WmRoot/webMethods.js.txt" type="text/javascript"></SCRIPT>
		<script src="js/connectionfilter.js" type="text/javascript"></script>
		<SCRIPT LANGUAGE="JavaScript">
            function confirmConnectionDisable (aliasName)
            {                 
				var s1 = getmsg("confirm.connection.disable", aliasName);
                var isConfirmed = confirm (s1);
				if(isConfirmed){
					window.location.reload();
				}
                return isConfirmed;
            }
           
            function confirmConnectionEnable (aliasName)
            {      
                var s1 = getmsg("confirm.connection.enable", aliasName);
                var isConfirmed = confirm (s1);
				if(isConfirmed){
					window.location.reload();
				}
                return isConfirmed;
            }
            function confirmConnectionDelete (aliasName)
            {
                var s1 = getmsg("confirm.connection.delete", aliasName);
                var isConfirmed = confirm (s1);
				if(isConfirmed){
					window.location.reload();
				}
                return isConfirmed;
            }
			
			$(document).ready(function(){
				showHideFilterCriteriaConnection('searchConnectionName');
				$('#connTable tr').removeClass('oddrow');
				$('#connTable tr').removeClass('evenrow');
				$('#connTable tr td').removeClass('left');
			});
            
    </SCRIPT>
    </head>

    <BODY>
	<form name="form" action="connector-admin-nodes.dsp#tabs-1" method="POST">	
        <table id="connTable" width="100%">

        <!-- action processing -->
        %ifvar action%
            %switch action%
                %case 'enableConnection'%
                    %invoke pub.cloudstreams.admin.connection:enableConnection%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
                    %endinvoke%
					
				%case 'disableConnection'%
                    %invoke pub.cloudstreams.admin.connection:disableConnection%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
                    %endinvoke%	
					
				%case 'deleteConnection'%
                    %invoke wm.cloudstreams.connection.ui:remove%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
					%endinvoke%		

				%case 'saveConnection'%
                    %invoke wm.cloudstreams.connection.ui:create%
						%ifvar statusMessage%
							  <tr><td class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan = 8>%value statusMessage%</td></tr>
						%endif%
					%endinvoke%
				
				%case 'updateConnection'%
                    %invoke wm.cloudstreams.connection.ui:update%
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
					<li><a href="connector-list.dsp?groupName=%value groupName%">Return to Connectors </a></li>
                    <li>
                        <a href="/WmCloudStreams/connection-properties.dsp?providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&connectionType=sagcloud">Configure New Connection</a>	
                    </li>                   
					<li id="showfewConnection" name="showfewConnection">
						<a href="javascript:showFilterPanelConnection(true)">Filter Connections</a>
					</li>				
                    <li style="display:none" id="showallConnection" name="showallConnection">
						<a href="/WmCloudStreams/connector-admin-nodes.dsp?providerName=%value providerName%&groupName=%value groupName%&connectorID=%value connectorID%&connectorName=%value connectorName%&providerConnectionType=%value connectionType%#tabs-1" onClick="showAll(this.form, 'connection');">Show All Connections</a>
					</li>
				
					<DIV id="filterContainerConnection" name="filterContainerConnection" style="display:none;padding-top=2mm;">
					 <br>
					  <table>
					  <tr valign="top">
						<td>
							<span>Filter criteria</span><br>                    	
							<input id="searchConnectionName" name="searchConnectionName" value="%value searchConnectionName%" onkeydown="return processKey(event, 'submitButtonConnection')" />
						</td>
						<td>					
						 <br>
							<input id="submitButtonConnection" name="Search" type="submit" value="Search" width="15" height="15" onClick="validateSearchCriteria('searchConnectionName');return false;"/> 
						 </br>
						</td> 
					  </tr>
					  </table>
					 </br>  
					</DIV>
                </ul>				
            </td>
         </tr>

		<!-- Invalidate the connectionType while listing Connections -->
        %ifvar connectionType%
            %rename connectionType DUMMYVARIABLE%;
        %endif%
        <!-- connection display -->
		%invoke wm.cloudstreams.connection.ui:list%
		<TR>
			<TD style="padding-left: 0px;">
				<TABLE class="tableView" WIDTH=100% id="head" name="head">
					<TR>
						<TD CLASS="heading" COLSPAN=8>Connections</TD>
					</TR> 
					<tr class="subheading2"> 
						<td class="oddcol">Connection&nbsp;Name
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=connectionAlias&sortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" style="float: middle" src="images/arrow_up.gif" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=connectionAlias&sortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_down.gif" style="float: middle" width="15" height="16">
						</a>
						</td>
						<td class="oddcol">Package&nbsp;Name
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=packageName&sortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=packageName&sortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
                        
                        <td class="oddcol">Connection&nbsp;Type
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=authenticationType&sortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=authenticationType&sortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						
						<td class="oddcol">Enabled
						<a id="ascCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=connectionState&sortOrder=ASC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_up.gif" align="baseline" width="15" height="15">
						</a>
						<a id="desCN" href="/WmCloudStreams/connector-admin-nodes.dsp?connectorID=%value connectorID%&searchConnectionName=%value searchConnectionName%&sortCriteria=connectionState&sortOrder=DESC&groupName=%value groupName%&connectorName=%value connectorName%&providerName=%value providerName%#tabs-1">
							<img border="0" src="images/arrow_down.gif" align="baseline" width="15" height="16">
						</a>
						</td>
						<td class="oddcol">Edit</td>
						<td class="oddcol">View</td>
						<td class="oddcol">Copy</td>	
						<td class="oddcol">Delete</td>
					</tr>
                    
        %ifvar connectionAliasList -notempty%
            %loop connectionAliasList%
            
                <tr class="row">
                    <script>writeTD('row-l');</script>%value connectionAlias%</td>
                    <script>writeTD('row-l');</script>%value packageName%</td>
                    <script>writeTD('row-l');</script>%value authenticationType%</td>
    
                    %switch connectionState%
                        %case 'enabled'%
                            <script>writeTD('rowdata');</script>
                            <a class="imagelink" href="/WmCloudStreams/connector-admin-nodes.dsp?action=disableConnection&connectionAlias=%value connectionAlias%&searchConnectionName=%value ../searchConnectionName%&providerName=%value /providerName%&groupName=%value /groupName%&providerConnectionType=%value connectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%#tabs-1"
							ONCLICK="return confirmConnectionDisable('%value connectionAlias%');">
                                    <IMG SRC="/WmRoot/images/green_check.gif" border="0" height=13 width=13>Yes
                                </a>
    
                        %case 'disabled'%
                            <script>writeTD('rowdata');</script>
	                        <a class="imagelink" href="/WmCloudStreams/connector-admin-nodes.dsp?action=enableConnection&connectionAlias=%value connectionAlias%&searchConnectionName=%value ../searchConnectionName%&providerName=%value /providerName%&groupName=%value /groupName%&providerConnectionType=%value connectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%#tabs-1"
							ONCLICK="return confirmConnectionEnable('%value connectionAlias%');">
                                    <img src="/WmRoot/images/blank.gif" border=0 alt="Enable">No
                            </a>
    
                    %endswitch%
    
					%ifvar connectionState equals('disabled')%
                        <script>writeTD('rowdata');</script>
                            <a href="/WmCloudStreams/connection-details.dsp?readOnly=false&connectionAlias=%value connectionAlias%&searchConnectionName=%value ../searchConnectionName%&providerName=%value /providerName%&groupName=%value /groupName%&connectionType=%value connectionType%&authenticationType=%value authenticationType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true">
                                <img src="/WmCloudStreams/icons/config_edit.gif" alt="Edit" border=0>
                            </a>
                        </td>
                    %else%
                        <script>writeTD('rowdata');</script>
                            <img src="/WmCloudStreams/icons/disabled_edit.gif" title="Disable Connection to Edit" border=0>
                        </td>
                    %endif%
	    
                    <script>writeTD('rowdata');</script>
                       <a href="/WmCloudStreams/connection-details.dsp?readOnly=true&connectionAlias=%value connectionAlias%&providerName=%value /providerName%&groupName=%value /groupName%&connectionType=%value connectionType%&authenticationType=%value authenticationType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%&basic=true">
                        <img src="/WmRoot/icons/file.gif" alt="View" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');</script>
                    
                        <a href="/WmCloudStreams/connection-details-copy.dsp?connectionAlias=%value connectionAlias%&searchConnectionName=%value ../searchConnectionName%&basic=true&providerName=%value /providerName%&groupName=%value /groupName%&connectionType=%value connectionType%&authenticationType=%value authenticationType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%">
                            <img src="/WmCloudStreams/icons/copy.gif" alt="Copy" border=0>
                        </a>
                    </td>
    
                    <script>writeTD('rowdata');swapRows();</script>
                        %ifvar connectionState equals('disabled')%
                            <a href="/WmCloudStreams/connector-admin-nodes.dsp?action=deleteConnection&connectionAlias=%value connectionAlias%&searchConnectionName=%value ../searchConnectionName%&providerName=%value /providerName%&groupName=%value /groupName%&providerConnectionType=%value connectionType%&connectorID=%value /connectorID%&connectorName=%value /connectorName%#tabs-1"
                               ONCLICK="return confirmConnectionDelete('%value connectionAlias%');">
                                <img src="/WmRoot/icons/delete.gif" alt="Delete" border=0>
                            </a>
                        %else%
                            <img src="/WmRoot/icons/delete_disabled.gif" alt="Disable Connection to Delete" border=0>
                        %endif%
                    </td>
                </tr>
            %endloop%
        %else%
            <tr><td class="info" colspan=8>No connections found</td></tr>
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
      <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">     	
	  <input type="hidden" name="groupName" value="%value groupName%">
	  <input type="hidden" name="connectorName" value="%value connectorName%">
	  <input type="hidden" name="providerName" value="%value providerName%">
	</form>
    </body>
</HTML>
