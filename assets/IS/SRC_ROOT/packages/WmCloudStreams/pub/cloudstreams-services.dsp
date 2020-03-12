<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Integration Server - CloudStreams Settings</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/custom-theme/jquery-ui-custom.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/services.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>

    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/jquery-ui-custom.min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/services.js" type="text/javascript"></script>
	<style>
		.ui-tabs .ui-tabs-nav li{
			height: 2em;
		}
	</style>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Virtual Services
</div>


<div id="container">
    <div id="tabs">
        <ul class="listitems">
            <li><a href="#tabs-1">Connector Virtual Services</a></li>
            <li><a href="#tabs-2">Virtual Services</a></li>
        </ul>
        <div id="tabs-1">
            %invoke cloudstreams.services:getConnectorServices%
            %ifvar packagesWithConnectorServices%
                %loop packagesWithConnectorServices%
                <div class="packageDetails">
                    <div class="pkgHeader">
                        <img src="images/ns_package.gif" alt="IS package"/>
                        <span class="pkgName">%value packageName%</span>
                    </div>
                    %ifvar connectorServices -notempty%
                        %loop connectorServices%
                        <div class="virtualServices">
                            <div class="vsHeader" margin-bottom=5px>
                                <img src="images/Service16.gif" alt="Virtual Service">
                                <span class="vsName">%value virtualServiceName%</span>
                            </div>
                            %ifvar keys -notempty%
                            <table class="connectorServicesAndKeys tableView">
                                <thead>
                                <tr>
                                    <td>Connector Service</td>
                                    <td>Collection Key</td>
                                </tr>
                                </thead>
                                <tbody>
                                %loop keys%
                                    <tr>
                                        <td>%value connectorServiceName%</td>
                                        <td>%value key%</td>
                                    </tr>
                                %endloop%
                                </tbody>
                            </table>
                            %else%
                            <div class="noKeys">No Connector Services using this Virtual Service</div>
                            %endif%
                        </div>
                        %endloop%
                    %else%
                    <div class="noVS">No Virtual Services in this package</div>
                    %endif%
                </div>

                %endloop%
            %else%
                <div class="info">No Connector Virtual Services found!</div>
            %endif%
            %onerror%
                <div class="error">
                    <div>Error retrieving Connector Virtual Services! Please check the server log!</div>
                    <div>%value errorMessage%</div>
                </div>
            %endinvoke%
        </div>
        <div id="tabs-2">
            %include virtual-services.dsp%
        </div>
    </div>
</div>


</body>
</html>