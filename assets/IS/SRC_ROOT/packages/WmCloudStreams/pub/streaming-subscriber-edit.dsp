<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>CloudStreams Streaming Subscriber</title>
		<link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
		<link rel="stylesheet" href="css/streaming.css" type="text/css"/>
		<link rel="stylesheet" href="css/messages.css" type="text/css"/>
		<link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
		<script src="/WmRoot/webMethods.js.txt" type="text/javascript"></script>
		<script src="js/jquery-min.js" type="text/javascript"></script>
		<script src="js/cloudstreams.js" type="text/javascript"></script>
		<script src="js/validate.js" type="text/javascript"></script>
		<script src="js/messages.js" type="text/javascript"></script>
		<script src="js/streaming-subscribers.js" type="text/javascript"></script>
		
	</head>
	<body>
		<div id="heading" class="breadcrumb">
			CloudStreams &gt; Administration &gt; %ifvar name%Edit%else%Add New%endif% Streaming Subscriber Configuration
		</div>

		%ifvar action equals('save')%
			%invoke cloudstreams.streaming:saveSubscriber%
				%ifvar status equals('saved')%
					<div class="success">Successfully saved streaming subscriber configuration [%value name%]</div>
				%else%
					<div class="error">Error saving Streaming Subscriber configuration [%value name%].%value err%</div>
				%endif%
			%onerror%
				<div class="error">Unexpected error saving streaming subscriber configuration! %value errorMessage%</div>
			%endinvoke%
		%endif%


	<div id="container">
		<ul class="listitems">
			<li>
				<a href="streaming-subscribers.dsp">Return</a>
			</li>
		</ul>
		
		
		%invoke cloudstreams.streaming:getSubscriber%

		<form action="streaming-subscriber-edit.dsp" method="POST">
			<div id="mainCfg" class="config">
			<div class="required-msg" style="float: right; margin: -15px 0 0; padding-bottom: 10px;">Fields marked with <span class="required">*</span> are required</div>
				<table class="tableView" style="margin: 32px 0 0;">
					<thead>
						<tr>
							<th colspan="2" class="heading">
								<span>Subscriber Configuration</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td nowrap>
								<label for="streaming.sub.isenabled">Enable Subscriber</label>
							</td>
							<td>
								<input type="checkbox" name="streaming.sub.isenabled" id="streaming.sub.isenabled"
								%ifvar streaming.sub.isenabled equals('true')%checked='checked' value='true' %else%
								%ifvar ../action equals('add')%checked='checked' value='true' %endif%
								%endif%/>
							</td>
						</tr>
						<tr>
							<td nowrap>Subscriber Name<span class="required">*</span></td>
							<td><input type="text" name="streaming.sub.name" value="%value streaming.sub.name%"/></td>
						</tr>
						<tr>
							<td nowrap>Provider<span class="required">*</span></td>
							<td><select name="streaming.sub.prov.name">
								%invoke cloudstreams.streaming:getAllProviders%
								%loop providers%
									<option value="%value streaming.prov.name%"
											%ifvar ../streaming.sub.prov.name vequals(streaming.prov.name)%selected%endif%>
												%value streaming.prov.name%
									</option>
								%endloop%
								%endinvoke%
							</select>
							</td>
						</tr>
						<tr>
							<td nowrap>Channel Endpoint</td>
							<td><input class='url' type="text" name="streaming.sub.channel.endpoint" value="%value streaming.sub.channel.endpoint%"/></td>
						</tr>
						<tr>
							<td nowrap>Content Type</td>
							<td>
								<input type="text" id="httpContentType" name="streaming.sub.channel.content.type" value="%value streaming.sub.channel.content.type%"/>
							</td>
						</tr>
						<tr>
							<td nowrap>HTTP Method</td>
							<td>
								%invoke cloudstreams.streaming:getHttpMethods%
								<select name="streaming.sub.channel.method">
								%loop methods%
								<option value="%value val%" %ifvar ../streaming.sub.channel.method vequals(val)%selected="selected"%endif%>%value name%</option>
								%endloop%
								%endinvoke%
								</select>
							</td>
						</tr>
						<tr>
							<td nowrap>Request Body</td>
							<td>
								<textarea rows="10" cols="80" name="streaming.sub.channel.entity"
								%switch streaming.sub.channel.method% %case GET%disabled%case DELETE%disabled%case HEAD%disabled%case TRACE%disabled%endswitch%
								>%value streaming.sub.channel.entity%</textarea>
							</td>
						</tr>
						<tr>
							<td nowrap>HTTP Headers</td>
							<td>
								<div id="headersContainer">
									<div>
										<span>Name</span>
										<input type="text" name="headerName" value="" />
										<span>Value</span>
										<input type="text" name="headerVal" value="" />
										<img src="images/add.png" class="addHeaderImg" alt="Add HTTP header"/>
									</div>
									%ifvar headers -notempty%
									%loop headers%
									<div>
										<span>Name</span>
										<input type="text" name="headerName" value="%value headerName%"/>
										<span>Value</span>
										<input type="text" name="headerVal" value="%value headerVal%"/>
										<img src="images/add.png" class="addHeaderImg" alt="Add HTTP header"/>
										<img src="images/remove.png" class="removeHeaderImg" alt="Remove HTTP header"/>
									</div>
									%endloop%
									%endif%
								</div>
							</td>
						</tr>
						<tr>
							<td nowrap>Destination Type</td>
							<td><select name="streaming.sub.dest.type">
								%invoke cloudstreams.streaming:getDestinationTypes%
								<option value=""></option>
								%loop destinationTypes%
								<option value="%value val%" %ifvar ../streaming.sub.dest.type vequals(val)%selected='selected'%endif% >%value name%</option>
								%endloop%
								%endinvoke%
							</select></td>
						</tr>
					</tbody>
				</table>
				<div id="destinationConfig">
					<table id="esbConfig" %ifvar streaming.sub.dest.type equals('ESB')%class='tableView'%else%class='hiddenConfig'%endif%>
					<thead>
						<tr><th colspan="2" class="heading">ESB Service Destination Configuration</th></tr>
					</thead>
					<tbody>
						<tr>
							<td style="text-align: right;" >Service Name<span class="required">*</span></td>
							<td>
								<input class="url right" type="text" id="streaming.sub.dest.esb.service" name="streaming.sub.dest.esb.service" value="%value streaming.sub.dest.esb.service%"/>
							  </td>
						</tr>
							<!--  RUN AS USER SUB CHANGES-->
						<SCRIPT>
								  function callback(val){
										var runAs = document.getElementById("streaming.sub.dest.esb.runas");
										runAs.value = val;
								  }
						</SCRIPT>
						<tr>
							<td style="text-align: right;" class="evenrow-l">Run As User</td>
							<td class="evenrowdata-l" style="text-align: left;">
								<input id="streaming.sub.dest.esb.runas" name="streaming.sub.dest.esb.runas" size="12" value="%value streaming.sub.dest.esb.runas%"></input>
								<link rel="stylesheet" type="text/css" href="/WmRoot/subUserLookup.css" />
								<script type="text/javascript" src="/WmRoot/subUserLookup.js"></script>
								<a class="submodal" href="/WmRoot/subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>
							</td>
						</tr>
							<!--  RUN AS USER SUB END-->
					</tbody>
				</table>
					<table id="logConfig" %ifvar streaming.sub.dest.type equals('JOURNAL_LOG')%class='tableView'%else%class='hiddenConfig'%endif%>
					<thead>
							<tr><th colspan="2" class="heading">Journal Log Destination Configuration</th></tr>
					</thead>
					<tbody>
						<tr>
						  <td nowrap  style="text-align: right;">Log Level</td>
						  <td><select id="streaming.sub.dest.log.level" name="streaming.sub.dest.log.level">
								%invoke cloudstreams.streaming:getLogLevels%
									%loop logLevels%
										 <option value="%value val%" %ifvar val vequals(../streaming.sub.dest.log.level)%selected='selected'%endif%>%value name%</option>
									%endloop%
								%endinvoke%

							  </select>
						  </td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>

			<div id="formButtons">
				<input type="submit" name="btnSubmit" id="btnSubmit" value="Save" accesskey="s"/>
			</div>

			<input type="hidden" name="name" value="%value name%"/>
			<input type="hidden" id="action" name="action" value="save"/>

		</form>
		%endinvoke%

		<div id="headerTemplate">
			<span>Name</span>
			<input type="text" name="headerName" value=""/>
			<span>Value</span>
			<input type="text" name="headerVal" value=""/>
			<img src="images/add.png" class="addHeaderImg" alt="Add HTTP header"/>
			<img src="images/remove.png" class="removeHeaderImg" alt="Remove HTTP header"/>
		</div>

	</div>
</body>
</html>