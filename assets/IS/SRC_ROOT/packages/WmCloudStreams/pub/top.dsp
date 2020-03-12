<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='content-type' content='text/html; charset=utf-8'>
        <meta http-equiv="Expires" content="-1">
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        <link rel="stylesheet" type="text/css" href="/WmRoot/top.css">
		<script src="js/jquery-min.js" type="text/javascript"></script>
		<script src="js/cloudstreams.js" type="text/javascript"></script>
    </head>
    
    <script>
		$(function() {
			if (window.parent.opener==null) $('span#closeLink').detach();
		});

        function loadPage(url) {
            window.location.replace(url);
        }

		%ifvar message%
			%ifvar norefresh%
			%else%
				setTimeout("loadPage('top.dsp')", 30000);
			%endif%
		%endif%
    </script>
    
    <body  class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
        <table border=0 cellspacing=0 cellpadding=0 width=100%>
            <tr>
                <td>
                    <table height=14 width=100% cellspacing=0 border=0>
                        <tr>
							<td class="saglogo" bgcolor="FFFFFF">
                                <img src="/WmRoot/images/is_logo.png" border=0>
                            </td>
                            <td nowrap class="toptitle" width="100%">
                                 %invoke wm.server.query:getServerInstanceName%
								 %ifvar instancename%
								 %value instancename% ::
								 %endif%
								 %endinvoke%
								 %value $host%
								 :: CloudStreams
                            </td>
                            <td nowrap class="topmenu">
                               <span id='closeLink'><a href='javascript:window.parent.close();'>Close Window</a>
								|</span>
                                <a target='body' href='about.dsp'>About</a>&nbsp;|
                                <a target='_blank' id='helpUrl'
									href='#' onclick="launchHelp();return false;" >Help</a>&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr height=100%>
                <td>
                    <table width=100% height=54 cellspacing=0 border=0>
                        <tr>
                            <td nowrap width=100% class="topmenu">
                            </td>
                            
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
	</body>
</html>