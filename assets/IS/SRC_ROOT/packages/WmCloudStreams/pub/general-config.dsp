<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - General Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
</head>

<body>
%invoke cloudstreams.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; General
</div>

<div id="container">
    <ul class="listitems">
        <li><a href="general-config-edit.dsp">Edit</a></li>
    </ul>

    <div id="mediatorConfig" class="config">
        <table class="tableView" summary="Table showing Mediator runtime config information">
            <thead>
            <tr>
                <th colspan="2" class="heading">General Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap>Target Name</td>
                <td>%value pg.policygateway.targetName%</td>
            </tr>
            <tr>
                <td nowrap>HTTP Load Balancer URL</td>
                <td>%value pg.lb.http.url%</td>
            </tr>
            <tr>
                <td nowrap>HTTPS Load Balancer URL</td>
                <td>%value pg.lb.https.url%</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div id="keystoreConfig" class="config">
        <table class="tableView" summary="Table showing CloudStreams Keystore runtime config information">
            <thead>
            <tr>
                <th colspan="2" class="heading">Keystore Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap>Keystore Name</td>
                <td>
                    %value pg.keystore.keyStoreHandle%
                </td>
            </tr>
            <tr>
                <td nowrap>Signing Alias</td>
                <td>%value pg.rampartdeploymenthandler.signingCertAlias%</td>
            </tr>
            <tr>
                <td nowrap>Truststore Name</td>
                <td>
                    %value pg.keystore.trustStoreHandle%
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div id="portsConfig" class="config">
        %invoke cloudstreams.UIConfig:getPorts%
        <table class="tableView" summary="Table showing CloudStreams HTTP and HTTPS ports information">
            <thead>
            <tr>
                <th colspan="2" class="heading">Ports Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap>HTTP Ports</td>
                <td>%loop SelectedHttpPorts%
                    %value port%&nbsp;&nbsp;
                    %endloop%
                </td>
            </tr>
            <tr>
                <td nowrap>HTTPS Ports</td>
                <td>%loop SelectedHttpsPorts%
                    %value port%&nbsp;&nbsp;
                    %endloop%
                </td>
            </tr>
            </tbody>
        </table>
        %onerror%
        <div class="error">Error [%value error%: %value errorMessage%] occurred while loading ports information!</div>
        %endinvoke%
    </div>

    <div id="wirelogdiv" class="config">
        <table class="tableView">
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
                <td><input name="wst.connfactory.wirelogEnabled" type="checkbox" id="wirelog"
                    %ifvar wst.connfactory.wirelogEnabled equals('true')% checked='checked' %endif% disabled='disabled'></td>
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
                <td><input name="wst.largedata.binaryStreamEnabled" type="checkbox" id="binaryStreamEnabled"
                    %ifvar wst.largedata.binaryStreamEnabled equals('true')% checked='checked' %endif% disabled='disabled'></td>
            </tr>
            <tr>
                <td>
                    <label for="threshold">Threshold Size (bytes)</label>
                </td>
				<td>%value wst.largedata.threshold%</td>
            </tr>
			
            </tbody>
        </table>

    </div>	

</div>
%endinvoke%

</body>
</html>