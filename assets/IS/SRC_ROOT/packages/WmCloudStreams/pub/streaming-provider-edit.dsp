<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Streaming Provider</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/streaming.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	<link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/streaming-providers.js" type="text/javascript"></script>
</head>
<body>
<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; %ifvar name%Edit%else%Add New%endif% Streaming Provider Configuration
</div>

%ifvar action equals('save')%
    %invoke cloudstreams.streaming:saveProvider%
        %ifvar status equals('saved')%
            <div class="success">Successfully saved streaming provider configuration [%value name%]</div>
        %else%
            <div class="error">Error saving Streaming Provider configuration [%value name%].%value err%</div>
        %endif%
    %onerror%
        <div class="error">Unexpected error saving streaming provider configuration! %value errorMessage%</div>
    %endinvoke%
%endif%


<div id="container">
    <ul class="listitems">
        <li>
            <a href="streaming-providers.dsp">Return</a>
        </li>
    </ul>
    
    %invoke cloudstreams.streaming:getProvider%
    <form action="streaming-provider-edit.dsp" method="POST">
        <div id="mainCfg" class="config">
		<div class="required-msg" style="float:right; margin: -15px 0 0;">Fields marked with <span class="required">*</span> are required</div>
            <table class="tableView" style="margin: 32px 0 0;">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>Provider Configuration</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Provider Name<span class="required">*</span></td>
                    <td><input type="text" name="streaming.prov.name" value="%value streaming.prov.name%"/></td>
                </tr>
                <tr>
                    <td nowrap>Client Type</td>
                    <td><select name="streaming.prov.client.type">
                        %invoke cloudstreams.streaming:getProviderTypes%
                        %loop providerTypes%
                        <option value="%value val%"
                        %ifvar ../streaming.prov.client.type vequals(val)%selected%endif%>%value name%</option>
                        %endloop%
                        %endinvoke%
                    </select>
                    </td>
                </tr>
                <tr>
                    <td nowrap>API Version</td>
                    <td><input type="text" name="streaming.prov.api.version"
                               value="%value streaming.prov.api.version%"/></td>
                </tr>
                <tr>
                    <td nowrap>Streaming API Endpoint<span class="required">*</span></td>
                    <td><input class="url" type="text" name="streaming.prov.endpoint"
                               value="%value streaming.prov.endpoint%"/></td>
                </tr>
				<!--
                <tr>
                    <td>
                        <label for="streaming.prov.notify.meta.events">Notify Meta Channel Events</label>
                    </td>
                    <td>
                        <input type="checkbox" name="streaming.prov.notify.meta.events" id="streaming.prov.notify.meta.events"
                               value="%value streaming.prov.notify.meta.events%"
                        %ifvar streaming.prov.notify.meta.events equals('true')%checked=checked%endif%/>
                    </td>
                </tr>
				-->
                </tbody>
            </table>
        </div>
        <div id="connCfg" class="config">
            <table class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>Connection Configuration</span>
                    </th>
                </tr>
                </thead>
                <tbody>
				<!--
                <tr>
                    <td>
                        <label for="streaming.prov.conn.debug">Enable Debug</label>
                    </td>
                    <td>
                        <input type="checkbox" name="streaming.prov.conn.debug" id="streaming.prov.conn.debug"
                               value="%value streaming.prov.conn.debug%"
                        %ifvar streaming.prov.conn.debug equals('true')%checked='checked'%endif%/>
                    </td>
                </tr>
				-->
                <tr>
                    <td nowrap>Connection timeout</td>
                    <td><input type="text" name="streaming.prov.conn.timeout"
                               value="%value streaming.prov.conn.timeout%"/> milliseconds</td>
                </tr>
                <tr>
                    <td nowrap>Read timeout</td>
                    <td><input type="text" name="streaming.prov.conn.read.timeout"
                               value="%value streaming.prov.conn.read.timeout%"/> milliseconds</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div id="sslCfg" class="config">
            <table class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>SSL Configuration</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Truststore Alias</td>
                    <td><select name="streaming.prov.ssl.ts.alias">
                        <option value=""></option>
                        %invoke cloudstreams.UIConfig:getTrustStoreNames%
                        %loop trustStoreNames%
                        <option
                        %ifvar name vequals(../streaming.prov.ssl.ts.alias)% selected='selected'%endif%>%value name%</option>
                        %endloop%
                        %endinvoke%
                    </select></td>
                </tr>
                <tr>
                    <td nowrap>Keystore Alias</td>
                    <td><select name="streaming.prov.ssl.ks.alias">
                        <option value=""></option>
                        %invoke cloudstreams.UIConfig:getKeyStoreNames%
                        %loop keyStoreNames%
                        <option
                        %ifvar name vequals(../streaming.prov.ssl.ks.alias)% selected='selected'%endif%>%value name%</option>
                        %endloop%
                        %endinvoke%
                    </select></td>
                </tr>
                <tr>
                    <td>
                        <label for="streaming.prov.ssl.validateCerts">Validate Certificate</label>
                    </td>
                    <td>
                        <input type="checkbox" name="streaming.prov.ssl.validateCerts" id="streaming.prov.ssl.validateCerts"
                               value="%value streaming.prov.ssl.validateCerts%"
                        %ifvar streaming.prov.ssl.validateCerts equals('true')%checked='checked'%endif%/>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div id="authCfg" class="config">
            <table class="tableView">
                <thead>
                <tr>
                    <th colspan="2" class="heading">
                        <span>Authentication</span>
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td nowrap>Type</td>
                    <td><select name="streaming.prov.authn.type">
                        %invoke cloudstreams.streaming:getAuthnTypes%
                        <option value=""></option>
                        %loop authnTypes%
                        <option value="%value val%" %ifvar ../streaming.prov.authn.type vequals(val)%selected='selected'%endif%>%value name%</option>
                        %endloop%
                        %endinvoke%
                    </select></td>
                </tr>
                </tbody>
            </table>

            <div id="authnConfig">
                <table id="basicAuthCfg" %ifvar streaming.prov.authn.type equals('BASIC')%class='tableView'%else%class='hiddenConfig'%endif%>
                    <thead>
                    <tr>
                        <th colspan="2" class="heading">Basic Authentication Configuration</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td nowrap>Username</td>
                        <td><input type="text" value="%value streaming.prov.authn.basic.username%"
                                   name="streaming.prov.authn.basic.username"/></td>
                    </tr>
                    <tr>
                        <td nowrap>Password</td>
                        <td><input type="password" name="streaming.prov.authn.basic.pwd" value=""/></td>
                    </tr>
                    </tbody>
                </table>
                <table id="oauthAliasCfg" %ifvar streaming.prov.authn.type equals('OAUTH_1')%class='tableView'
                   %else%%ifvar streaming.prov.authn.type equals('OAUTH_2')%class='tableView'%else%class='hiddenConfig'%endif%%endif%>
                    <thead>
                    <tr>
                        <th colspan="2" class="heading">OAuth Alias Configuration</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td nowrap>Alias</td>
                    <td>
		    <input type='hidden' name='streaming.prov.authn.alias'/>
                    %invoke cloudstreams.oauth:listTokenAliases%
		    <select id='oauthV1Aliases' name="temp.alias1" %ifvar streaming.prov.authn.type equals('OAUTH_1')%class='visibleConfig' %else%class='hiddenConfig'%endif%>
                        <option value=""></option>
                        %loop aliases%
                            %ifvar oauthVersion equals('V10a')%
                                <option value="%value aliasName%" %ifvar aliasName vequals(../streaming.prov.authn.alias)% selected='selected'%endif%>%value aliasName%</option>
                            %endif%
                        %endloop%
		    </select>
                    <select id='oauthV2Aliases' name="temp.alias2" %ifvar streaming.prov.authn.type equals('OAUTH_2')%class='visibleConfig' %else%class='hiddenConfig'%endif%>
                        <option value=""></option>
                        %loop aliases%
                            %ifvar oauthVersion equals('V20')%
                                <option value="%value aliasName%" %ifvar aliasName vequals(../streaming.prov.authn.alias)% selected='selected'%endif%>%value aliasName%</option>
                            %endif%
                        %endloop%
		    </select>
                    %endinvoke%
		    </td>
                    </tr>
                    </tbody>
                </table>
                <table id="esbServiceCfg" %ifvar streaming.prov.authn.type equals('ESB_CALLBACK')%class='tableView'%else%class='hiddenConfig'%endif%>
                    <thead>
                    <tr>
                        <th colspan="2" class="heading">ESB Callback Configuration</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr><td nowrap>ESB Service Name</td>
                    <td><input class="url" type="text" name="streaming.prov.authn.esb.service" value="%value streaming.prov.authn.esb.service%"
                            /><div class="service-hint">(E.g. folder1.folder2:serviceName)</div></td>
                    </tr>
                    </tbody>
                </table>
            </div>


        </div>

        <div id="formButtons">
            <input type="submit" name="btnSubmit" id="btnSubmit" value="Save" accesskey="s"/>
        </div>

        <input type="hidden" name="name" value="%value name%"/>
        <input type="hidden" id="action" name="action" value="save"/>

    </form>
    %endinvoke%
</div>
</body>
</html>
