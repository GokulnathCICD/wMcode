<HTML>
   <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE> CloudStreams Connectors </TITLE>
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <LINK REL="stylesheet" TYPE="text/css" HREF="css/cloudstreams.css">
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>

	<script src="js/providerfilter.js"></script>
    <script src="js/jquery-min.js"></script>
    <script src="js/help.js"></script>
    <script src="js/messages.js"></script>

    <SCRIPT LANGUAGE="JavaScript">

      function confirmDelete (pkg, safe)
      {
        var s1 = getmsg("confirm.connector.delete", pkg);
        return confirm(s1);
        
      }
      function confirmReload (pkg)
      {
         var s1 = getmsg("confirm.connector.reload", pkg);
         return confirm(s1);
      }
      function confirmDisable (pkg)
      {
         var s1 = getmsg("confirm.connector.disable", pkg);
         return confirm (s1);
      }
      function confirmEnable (pkg)
      {
         var s1 = getmsg("confirm.connector.enable", pkg);
         return confirm (s1);
      }

    </SCRIPT>
    <SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>
   </HEAD>
<body>
     <DIV class="position">
	 <div id="heading" class="breadcrumb">
               CloudStreams &gt; Providers &gt; %value groupName% &gt; Connectors
     </div>
        <TABLE WIDTH="100%">
            
		%ifvar action%
			%switch action%
				%case 'archive'%
					%invoke pub.cloudstreams.admin.provider:archiveProvider%
						%ifvar message%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class="message" colspan=2>%value  message%</TD></TR>
						%endif%
						%onerror%
						%ifvar errorMessage%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class="message" colspan=2>%value  errorMessage%</TD></TR>
						%endif%
					%endinvoke%
					
				%case 'enable'%
					%invoke wm.cloudstreams.connector.lifecycle.ui:enable%
						%ifvar statusMessage%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan="2">%value none statusMessage%</TD></TR>
						%endif%
					%endinvoke%
					
				%case 'disable'%
					%invoke wm.cloudstreams.connector.lifecycle.ui:disable%
						%ifvar statusMessage%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan="2">%value none statusMessage%</TD></TR>
						%endif%
					%endinvoke%
					
				%case 'reload'%
					%invoke pub.cloudstreams.admin.provider:reloadProvider%
						%ifvar message%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class="message" colspan="2">%value none message%</TD></TR>
						%endif%
					%endinvoke%
					
				%case 'delete'%
					%invoke wm.cloudstreams.connector.lifecycle.ui:remove%
						%ifvar statusMessage%
							<tr><td colspan="2">&nbsp;</td></tr>
							<TR><TD class=%ifvar status equals('true')% "success" %else% "error" %endif% colspan="2">%value none statusMessage%</TD></TR>
						%endif%
					%endinvoke%
					
			%endswitch%
		%endif action%

        %invoke wm.cloudstreams.connector.lifecycle.ui:listByGroup%
            <TR>
                <TD>
                    <ul class="listitems">
                        <!-- <LI><A HREF="provider-inbound.dsp?mode=inbound">Import Provider</A></LI> -->
						
                        <!-- <li id="showfew" name="showfew"><a href="javascript:showFilterPanel(true)">Filter Providers</a></li> -->
                        
						<li style="display:none" id="showall" name="showall"><a href="connector-list.dsp">Show All Providers</a></li>

                        <DIV id="filterContainer" name="filterContainer" style="display:none;padding-top=2mm;"> <br>
							<table>
								<tr valign="top">
									<td>
										<span >Filter criteria</span><br>
										<input type="text" id="pfilter" name="pfilter" onKeyPress="filterProviders(event)"/>
									</td>

									<td>
										<table>
											<tr>
												<td>
													<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
													<input type="radio" id="enablep" name="enablep" onclick="setFlag('enabled')"/>
													<span id="enabletitle" name="enabletitle">Include Enabled Provider</span>

												</td>
											</tr>
											<tr>
												<td>
													<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
													<input type="radio" id="enablep" name="enablep" onclick="setFlag('disabled')"/>
													<span id="disabletitle" name="disabletitle">Include Disabled Provider</span>
												</td>
											</tr>
											<tr>
												<td>
													<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
													<input type="radio" id="enablep" name="enablep" checked onclick="setFlag('both')"/>
													<span id="enabletitle" name="enabletitle">Include Both</span>
												</td>
											</tr>
										</table>

									</td> 
									<td>
										<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
										<input type="checkbox" id="nested" name="nested" />
										<span id="nesttitle" name="nesttitle">Filter on result</span>
									</td> 
									<td>
										<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
										<input type="checkbox" id="exclude" name="exclude" />
										<span id="excludetitle" name="excludetitle">Exclude from result</span>
									</td> 
									<td>
										<IMG SRC="/WmRoot/images/blank.gif" height=10 width=10>
										<input type="Button" id="submit" name="submit" value="Submit" onclick="filterProvidersInternal()"/>
									</td> 
								</tr>
							</table>
                        </DIV>
                    </UL>
                </TD>
            </TR>
            
            <TR>
				
					<TD style="padding-left: 0px;">
						<TABLE class="tableView" WIDTH=100% id="head" name="head">
						<TR>
							<TD CLASS="heading" COLSPAN=8>Connector List</TD>
						</TR>
						<TR class="subheading2">
						   <TD CLASS="oddcol-l">Connector Name</TD>
						   <!-- <TD CLASS="oddcol">Provider Name</TD> -->
						   <TD CLASS="oddcol">Version</TD>
						   <TD CLASS="oddcol">Type</TD>
						   <TD CLASS="oddcol">View</TD>
						   
						   <!-- <TD CLASS="oddcol">Reload</TD> -->
						   <TD CLASS="oddcol">Enabled</TD>
						   <!-- <TD CLASS="oddcol">Archive</TD> -->
						   <TD CLASS="oddcol">Delete</TD>
						   <TD CLASS="oddcol">Configure</TD>
						</TR>
						
						<script>resetRows();</script>
						%ifvar connectorList -notempty%
						%loop connectorList%						
							<TR>
								<script>writeTD('rowdata-l');</script>
								%ifvar state equals('enabled')%
									<!-- <A HREF="connector-admin-nodes.dsp?connectorID=%value id%&connectorName=%value name%&providerName=%value packageName%">%value name%</A> -->
									
									<!-- once the conenctor provider thing is corrected revert this hyperlink back to the upper commented hyperlink. -->
									
									<!-- <A HREF="connector-admin-nodes.dsp?providerID=%value id%&providerName=%value name%&connectorName=%value ../providerName%&connectorDisplayName=%value ../providerDisplayName%&providerConnectionType=sagcloud">%value name%</A> -->
									
									<A HREF="connector-admin-nodes.dsp?providerName=%value packageName%&groupName=%value ../groupName%&connectorID=%value id%&connectorName=%value name%&providerConnectionType=sagcloud">%value name%</A>
								%else%
									%value name%
								%endif%
								
								<!-- <script>writeTD('rowdata');</script>							
								%value name% -->
								
								<script>writeTD('rowdata');</script>							
								%value version%		
								
								<script>writeTD('rowdata');</script>							
								%value type%	
								
								<script>writeTD('rowdata');</script>
									<!-- show view -->
									<A href="/WmCloudStreams/connector-details.dsp?readOnly=true&providerName=%value packageName%&connectorID
									=%value id%&groupName=%value ../groupName%&connectorName=%value name%">
									<img src="/WmRoot/icons/file.gif" alt="View" border=0>
                                </A>
								
						 		<!--<script>writeTD('rowdata');</script>
								<A class="imagelink" HREF="javascript:execute('connector-list.dsp?action=reload&providerID=%value id%')"  
									ONCLICK="return confirmReload('%value name%' + '(' + '%value id%' + ')');">
									<IMG SRC="/WmRoot/icons/icon_reload.gif" border="0"
									alt="Reload Provider">
								</A> -->

								<script>writeTD('rowdata');</script>
								%ifvar state equals('enabled')%
									<A class="imagelink" HREF="javascript:execute('connector-list.dsp?action=disable&groupName=%value ../groupName%&providerName=%value packageName%&connectorID=%value id%&connectorName=%value name%')"
									  ONCLICK="return confirmDisable('%value name%' + '(' + '%value id%' + ')');"><IMG SRC="/WmRoot/images/green_check.gif" border="0"
									  height=13 width=13>Yes</A>
								%else%
									<A class="imagelink" HREF="javascript:execute('connector-list.dsp?action=enable&groupName=%value ../groupName%&providerName=%value packageName%&connectorID=%value id%&connectorName=%value name%')"
											  ONCLICK="return confirmEnable('%value name%' + '(' + '%value id%' + ')');"><IMG border="0" SRC="/WmRoot/images/blank.gif" height=13 width=13>No</A> 
								%endif%
								
								<script>writeTD('rowdata');</script>
								%ifvar state equals('enabled')%
									<img src="/WmRoot/icons/delete_disabled.gif" alt="Disable Connection to Delete" border=0>
								%else%
									<A class="imagelink" HREF="javascript:execute('connector-list.dsp?action=delete&groupName=%value ../groupName%&providerName=%value packageName%&connectorID=%value id%&connectorName=%value name%')"
									 onclick="return confirmDelete('%value name%' + '(' + '%value id%' + ')');"><IMG SRC="/WmRoot/icons/delete.gif" alt="Delete this Provider" border="0">
									</A>
								%endif%

								<script>writeTD('rowdata');swapRows();</script>
								%ifvar state equals('enabled')%
									<img src="/WmCloudStreams/icons/disabled_edit.gif" alt="View" border=0>
								%else%								
									<A href="/WmCloudStreams/connector-config-edit.dsp?readOnly=true&providerName=%value packageName%&connectorID
									=%value id%&groupName=%value ../groupName%&connectorName=%value name%">
									<img src="/WmCloudStreams/icons/config_edit.gif" alt="View" border=0>
									</A>
								%endif%								
							</TR> 
						%endloop%
						%else%
						<tr><td class="info" colspan=8>No connectors found</td></tr>
						%endif%
						</TABLE>
					</TD>
				</TR>
				
				%onerror%
					%ifvar localizedMessage%
						<div class="error">%value localizedMessage%</div>
					%else%
						%ifvar error%
							<div class="error">%value errorMessage%</div>
						%endif%
					%endif%
				
        %endinvoke% 
		</TABLE> 
 
        %ifvar pfilter -notempty%
			<script>
				showFilterPanel();

				var pfilter = document.getElementById("pfilter");
				pfilter.value="%value pfilter%"

				%ifvar regex -notempty%
					var regex = document.getElementById("regex");
					pfilter.checked=true;
				%endif%

				%ifvar exclude -notempty%
					var excludeFromResult = document.getElementById("exclude");
					excludeFromResult.checked=true;
				%endif%

				filterPackagesInternal();
			</script>
        %endif%
    </DIV>
   </BODY>
</HTML>
