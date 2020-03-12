<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Streaming Subscribers</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/streaming.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="/WmRoot/webMethods.js.txt" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/streaming-subscribers.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
</head>
<body>
<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Streaming Subscribers
</div>

%switch action%
  %case 'delete'%
    %invoke cloudstreams.streaming:deleteSubscriber%
        %ifvar config.deleted equals('true')%
            <div class="success">Successfully deleted subscriber configuration: %value ../name%</div>
        %else%
            <div class="error">Error deleting subscriber configuration : %value ../name%! [%value delete.error%]</div>
        %endif%
    %endinvoke%
  %case 'toggleStatus'%
     %invoke cloudstreams.streaming:toggleSubscriberStatus%
         %ifvar streaming.sub.isenabled%
            <div class="success">%ifvar streaming.sub.isenabled equals('true')%Enabled subscriber:%else%Disabled subscriber:%endif%%value ../name%</div>
        %else%
            <div class="error">%value err%</div>
        %endif%
     %onerror%
            <div class="error">Unexpected error updating Subscriber status! [%value errorMessage%]</div>
     %endinvoke%
%endswitch%

%invoke cloudstreams.streaming:getAllSubscribers%
<div id="container">
    <form action="streaming-subscribers.dsp" method="POST">
        <ul class="listitems">
            <li>
                <a href="streaming-subscriber-edit.dsp?action=add">Add New Subscriber</a>
            </li>
        </ul>

        <table id="subscribersTable" class="tableView">
            <thead>
                <tr>
                    <th class="heading" colspan="6">Streaming Subscribers</th>
                </tr>
            </thead>
            <tbody>
                <tr class="subheading2">
                    <td width="15%" class="oddcol-l">Subscriber Name</td>
                    <td width="15%" class="oddcol">Provider</td>
                    <td width="25%" class="oddcol">Channel Endpoint</td>
                    <td class="oddcol">Destination</td>
                    <td width="100px" class="oddcol">Enabled</td>
                    <td width="100px" class="oddcol">Delete</td>
                </tr>
                %ifvar subscribers -notempty%
                %loop subscribers%
                <tr>
                    <script>writeTD("rowdata-l");</script><a href="streaming-subscriber-edit.dsp?action=edit&name=%value streaming.sub.name%">%value streaming.sub.name%</a></td>
                    <script>writeTD("rowdata");</script>%value streaming.sub.prov.name%</td>
                    <script>writeTD("rowdata");</script>%value streaming.sub.channel.endpoint%</td>
                    <script>writeTD("rowdata");</script>
                        %switch streaming.sub.dest.type%
                            %case 'ESB'%
                                %value streaming.sub.dest.esb.service%
                            %case 'JOURNAL_LOG'%
                                %value streaming.sub.dest.log.level% <span>(log level)</span>
                            %case 'JMS'%
                                %value -- %
                        %endswitch%
                    </td>
                    <script>writeTD("rowdata");</script>%ifvar streaming.sub.isenabled equals('true')%
                            <img width="13" height="13" border="0" src="/WmRoot/images/green_check.gif">
                            <a class='enabledSubscriberLnk' href="streaming-subscribers.dsp?name=%value streaming.sub.name%&action=toggleStatus">Yes</a>
                        %else%
                            <a class='disabledSubscriberLnk' href="streaming-subscribers.dsp?name=%value streaming.sub.name%&action=toggleStatus">No</a>
                        %endif%
                       </td>
                    <script>writeTD("rowdata");</script>
                        <a class="deleteConfig" href="streaming-subscribers.dsp?action=delete&name=%value streaming.sub.name%"
                           name='%value streaming.sub.name%'>
                            <img src="/WmRoot/icons/delete.gif" alt="delete" style="border:none;"/>
                        </a>
                    </td>
                </tr>
                %endloop%
                %else%
                <tr id="noSubscribers"><td colspan="7" class="info" align="left">No streaming subscribers configured</td></tr>
                %endif%
            </tbody>
        </table>
    </form>
</div>
%endinvoke%
</body>
</html>