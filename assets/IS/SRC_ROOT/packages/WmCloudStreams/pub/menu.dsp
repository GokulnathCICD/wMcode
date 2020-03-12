<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <link rel="stylesheet" href="css/menu.css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <!-- script src="js/menu.js" type="text/javascript"></script -->

	<style>
	  body { border: none; border-collapse: collapse; }
	</style>
	<script type="text/javascript">
		var selected = null;

		function toggle(parent, id, imgId) {
			var set = "none";
			var image = document.getElementById(imgId);
			if (parent.getAttribute("manualhide") == "true") {
				set = "table-row";
				parent.setAttribute("manualhide", "false");
				image.src = "/WmRoot/images/expanded.gif";
				var item = document.getElementById("elmt_" + id);
				item.style.backgroundColor = "#14629F";
				item.style.color = "#FFFFFF";
			}
			else {
				parent.setAttribute("manualhide", "true");
				image.src = "/WmRoot/images/collapsed_blue.png";
				var item = document.getElementById("elmt_" + id);
				item.style.backgroundColor = "#FFFFFF";
				item.style.color = "#333333";
			}
			var elements = getElements("tr", id);

			for (var i = 0; i < elements.length; i++) {
				var element = elements[i];
				element.style.cssText = "display:" + set;
			}
		}

		function getElements(tag, name) {
			var elem = document.getElementsByTagName(tag);
			var arr = new Array();
			for (i = 0, idx = 0; i < elem.length; i++) {
				att = elem[i].getAttribute("name");
				if (att == name) {
					arr[idx++] = elem[i];
				}
			}
			return arr;
		}

		var previousMenuImage;
		var menuInit = false;

		function tdClick(thisTD, id) {
			alert(thisTD.all);
			thisTD.all[id].click();
		}

		function menuClick(url, target) {
			switch (target) {
			case "body":
				parent[target].window.location.href = url;
				break;
			default:   
				window.open(url, target, "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes");
				break;
			}
			return false;
		}

		function menuSelect(object, url, target) {
			var anchorTag = null;
			if (selected != null) {
				selected.style.background = '#FFFFFF';
				selected.style.fontWeight = "normal";
				anchorTag = selected.getElementsByTagName('a')[0];
				if (anchorTag != null) { anchorTag.style.color = '#1776BF'; }
			}
			object.style.backgroundColor = '#1776BF';
			anchorTag = object.getElementsByTagName('a')[0];
			if (anchorTag != null) { anchorTag.style.color = '#FFFFFF'; }
			selected = object;
		}
		
		function IE() {
			if (navigator.appName == "Microsoft Internet Explorer")
				return true;
			return false;
		}

		function menuMouseOver(object, id) {
			if (object != selected) {
				object.style.background = "#CDE6F9";
				object.style.color = "#333333";
			}
			window.status = id;
		}

		function menuMouseOut(object) {
			if (object != selected) {
				object.style.background = "#FFFFFF";
				object.style.color = "#333333";
			}
			window.status = '';
		}


		function moveArrow(item) {
		}

		function initMenu(firstImage) {
			previousMenuImage = document.images[firstImage];
			// previousMenuImage.src="images/selectedarrow.gif";
			menuInit = true;
			return true;
		}
		
		function setDocPage(pageName) {
			$("#helpURL").val("doc/index.html#context/cloudstreams-is-onlinehelp/" + pageName);
		}
	</script>
</HEAD>

<BODY class="menu">

<div class="breadcrumb" id="heading">
   CloudStreams
</div>

<div id="container">
    
	<table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
        
		<tr manualhide="false" onClick="toggle(this, 'Administration_subMenu', 'Administration_twistie');" OnMouseOver="this.className='cursor';">
            <td class="menusection-Administration menusection menusection-expanded" id="elmt_Administration_subMenu">
                <img id='Administration_twistie' src="/WmRoot/images/expanded.gif">&nbsp;Administration
            </td>
		</tr>
		<tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'general-config.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['general-config.dsp'].click(); setDocPage('CloudStreams_GeneralScrn')">
		   <nobr>
                <a id="general-config.dsp" href="general-config.dsp" class="menuitem-x" target="body">
					<span>General</span>
				</a>
			</nobr>
            </td>
        </tr>	
		<tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'email-config.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['email-config.dsp'].click(); setDocPage('CloudStreams_EmailScrn')">
				<nobr>
                <a id="email-config.dsp" href="email-config.dsp" class="menuitem-x" target="body">
					<span>Email</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'db-config.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['db-config.dsp'].click(); setDocPage('CloudStreams_DatabaseScrn')">
			<nobr>
				<a href="db-config.dsp" id="db-config.dsp" class="menuitem-x" target="body">
					<span>Database</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'cloudstreams-services.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['cloudstreams-services.dsp'].click(); setDocPage('CloudStreams_VSScrn')">
		   <nobr>
				<a href="cloudstreams-services.dsp" id="cloudstreams-services.dsp" class="menuitem-x" target="body">
					<span>Virtual Services</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'sts-config.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['sts-config.dsp'].click(); setDocPage('CloudStreams_STSScrn')">
				<nobr>
				<a href="sts-config.dsp" id="sts-config.dsp" class="menuitem-x" target="body">
					<span>STS</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'service-fault-config.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['service-fault-config.dsp'].click(); setDocPage('CloudStreams_FaultScrn')">
				<nobr>
				<a href="service-fault-config.dsp" id="service-fault-config.dsp" class="menuitem-x" target="body">
					<span>Service Fault Configuration</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'consumers.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['consumers.dsp'].click(); setDocPage('CloudStreams_ConsumersScrn')">
		   <nobr>
				<a href="consumers.dsp" id="consumers.dsp" class="menuitem-x" target="body">
					<span>Consumers</span>
				</a>
				</nobr>
            </td>
        </tr>
        <tr name="Administration_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'oauthTokens.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['oauthTokens.dsp'].click(); setDocPage('CloudStreams_OAuthScrn')">
				<nobr>
				<a href="oauthTokens.dsp" id="oauthTokens.dsp" class="menuitem-x" target="body">
					<span>OAuth Tokens</span>
				</a>
				</nobr>
            </td>
        </tr>
		
		<!--  Providers  -->
        <tr manualhide="false" onClick="toggle(this, 'Providers_subMenu', 'Providers_twistie');" OnMouseOver="this.className='cursor';">
            <td class="menusection-Providers menusection menusection-expanded" id="elmt_Providers_subMenu">
                <img id='Providers_twistie' src="/WmRoot/images/expanded.gif">&nbsp;Providers
			</td>
		</tr>
		
		%invoke wm.cloudstreams.provider.lifecycle.ui:listGroups%
            %ifvar groups -notempty%
                %loop groups%
				<tr name="Providers_subMenu" style="display: table-row">
						<td class="menuitem" onmouseover="menuMouseOver(this, 'connector-list.dsp?groupName=%value groupName%');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['connector-list.dsp?groupName=%value groupName%'].click(); setDocPage('CloudStreams_ProvidersScrn')">
							<nobr>
								<a href="connector-list.dsp?groupName=%value groupName%" id="connector-list.dsp?groupName=%value groupName%" target="body">
									<span>%value groupName%</span>
								</a>
							</nobr>
						</td>
					</tr>	
                    %endloop%
                %else%
				<tr name="Providers_subMenu" style="display: table-row">
					<td class="menuitem-unclickable" style="color: rgb(51, 51, 51); background: rgb(255, 255, 255);">
						<nobr>
							<span>None</span>
						</nobr>
					</td>
				</tr>
                %endif%
            %endinvoke%
            
        <tr manualhide="false" onClick="toggle(this, 'Streaming_subMenu', 'Streaming_twistie');" OnMouseOver="this.className='cursor';">
            <td class="menusection-Streaming menusection menusection-expanded" id="elmt_Streaming_subMenu">
                <img id='Streaming_twistie' src="/WmRoot/images/expanded.gif">&nbsp;Streaming
			</td>
		</tr>
        <tr name="Streaming_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'streaming-providers.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['streaming-providers.dsp'].click(); setDocPage('CloudStreams_StreamingProvidersScrn')">
			<nobr>
				<a href="streaming-providers.dsp" id="streaming-providers.dsp" class="menuitem-x" target="body"><span>Providers</span></a>
				</nobr>
            </td>
        </tr>
		<tr name="Streaming_subMenu" style="display: table-row">
		   <td class="menuitem" onmouseover="menuMouseOver(this, 'streaming-subscribers.dsp');" onmouseout="menuMouseOut(this);" onclick="menuSelect(this); document.all['streaming-subscribers.dsp'].click(); setDocPage('CloudStreams_StreamingSubscribersScrn')">
			<nobr>
                <a href="streaming-subscribers.dsp" id="streaming-subscribers.dsp" class="menuitem-x" target="body"><span>Subscribers</span></a>
				</nobr>
            </td>
        </tr>
        <!--<li><a href="#">Log</a></li>-->

    </table>
</div>

<div style="height:0; width:0">
    <form name="urlsaver">
        <input type="hidden" id="helpURL" name="helpURL" value="doc/index.html#context/cloudstreams-is-onlinehelp/CloudStreams_ScreensIntro">
    </form>
</div>
</BODY>
</HTML>
