<HTML>
<head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" CONTENT="-1">
    <title>About</title>
    <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>
    <link rel="stylesheet" TYPE="text/css" HREF="css/cloudstreams.css"></link>
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

<body onLoad="setNavigation('about.dsp', 'TEST#TEXT', '');">
	<TABLE width="100%">
      <TR>
		<td class="breadcrumb" colspan=5>CloudStreams &gt; About</td>
	</TR>
	<TR>
        <TD>
          <TABLE class="tableView" width="100%">
            <TR>
              <TD class="heading" colspan=2>Copyright</TD>
            </TR>

            <TR>
              <TD class="evenrow-l" colspan="2">
			<table class="tableInline" width="100%">
				<tr>
                  <td width="100%">
						<table class="tableInline" border="0" width="100%">
							<tr>
								<td valign="top" style="border: 0px;"><img src="images/SAG_logo_blue2.png" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="border: 0px;">
									<b>webMethods CloudStreams</b>
									<br/>
									<div id="copyrightContent"></div>
								</td>
							</tr>
						</table>
						</td>
					</TR>
				</table> 
				</td>
				</tr>
				<tr>
					<td class="space"/>
				</tr>
				<tr>
					<td class="heading" style="margin-top: 8px;" colspan=2>Software</td>
				</tr>
				<tr>
					<td class="oddrow" width=15%>Product</td>
					<td class="oddrowdata-l" width=100%>webMethods CloudStreams</td>
				</tr>
				%invoke cloudstreams.UIConfig:getServerAttributes%
				<tr>
					<td class="evenrow">Version</td>
					<td class="evenrowdata-l" >%value version%</td>
				</tr>
				<tr>
					<td class="oddrow" nowrap>Updates</td>
					%ifvar patches%
						<td class="oddrowdata-l">
							%loop patches%
								%value%<br>
							%endloop%
						</td>
					%else%
						<td class="oddrowdata-l">None</td>
					%endif%
				</tr>
				<tr>
					<td class="evenrow" nowrap>Build Number</td>
					<td class="evenrowdata-l" >%value build%</td>
				</tr>
				%endinvoke%
			</table>
		</td></tr>
	</table>
</body>
</HTML>