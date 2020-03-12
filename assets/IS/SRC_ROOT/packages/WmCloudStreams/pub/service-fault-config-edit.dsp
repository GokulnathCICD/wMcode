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
    <script src="js/messages.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Edit Service Fault Configuration
</div>

%ifvar action equals('save')%
%invoke cloudstreams.UIConfig:saveServiceFaultConfig%
%ifvar messages -notempty%
<div class="error">
    <span>Following errors were reported during CloudStreams configuration save:</span>
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
%invoke cloudstreams.UIConfig:getServiceFaultConfig%

<div id="container">
    <ul class="listitems">
        <li><a href="service-fault-config.dsp">Return</a></li>
    </ul>

    <!-- SERVICE FAULT CONFIG -->
    <form action="service-fault-config-edit.dsp" method="post">
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
                    <td><textarea class="right faultReason" name="pg.providerFault.reason">%value pg.providerFault.reason%</textarea></td>
                </tr>
                <tr>
                    <td>
                        Send native provider fault (when available)
                    </td>
                    <td>
                        <input type="checkbox" name="pg.providerFault.enabled"
                        %ifvar pg.providerFault.enabled equals('true')% checked='checked' value='true'
                        %endif%/>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div id="formButtons">
            <input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
        </div>

    </form>

</div>
%endinvoke%
</body>
</html>