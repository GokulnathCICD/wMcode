<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - General Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <link rel="stylesheet" href="css/general-config-edit.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/general-config.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Edit General Configuration
</div>

%ifvar action equals('save')%
    %invoke cloudstreams.UIConfig:saveConfigProps%
        %ifvar messages -notempty%
           <div class="error">
              <span>Following errors were reported during save:</span>
              <ul class="listitems">
              %loop messages%
                    <li>%value message%</li>
              %endloop%
              </ul>
           </div>
        %else%
           <div class="success">
               <span>Successfully saved CloudStreams configuration!</span>
           </div>
        %endif%
    %endinvoke%
%endif%

%invoke cloudstreams.UIConfig:getConfigProps%

<div id="container">
    <ul class="listitems">
        <li><a href="general-config.dsp">Return</a></li>
    </ul>

    <form action="general-config-edit.dsp" method="post">
        <input type="hidden" id="form-tag" name="form-tag" value="general-config-edit"/>
        <div id="mediatorConfig" class="config">
            <table class='tableView' summary="Table to input CloudStreams runtime config information">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>General Configuration</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Target Name<span class="required">*</span></td>
                    <td><input name="pg.policygateway.targetName" type="text" class="url"
                               value="%value pg.policygateway.targetName%"/></td>
                </tr>
                <tr>
                    <td nowrap>HTTP Load Balancer URL</td>
                    <td><input class="url" name="pg.lb.http.url" type="text" value="%value pg.lb.http.url%"/></td>
                </tr>
                <tr>
                    <td nowrap>HTTPS Load Balancer URL</td>
                    <td><input class="url" name="pg.lb.https.url" type="text" value="%value pg.lb.https.url%"/></td>
                </tr>
                </tbody>
            </table>
        </div>

        <div id="keystoreConfig" class="config">
            <table class='tableView' summary="Table to input CloudStreams Keystore runtime config information">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>Keystore Configuration</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Keystore Name</td>
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
                    <td nowrap>Signing Alias</td>
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
                    <td nowrap>Truststore Name</td>
                    <td>
                        <select name="pg.keystore.trustStoreHandle">
                            <option value=""></option>
                            %invoke cloudstreams.UIConfig:getTrustStoreNames%
                                %loop trustStoreNames%
                                    <option %ifvar ../pg.keystore.trustStoreHandle vequals(name)% selected %endif% />%value name%
                                %endloop%
                            %endinvoke%
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div>
            %invoke cloudstreams.UIConfig:getPorts%
            %invoke cloudstreams.UIConfig:getPrimaryPort%
            
			<div id="httpPortsConfig" class="config">
				<table class="tableView" style="width: 70%;">
					<thead>
						<tr>
							<th colspan="2" class="heading">
								<span>HTTP Ports Configuration</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td nowrap>
								<div class="ports">
									<label>Available Ports</label>
									<select id="availableHttpPorts" multiple="multiple">
										%loop AvailableHttpPorts%
											<option>%value port%</option>
										%endloop%
									</select>
									<a href="#" id='addHttp' class='ports'>Add &#187;</a>
								</div>
							</td>
							<td>
								<div class="ports right">
									<label>Selected Ports</label>
									<select id="selectedHttpPorts" name="pg.http.ports" multiple="multiple">
										%loop SelectedHttpPorts%
											<option %ifvar /primaryPort vequals(port)% class='primary' %endif%>%value port%</option>
										%endloop%
									</select>
									<a href="#" id="removeHttp" class='ports'>&#171; Remove</a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

            <div id="httpsPortsConfig" class="config">
                <table class="tableView" style="width: 70%;">
					<thead>
						<tr>
							<th colspan="2" class="heading">
								<span>HTTPS Ports Configuration</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td nowrap>
								<div class="ports">
									<label>Available Ports</label>
									<select id="availableHttpsPorts" multiple="multiple">
										%loop AvailableHttpsPorts%
										<option>%value port%</option>
										%endloop%
									</select>
									<a href="#" id="addHttps" class='ports'>Add &#187;</a>
								</div>
							</td>
							<td>
								<div class="ports right">
									<label>Selected Ports</label>
									<select id="selectedHttpsPorts" name="pg.https.ports" multiple="multiple">
										%loop SelectedHttpsPorts%
											 <option>%value port%</option>
										%endloop%
									</select>
									<a href="#" id="removeHttps" class='ports'>&#171; Remove</a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
            </div>
            %endinvoke%
            %onerror%
                   <div class="error">Error [%value error%: %value errorMessage%] occurred while loading ports information!</div>
            %endinvoke%
        </div>

        <div id="wirelogdiv" class="config">
            <table class='tableView'>
                <thead>
                <tr>
                    <th colspan="2" class="heading">Connection Logging</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <label for="wirelog">Connection factory wire logging</label>
                    </td>
                    <td>
                        <input name="wst.connfactory.wirelogEnabled" type="checkbox" id="wirelog" onchange="javascript:confirmWireLogging()"
                        %ifvar wst.connfactory.wirelogEnabled equals('true')% checked='checked' %endif% >
                    </td>
                </tr>
                </tbody>
            </table>

        </div>

    <div id="largeBinaryStreamDiv" class="config">
        <table class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Large Data Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <label for="binaryStreamEnabled">Handle Binary Streams</label>
                </td>
                <td><input name="wst.largedata.binaryStreamEnabled" type="checkbox" id="binaryStreamEnabled" onchange="javascript:confirmLargeBinaryStream()"
                    %ifvar wst.largedata.binaryStreamEnabled equals('true')% checked='checked' %endif% ></td>
            </tr>
            <tr>
                <td>
                    <label for="threshold">Threshold Size (bytes)</label>
                </td>
				<td><input class="wst.largedata.threshold" name="wst.largedata.threshold" id="threshold" type="text" value="%value wst.largedata.threshold%"/>
				</td>
            </tr>
			
            </tbody>
        </table>

    </div>	
		
        <div id="formButtons">
            <input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
        </div>

        <input type="hidden" id="action" name="action" value="save"/>
    </form>

</div>
%endinvoke%

</body>
</html>