<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Integration Server - CloudStreams Consumers</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
	<link rel="stylesheet" href="css/consumers-list.css" type="text/css"/>
    <script src="/WmRoot/webMethods.js.txt"></script>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
	<script src="js/consumers.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">CloudStreams &gt; Administration &gt; Consumers </div>
<div id="container">
    <ul class="listitems">
        <li>
            <a href="consumer-edit.dsp">Add New Consumer</a>
        </li>
    </ul>

    %ifvar action equals('delete')%
        %invoke cloudstreams.consumers:deleteConsumer%
            %ifvar is.consumer.deleted equals('true')%
                <div class="success">Successfully deleted consumer '%value name%'!</div>
            %else%
                <div class="warning">Consumer '%value name%' deletion may have failed! Please check the log for more information!</div>
            %endif%
        %onerror%
            <div class="error">Error deleting Consumer [%value name%]! %value errorMessage%</div>
        %endinvoke%
    %endif%

   %invoke cloudstreams.consumers:getConsumers%
    <div class="consumer">
        <table class="tableView">
            <thead>
                <tr>
                    <th colspan="4" class="heading">Consumers</th>
                </tr>
            </thead>
            <tbody>
                <tr class="subheading2">
                    <td class="oddcol-l">Name</td>
                    <td class="oddcol">Created</td>
                    <td class="oddcol">Modified</td>
                    <td class="oddcol">Delete</td>
                </tr>
                <script>resetRows();</script>
            %ifvar consumers -notempty%
                %loop consumers%
                    <tr>
                        <script>writeTD("rowdata-l");</script>
                            <a href="consumer-edit.dsp?name=%value name%">%value name%</a>
                        </td>
                        <script>writeTD("rowdata");</script> %value created%</td>
                        <script>writeTD("rowdata");</script> %value modified%</td>
                        <script>writeTD("rowdata");</script>
                            <a class="delConsumerLnk" href="consumers.dsp?action=delete&name=%value name%">
                                <img src="/WmRoot/icons/delete.gif" alt="Delete Consumer"/>
                                 <span class="consumerName">%value name%</span>
                            </a>
                        </td>
                    </tr>
                    <script>swapRows();</script>
                %endloop%
            
            %else%
                <tr><td colspan="4" class="info" align="left">No consumers configured</td></tr>
            %endif%
            </tbody>
            </table>
        </div>

   %endinvoke%
</div>
</body>
</html>
