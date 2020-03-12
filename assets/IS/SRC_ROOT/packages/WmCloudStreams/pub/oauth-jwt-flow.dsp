<html>
	<head>
		<title>OAuth 2.0 JWT Flow</title>
		<script type="text/javascript" src="js/jquery-min.js"></script>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		</LINK>
		<link rel="stylesheet" href="css/messages.css" type="text/css"/>
		<link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
		<SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
		<SCRIPT src="js/messages.js"></SCRIPT>
		<SCRIPT src="js/csConnection.js"></SCRIPT>
		<SCRIPT SRC="js/oauth-util-functions.js"></SCRIPT>
		<SCRIPT SRC="js/oauth-jwt-flow.js"></SCRIPT>
		<!--SCRIPT SRC="js/general-config.js"></SCRIPT-->
		<style type="text/css">
			td:first-child { text-align: right };
		</style>
	</head>
	<body style="border-spacing: 0; border-width:0">
		<form action="#">
			<table id="mainTable" class="tableView" width="100%" />
				<!-- all rows dynamically updated -->
				<table class='tableView' summary="Table to input CloudStreams Keystore runtime config information">
					<tbody>
					<tr>
						<td class="heading" colspan=2>Keystore and Proxy</td>
					</tr>
					<tr>
						<td nowrap>Keystore Name*</td>
						<td>
							<select name="pg.keystore.keyStoreHandle">
								<option value=""></option>
								%invoke cloudstreams.UIConfig:getKeyStoreNames%
									%loop keyStoreNames%
										<option %ifvar ../pg.keystore.keyStoreHandle vequals(name)% selected %endif% />%value name%
									%endloop%
								%endinvoke%
							</select>
						</td>
					</tr>
					<tr>
						<td nowrap>Signing Alias*</td>
						<td>
							<select name="pg.rampartdeploymenthandler.signingCertAlias">
								<option value=""></option>
								%invoke cloudstreams.UIConfig:getAliases%
									%loop aliasNames%
										<option %ifvar ../pg.rampartdeploymenthandler.signingCertAlias vequals(name)%
												selected %endif% />%value name%
									%endloop%
								%endinvoke%
							</select>

							<div id="busy"><img src="images/ajax_busy_sm.gif" alt="busy"/></div>
						</td>
					</tr>
					<tr>
						<td nowrap>Proxy Server Alias</td>
						<td>
							<select name="proxyAlias">
								<option value=""></option>
								%invoke wm.server.proxy:getProxyServerList%
									%loop -struct proxyServerList%
									%scope #$key%
										<option %ifvar isDefault equals('Y')% selected %endif%>%value proxyAlias%</option>
										<!--option>%value proxyAlias%</option-->
									%endloop%
								%endinvoke%
							</select>
						</td>
					</tr>
					</tbody>
				</table>
				<table style="margin-top: 10px" width=100%>
					<tr>
						<td class="action" colspan="3" style="text-align: left">
							<input type="button" id="getToken" value="Get Token" width="100%"/>
							<!--input type="button" id="next" value="Next" style="padding: 0px 15px;" width="100%" /-->
						</td>
					</tr>
				</table>
			</table>
		</form>
	</body>
</html>