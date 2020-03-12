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

	<script LANGUAGE="JavaScript" >
		function changeTab(str)
		{
			document.getElementById(str).click();
		}
	</script>
	<style>
		.ui-tabs .ui-tabs-nav li{
			height: 2em;
		}
	</style>
</head>

<body>
	<div id="heading" class="breadcrumb">
		CloudStreams &gt; Providers &gt; %value groupName% &gt; %value connectorName%
	
	</div>

	

<div id="container">
    <div id="tabs">
        <ul class="listitems">
            <li onclick="changeTab('tab1')" ><a id="tab1" href="#tabs-1">Connections</a></li>
            <li onclick="changeTab('tab2')" ><a id="tab2" href="#tabs-2">Listeners</a></li>
        </ul>
        <div id="tabs-1">
			<tr>
				%include connection-list.dsp%
			<tr>
        </div>
        <div id="tabs-2">
			<tr>
				%include listener-list.dsp%
			</tr>
        </div>
    </div>
</div>


</body>
</html>