<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - Email Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/email-config.js" type="text/javascript"></script>
</head>

<body onload='resetPasswordFields();'>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Edit Email Configuration
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
               <span>Successfully saved CloudStreams email configuration!</span>
           </div>
        %endif%
    %endinvoke%
%else%
     %ifvar action equals('test')%
        %invoke cloudstreams.Email:testEmailConnection%
             %ifvar errorMessages -notempty%
                <div class="error">
                  <span>Failed to send test email! Following errors were reported:</span>
                  <ul class="listitems">
                  %loop errorMessages%
                        <li>%value errorMessages%</li>
                  %endloop%
                  </ul>
                </div>
             %else%
               <div class="success">
                   <span>Success! Test email sent to recipient address: %value pg.email.test.recipient%</span>
               </div>
             %endif%
        %endinvoke%
    %endif%
%endif%
%invoke cloudstreams.UIConfig:getConfigProps%

<div id="container">   
    <ul class="listitems">
        <li><a href="email-config.dsp">Return</a></li>
    </ul>

    <!-- Email (SMTP) CONFIG -->
<form action="email-config-edit.dsp" method="post">
	<input type="hidden" id="form-tag" name="form-tag" value="email-config-edit"/>
    <div id="emailConfig" class="config">
        <table class="tableView" summary="Table to input Email config information">
            <thead>
            <tr>
                <th colspan="2" class="heading">
                    <span>Email Configuration</span>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap>SMTP Host Name/IP Address</td>
                <td><input class="url" name="pg.email.smtpHost" type="text" value="%value pg.email.smtpHost%"/></td>
            </tr>
            <tr>
                <td nowrap>Port</td>
                <td><input name="pg.email.smtpPort" type="text" value="%value pg.email.smtpPort%"/></td>
            </tr>
            <tr>
                <td nowrap>User</td>
                <td><input name="pg.email.userName" type="text" value="%value pg.email.userName%"/></td>
            </tr>
            <tr>
                <td nowrap>Password</td>
                <td><input name="pg.email.password" type="password"
                            %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% /></td>
            </tr>
            <tr>
                <td nowrap>Confirm Password</td>
                <td>
                    <div>
                        <input name="check.pg.email.password" type="password"
                                 %ifvar action equals('test')% value="%value pwd%" %else% value="" %endif% />
                         <span class="hidden">Passwords don't match!</span>
                    </div>
                </td>
            </tr>
            <tr>
                <td nowrap>From</td>
                <td><input name="pg.email.from" type="text" value="%value pg.email.from%"/></td>
            </tr>
            <tr>
                <td>
                    <label for="pg.email.TLSEnabled">TLS Enabled</label>
                </td>
                <td>
                    <input name="pg.email.TLSEnabled" id="pg.email.TLSEnabled" type="checkbox"
                    %ifvar pg.email.TLSEnabled equals('true')% checked='checked' value='true' %endif%/>
                </td>
            </tr>
            <tr>
                <td nowrap>Test Recipient</td>
                <td><input name="pg.email.test.recipient" type="text" value="%value pg.email.test.recipient%"/></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="formButtons">
        <input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
        <input type="button" name="btnTest" id="btnTest" value="Test"/>
    </div>

    <input type="hidden" id="action" name="action" value="save"/>
</form>    
</div>
%endinvoke%

</body>
</html>