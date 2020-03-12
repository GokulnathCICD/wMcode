<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Streaming Providers</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/streaming.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="/WmRoot/webMethods.js.txt" type="text/javascript"></script>
    <script src="js/streaming-providers.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>
<body>
<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Streaming Providers
</div>

%ifvar action equals('delete')%
    %invoke cloudstreams.streaming:deleteProvider%
        %ifvar config.deleted equals('true')%
            <div class="success">Successfully deleted Provider Configuration: %value ../name%</div>
        %else%
            <div class="error">Error occurred when deleting Provider Configuration : %value ../name%! [%value delete.error%]</div>
        %endif%
    %endinvoke%
%endif%

%invoke cloudstreams.streaming:getAllProviders%
<div id="container">
    <form action="streaming-providers.dsp" method="POST">
        <ul class="listitems">
            <li>
                <a href="streaming-provider-edit.dsp?action=add">Add New Provider</a>
            </li>
        </ul>

        <table id="providersTable" class="tableView">
            <thead>
                <tr>
                    <th class="heading" colspan="6">Streaming Providers</th>
                </tr>
            </thead>
            <tbody>
                <tr class="subheading2">
                    <td width="15%" class="oddcol-l">Provider Name</td>
                    <td width="35%" class="oddcol">Streaming Endpoint</td>
                    <td class="oddcol">API Version</td>
                    <td class="oddcol">Client Type</td>
                    <td class="oddcol">Authentication Type</td>
                    <td class="oddcol">Delete</td>
                </tr>
                %ifvar providers -notempty%
                %loop providers%
                <tr>
                    <script>writeTD("rowdata-l");</script>
                        <a href="streaming-provider-edit.dsp?action=edit&name=%value streaming.prov.name%">%value streaming.prov.name%</a>
                    </td>
                    <script>writeTD("rowdata");</script>%value streaming.prov.endpoint%</td>
                    <script>writeTD("rowdata");</script>%ifvar streaming.prov.api.version -notempty% %value streaming.prov.api.version% %else%--%endif%</td>
                    <script>writeTD("rowdata");</script>%value streaming.prov.client.type%</td>
                    <script>writeTD("rowdata");</script>
                        %ifvar streaming.prov.authn.type -notempty%
                            %value streaming.prov.authn.type%
                            %ifvar streaming.prov.authn.alias -notempty%(%value streaming.prov.authn.alias%)%endif%
                        %else% -- %endif%
                    </td>
                    <script>writeTD("rowdata");</script>
                        <a class="deleteConfig" href="streaming-providers.dsp?action=delete&name=%value streaming.prov.name%" name='%value streaming.prov.name%'>
                            <img src="/WmRoot/icons/delete.gif" alt="delete" style="border:none;"/>
                        </a>
                    </td>
                </tr>
                %endloop%
                %else%
                <tr id="noProviders"><td colspan="7" class="info" align="left">No streaming providers configured</td></tr>
                %endif%
            </tbody>
        </table>
    </form>
</div>
%endinvoke%
</body>
</html>