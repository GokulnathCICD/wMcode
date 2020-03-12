<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>CloudStreams - Service Fault Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
</head>
<body>
%invoke cloudstreams.UIConfig:getServiceFaultConfig%
%ifvar messages -notempty%
<div class="error">
    <span>Following errors were reported during CloudStreams configuration load:</span>
    <ul class="listitems">
        %loop messages%
        <li>%value message%</li>
        %endloop%
    </ul>
</div>
%endif%
%endinvoke%

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Service Fault Configuration
</div>

<div id="container">
    <ul class="listitems">
        <li><a href="service-fault-config-edit.dsp">Edit</a></li>
    </ul>

    <!-- SERVICE FAULT CONFIG -->
    <div id="serviceFaultConfig" class="config">
        <table summary="Service fault config information" class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Service Fault Configuration</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap valign="top">Default Fault Response</td>
                <td><textarea id="pg.providerFault" class="right faultReason" disabled>%value pg.providerFault.reason%</textarea></td>
            </tr>
            <tr>
                <td>
                    Send native provider fault (when available)
                </td>
                <td>
                    <input type="checkbox" name="pg.providerFault.enabled" disabled
                    %ifvar pg.providerFault.enabled equals('true')% checked='checked' value='true'
                    %endif%/>
                </td>
            </tr>
            </tbody>
        </table>

    </div>

</div>
%endinvoke%
</body>
</html>