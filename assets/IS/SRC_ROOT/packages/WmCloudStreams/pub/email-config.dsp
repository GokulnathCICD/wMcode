<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - Email Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
</head>

<body>
%invoke cloudstreams.UIConfig:getConfigProps%
<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Email
</div>

<div id="container">
    <ul class="listitems">
        <li><a href="email-config-edit.dsp">Edit</a></li>
    </ul>

    <!-- Email (SMTP) CONFIG -->

    <div id="emailConfig" class="config">
    <table class="tableView" summary="Email config information">
        <thead>
        <tr>
            <th colspan="2" class="heading">Email Configuration</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td nowrap>SMTP Host Name/IP Address</td>
            <td>%value pg.email.smtpHost%</td>
        </tr>
        <tr>
            <td nowrap>Port</td>
            <td>%value pg.email.smtpPort%</td>
        </tr>
        <tr>
            <td nowrap>User</td>
            <td>%value pg.email.userName%</td>
        </tr>
        <tr>
            <td nowrap>From</td>
            <td>%value pg.email.from%</td>
        </tr>
        <tr>
            <td>
                <label for="tlsEnabled">TLS Enabled</label>
            </td>
            <td>
                <input name="tlsEnabled" id="tlsEnabled" type="checkbox" disabled readonly
                %ifvar pg.email.TLSEnabled equals('true')% checked %endif%/>
            </td>
        </tr>
    </table>

</div>

</div>
%endinvoke%

</body>
</html>