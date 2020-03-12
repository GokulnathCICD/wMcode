<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--suppress ALL -->
<HTML style="height: calc(100% - 5px)">
   
	<HEAD>
		<TITLE>CloudStreams: %value $host% - webMethods Integration Server</TITLE>
		<link rel="stylesheet" type="text/css" href="/WmRoot/layout.css">
		<script>
			var doc = document.documentElement;
			var ua = navigator.userAgent;
			var currentUserName=null;
			var agent = ua.indexOf("Trident/7.0") >= 0 || ua.indexOf("MSIE") >= 0 ? "IE" : "NotIE";
			doc.setAttribute('data-useragent', agent);
			if (agent == "IE") {
				document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/WmRoot/layout-ie.css\")");
			}
			else {
				document.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"/WmRoot/layout-nonie.css\")");
			}
			
			function frameload()
			{
				var topIFrame = document.getElementById('top');
				topIFrame.contentWindow.location.reload(true);
			}
		</script>
	</HEAD>
	<BODY>
        <div>
			<iframe class="top" id="top" name="topmenu" src="top.dsp" ></iframe>
		</div>
        <div class="bottom">
			<iframe class="menuframe" name="menu" src="menu.dsp" scrolling="yes" seamless="seamless"></iframe>
			<iframe class="contentframe" name="body" id="body" src="general-config.dsp" onload="frameload()"></iframe>
		</div>

	   <NOFRAMES>
		<BLOCKQUOTE>
		  <H4>
		  Your browser does not support frames. Support for frames is required to use the webMethods Integration Server interface.
		  </H4>
		</BLOCKQUOTE>
	   </NOFRAMES>
	</BODY>
</HTML>