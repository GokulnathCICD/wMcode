<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
    <title>Integration Server - OAuth Access Tokens</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/oauthTokens-edit.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
	<script src="js/csConnection.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/oauthTokens-edit.js" type="text/javascript"></script>
</head>
<body onload='resetPasswordFields();'>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; %ifvar aliasName%Edit%else%Add New%endif% OAuth Token Configuration
</div>
<div id="container">
<!--
    %switch action%
    %case 'editAlias'%
        %invoke cloudstreams.oauth:updateAlias%
            %ifvar status equals('true')%
                 <div class="success">Successfully saved access token '%value aliasName%' alias!</div>
            %else%
        <div class="error">Error saving OAuth Token configuration [%value aliasName%]. %value errorMessage%</div>
            %endif%
        %onerror%
            <div class="error">Unexpected error saving access token [%value aliasName%] configuration! Please see server log for more information.</div>
        %endinvoke%
    %endswitch%
-->
    <ul class="listitems">
        <li><a href="oauthTokens.dsp">Return to list</a></li>
    </ul>
    <div class="required-msg">Fields marked with <span class="required">*</span> are required</div>

    %invoke cloudstreams.oauth:lookupAliasDetails%
	<form action="oauthTokens.dsp" method="post">
        <table class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">OAuth Token Configuration%ifvar aliasName%[%value aliasName%]%endif%</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap><label for="aliasName">Name<span class="required">*</span></label></td>
                <td><input type="text" name="aliasName" id="aliasName" value="%value aliasName%"/></td>
            </tr>
            <tr>
                <td nowrap><label for="providerId">Provider<span class="required">*</span></label></td>
                <td><input type="text" name="providerId" id="providerId" value="%value providerId%"/></td>
            </tr>
            <tr>
                <td nowrap>OAuth Version<span class="required">*</span></td>
                <td>
                    <input type='radio' name='oauthVersion' %ifvar oauthVersion equals('V10a')%CHECKED%endif%  value='V10a'>V1.0a</input>
                    <input type='radio' name='oauthVersion' %ifvar oauthVersion equals('V20')%CHECKED%endif%  value='V20'>V2.0</input>
              
                </td>
            </tr>
            <tr>
                <td nowrap><label for="clientId">Consumer ID<span class="required">*</span></label></td>
                <td><input type="text" class="wideField" name="clientId" id="clientId" value="%value clientId%"/></td>
            </tr>
            <tr>
                <td nowrap><label for="clientSecret">Consumer Secret<span id="clientSecretSpan" class="required">*</span></label></td>
                <td><input type="password" class="wideField" name="clientSecret" id="clientSecret" value="*******"  placeholder="******" 
				onclick="this.select()" onchange="passwordChanged(this.form, 'clientSecret')"/></td>
            </tr>
            <tr>
                <td nowrap><label for="accessToken">Access Token<span class="required">*</span></label></td>
                <td><input type="password" class="wideField" name="accessToken" id="accessToken" value="" 
				placeholder="******" onclick="this.select()" onchange="passwordChanged(this.form, 'accessToken')"/></td>
            </tr>
            <tr id='accessTokenSecretRow'>
                <td nowrap><label for="accessTokenSecret">Access Token Secret<span class="required">*</span></label></td>
                <td><input type="password" class="wideField"  name="accessTokenSecret" id="accessTokenSecret"  value="" placeholder="******" 
				onclick="this.select()" onchange="passwordChanged(this.form, 'accessTokenSecret')"/></td>
            </tr>
            <tr id='instanceUrlRow'>
                <td nowrap><label for="instanceUrl">Instance URL</label></td>
                <td><input type="text" class="wideField" name="instanceUrl" id="instanceUrl" value="%value instanceUrl%"/></td>
            </tr>
			
			<tr id='refreshTokenCheck'>
                <td nowrap><label for="refreshTokenCheck">Refresh Access Token</label></td>
                <td><input type="checkbox" name="refreshTokenCheck" id="refreshTokenCheck" %ifvar refreshTokenCheck equals('true')% checked='checked' %endif%/></td>
				
            </tr>
			<tr id='refreshTokenRow'>
                <td nowrap><label for="refreshToken">Refresh Token<span class="required">*</span></label></td>
                <td><input type="password" class="wideField" name="refreshToken" id="refreshToken" value="" placeholder="******" 
				onclick="this.select()" onchange="passwordChanged(this.form, 'refreshToken' )"/></td>
            </tr>
            <tr id='refreshUrlRow'>
                <td nowrap><label for="refreshUrl">Refresh URL<span class="required">*</span></label></td>
                <td><input type="text" class="wideField" name="refreshUrl" id="refreshUrl" value="%value refreshUrl%"/></td>
            </tr>
			 <tr id='refreshURLAccessType'>
                    <td nowrap><label for="refreshURLAccessType">Refresh URL Request<span class="required">*</span></label></td>
					%invoke cloudstreams.oauth:getRefreshURLRequestTypes%
                    <td><select id="refreshAccessType" name="refreshAccessType">
                        %loop destinationTypes%
						<option value="%value val%" %ifvar val vequals(../refreshAccessType)%selected='selected'%endif%>%value name%</option>
                        %endloop%
                        %endinvoke%
                    </select>
					<div class="service-hint">(HTTP POST request, select how parameters are sent)</div></td>
					</td>
                </tr>
            </tbody>
        </table>
		
		 <div id="destinationConfig" >
                <table id="esbConfig" %ifvar ../refreshAccessType equals('ESB')%class='visible'%else%class='hidden'%endif%>
                    <thead>
                    <tr><th colspan="2"  class="heading">Custom ESB Service Configuration</th></tr>
                    </thead>
                    <tbody>
                    <tr id='esbCustomService'>
                      <td nowrap>Service Name<span class="required">*</span></td>
                      <td><input class="url" type=text id="refreshRequestTypeCustomService"
                                 name="refreshRequestTypeCustomService" value="%value refreshRequestTypeCustomService%"/><div class="service-hint">(e.g. folder1.folder2:oauthRefreshServiceName)</div>
								 </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="formButtons">
            <input type="submit" id="btnSubmit" value="Save"/>
        </div>
	<input type="hidden" name="passwordChange" value="">
        <input type="hidden" id="action" name="action" value="editAlias"/>
    	<input type="hidden" name="origAliasName" value="%value aliasName%"/> <!-- the oauth alias name being edited -->		
    </form>
    %onerror%
        <div class="error">Error loading token alias '%value aliasName%' details! %value errorMessage%</div>
    %endinvoke%

</div>
</body>
</html>