<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams - STS Configuration Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
	<link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
	<script src="js/sts-config.js" type="text/javascript"></script>
</head>

<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Security Token Service (STS)
</div>

%ifvar action -equals('delete')%
    %invoke cloudstreams.stsconfig:deleteConfig%
        %ifvar status -equals('deleted')%
            <div class="success">Succesfully deleted STS configuration [%value name%]</div>
        %else%
            <div class="error">Error occurred when deleting STS configuration [%value error%].</div>
        %endif%
    %endinvoke%
%endif%

<div id="container">
    <ul class="listitems">
        <li>
            <a href="sts-config-edit.dsp">Add New STS Configuration</a>
        </li>
    </ul>

    <div id="stsConfig" class="config">
        <table id="stsConfigList" class="tableView" summary="Table showing STS config information">
            <thead>
            <tr>
                <th colspan="3" class="heading">STS Configuration List</th>
            </tr>
            </thead>
            <tbody>
            <tr class="subheading2">
                <td class="oddcol-l">Name</td>
                <td class="oddcol">Endpoint</td>
                <td class="oddcol">Delete</td>
            </tr>
            %invoke cloudstreams.stsconfig:getAllConfigs%
            %ifvar configs -notempty%
                %loop configs%
                <tr>
                    %rename config/name stsName -copy%
                    <td class="evenrowdata-l"><a href="sts-config-edit.dsp?action=edit&name=%value config/name%">%value stsName%</a></td>
                    <td class="evenrowdata">%value config/endpoint%</td>
                    <td class="evenrowdata">
                        <a id='deleteConfig' href="sts-config.dsp?action=delete&name=%value stsName%">
                            <img src="/WmRoot/icons/delete.gif" alt="delete" style="border:none;"/>
                        </a>
                    </td>
                </tr>
                %endloop%
            %else%
                 <tr><td class="info" colspan="4" align="left">No STS configured</td></tr> 
            %endif%
            %endinvoke%
            </tbody>
        </table>
    </div>

</div>

</body>
</html>