<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - STS Configuration Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <link rel="stylesheet" href="css/sts-config.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/sts-config.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; %ifvar name%Edit%else%Add New%endif% STS Configuration
</div>

%ifvar action equals('save')%
    %invoke cloudstreams.stsconfig:saveConfig%
        %ifvar status equals('saved')%
            <div class="success">Successfully saved STS configuration [%value name%]</div>
        %else%
            <div class="error">Error saving STS configuration [%value name%]. %value error%</div>
        %endif%
    %endinvoke%
%endif%

<div id="container">
    <ul class="listitems">
        <li>
            <a href="sts-config.dsp">Return</a>
        </li>
    </ul>
    <div class="required-msg">Fields marked with <span class="required">*</span> are required</div>
    <form action="sts-config-edit.dsp" method="POST">
        <div id="stsConfig" class="config">
            <table id="basicConfigTable" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">%ifvar name%%value name% Configuration%else%STS Configuration%endif%</th>
                </tr>
                </thead>
                <tbody>
                %invoke cloudstreams.stsconfig:getConfig%
                <tr>
                    <td nowrap>Name<span class="required">*</span></td>
                    <td><input type="text" name="stsName" value="%value name%"/></td>
                </tr>
                <tr>
                    <td nowrap>Endpoint<span class="required">*</span></td>
                    <td><input class="url" type="text" name="endpoint" value="%value endpoint%"/></td>
                </tr>
                <tr>
                    <td nowrap>Token Type</td>
                    <td>
                        <select name="tokenType">
                            %loop tokenTypes%
                            <option
                            %ifvar ../tokenType vequals(tokenType)% selected %endif%/>%value tokenType%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td nowrap>WS-Trust Version</td>
                    <td>
                        <select name="trustVersion">
                            %loop versions%
                            <option
                            %ifvar ../trustVersion vequals(version)% selected %endif%/>%value version%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td nowrap>Time-To-Live (TTL)</td>
                    <td><input type="text" value="%value ttl%" name="ttl"/> <span>seconds</span></td>
                </tr>
                <tr>
                    <td nowrap>KeyStore</td>
                    <td>
                        <select name="ksHandle">
                            %loop keystores%
                            <option
                            %ifvar ../ksHandle vequals(keystoreName)% selected %endif% />%value keystoreName%
                            %endloop%
                        </select>
                         <div id="busy"><img src="images/ajax_busy_sm.gif" alt="busy"/></div>
                    </td>
                </tr>
                %rename ../ksHandle ksName -copy%
                %invoke cloudstreams.stsconfig:getKeyStoreAliases%
                <tr>
                    <td>
                        <label for="signRequest">Sign Request</label>
                    </td>
                    <td>
                        <input name="isSignRequest" id="signRequest" type="checkbox"
                        %ifvar isSignRequest equals('true')% checked='checked' value='true' %endif% />
                    </td>
                </tr>
                <tr>
                    <td nowrap>Signing Alias</td>
                    <td>
                        <select name="signingAlias">
                            %loop pkAliases%
                            <option
                            %ifvar ../signingAlias vequals(alias)% selected %endif% />%value alias%
                            %endloop%
                        </select>
                    </td>
                </tr>
                <tr>
                    <td  nowrap>
                        <label for="encRequest">Encrypt Request</label>
                    </td>
                    <td>
                        <input name="isEncRequest" id="encRequest" type="checkbox"
                        %ifvar isEncRequest equals('true')% checked='checked' value='true' %endif% />
                    </td>
                </tr>
                <tr>
                    <td nowrap>Encryption Alias</td>
                    <td>
                        <select name="encryptionAlias">
                            %loop certAliases%
                            <option
                            %ifvar ../encryptionAlias vequals(alias)% selected %endif%/>%value alias%
                            %endloop%
                        </select>
                    </td>
                </tr>
                %endinvoke getKeyStoreAliases%

                </tbody>
            </table>
            <table id="httpAuthTable" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">HTTP Basic Authentication</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Username</td>
                    <td><input type="text" name="httpUser" value="%value httpUser%"></td>
                </tr>
                <tr>
                    <td nowrap>Password</td>
                    <td><input type="password" name="httpPwd" value=""></td>
                </tr>
                </tbody>
            </table>
            <table id="usernameTokenTable" class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">WS-Security Username Token</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Username</td>
                    <td><input type="text" name="wsUser" value="%value wsUser%"></td>
                </tr>
                <tr>
                    <td nowrap>Password</td>
                    <td><input type="password" name="wsPwd" value=""></td>
                </tr>
                <tr>
                    <td nowrap>Password Type</td>
                    <td>
                        <select name="wsPwdType">
                            %loop pwdTypes%
                              <option %ifvar ../wsPwdType vequals(pwdType)% selected %endif% value=%value pwdType%>
                                %value pwdTypeDisplay%</option>
                            %endloop%
                        </select>
                    </td>
                </tr>
                </tbody>
            </table>
            %endinvoke getConfig%
        </div>

        <div id="formButtons">
            <input type="submit" name="btnSubmit" id="btnSubmit" value="Save" accesskey="s"/>
        </div>

        <input type ="hidden" name="name" value="%value name%"/>
        <input type="hidden" id="action" name="action" value="save"/>
        
    </form>

</div>

</body>
</html>