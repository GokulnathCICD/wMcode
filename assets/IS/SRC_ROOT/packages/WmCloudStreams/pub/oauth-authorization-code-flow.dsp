<html>
	<head>
		<title>OAuth 2.0 Authorization Code Flow</title>
		<script type="text/javascript" src="js/jquery-min.js"></script>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		</LINK>
		<link rel="stylesheet" href="css/messages.css" type="text/css"/>
		<link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
		<SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
		<SCRIPT src="js/messages.js"></SCRIPT>
		<script src="js/csConnection.js"></script>
		<SCRIPT SRC="js/oauth-util-functions.js"></SCRIPT>
		<SCRIPT SRC="js/oauth-authorization-code-flow.js"></SCRIPT>
		<SCRIPT style="text/javascript">
			setHostname("%value $host%");
		</SCRIPT>
		<style type="text/css">
			td:first-child { text-align: right };
		</style>
	</head>
	<body style="border-spacing: 0; border-width:0">

		<form action="#">
			<table id="mainTable" class="tableView" width="100%" />
				<!-- all rows dynamically updated -->
				
				<table class="tableView" width="100%">
					<tr>
						<td class="heading" colspan=2>Proxy</td>
					</tr>
					<tr>
						<td nowrap>Proxy Server Alias</td>
						<td style="padding-top: 0.5em; padding-right: 0.5em; padding-bottom: 0.5em; padding-left: 1em;">
							<select name="proxyAlias">
								<option value=""></option>
								%invoke wm.server.proxy:getProxyServerList%
									%loop -struct proxyServerList%
									%scope #$key%
										<option %ifvar isDefault equals('Y')% selected %endif% >%value proxyAlias%</option>
									%endloop%
								%endinvoke%
							</select>
						</td>
					</tr>
				</table>
				<table style="margin-top: 10px" width=100%>
					<tr>
						<td class="action" colspan="3" style="text-align: left">
							<input type="button" id="authorize" value="Authorize" width="100%"/>
							<!--input type="button" id="next" value="Next" style="padding: 0px 15px;" width="100%" /-->
						</td>
					</tr>
				</table>
			</table>
			
		</form>
	</body>
</html>