<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css"></link>    
	    <link rel="stylesheet" href="css/messages.css" type="text/css"/>

        <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<script src="js/jquery-min.js" type="text/javascript"></script>
		<script src="js/messages.js" type="text/javascript"></script>
        <script src="js/basicAdvanced.js"></script>
		<script src="js/csConnection.js"></script>
		<script type="text/javascript">
			function closeWindow() {
				setTimeout(function() {
					window.close();
				}, 500);
			}

			window.onload = closeWindow();
		</script>
    </head>
    <body>

		%invoke cloudstreams.oauth:cacheCode%
        
    </body>
</html>
