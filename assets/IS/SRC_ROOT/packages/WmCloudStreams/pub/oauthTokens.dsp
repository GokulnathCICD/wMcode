<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
    <title>Integration Server - OAuth Access Tokens</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/oauthTokens-list.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="/WmRoot/webMethods.js.txt"></script>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/oauthTokens.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
   CloudStreams &gt; Administration &gt; OAuth Tokens
</div>
<div id="container">
    <ul class="listitems">
        <li>
            <a href="oauthTokens-create.dsp?action=add">Add New Token</a>
        </li>
    </ul>
	
 %ifvar action%
     %switch action%
	  %case 'deleteAlias'%
        %invoke cloudstreams.oauth:deleteAlias%
            %ifvar status equals('true')%
                <div class="success">Successfully deleted token alias '%value aliasName%'!</div>
            %else%
                <div class="warning">Error deleting access token [%value aliasName%] alias; Error: %value errorMessage%.</div>
            %endif%
        %onerror%
            <div class="error">Error deleting Alias [%value aliasName%]!  Please see server log for more information.</div>
        %endinvoke%
		
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
	 %case 'addAlias'%
        %invoke cloudstreams.oauth:addAlias%
            %ifvar status equals('true')%
                 <div class="success">Successfully saved access token '%value aliasName%' alias!</div>
				         
            %else%
        <div class="error">Error saving OAuth Token configuration [%value aliasName%]. %value errorMessage%</div>
            %endif%
        %onerror%
            <div class="error">Unexpected error saving access token [%value aliasName%] configuration! Please see server log for more information.</div>
        %endinvoke%	
		
	%endswitch%
   %endif%
   
    %invoke cloudstreams.oauth:listTokenAliases%
        <div class="tokenAlias">
            <table class="tableView">
                <thead>
                    <tr>
                        <th colspan="4" class="heading">OAuth Token Aliases</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="subheading2">
                        <td class="oddcol-l">Name</td>
                        <td class="oddcol">Provider</td>
                        <td class="oddcol">OAuth Version</td>
                        <td class="oddcol">Delete</td>
                    </tr>
                    <script>resetRows();</script>
                %ifvar aliases -notempty%
                    %loop aliases%
                    <tr>
                        <script>writeTD("rowdata-l");</script>
                            <a href="oauthTokens-edit.dsp?action=edit&aliasName=%value aliasName%">%value aliasName%</a>
                        </td>
                        <script>writeTD("rowdata");</script>%value providerId%</td>
                        <script>writeTD("rowdata");</script>%value oauthVersion%</td>
                        <script>writeTD("rowdata");</script>
                            <a class="delAliasLnk" href="oauthTokens.dsp?action=deleteAlias&aliasName=%value aliasName%">
                                <img src="/WmRoot/icons/delete.gif" alt="Delete Token Alias"/>
                                <span class="delAliasName">%value aliasName%</span></a>
                        </td>
                    </tr>
                    <script>swapRows();</script>
                    %endloop%
                %else%
                 <tr><td colspan="4" class="info" align="left">No OAuth token aliases configured</td></tr>
                %endif%
                </tbody>
            </table>
        </div>

    %endinvoke%
</div>
</body>
</html>
