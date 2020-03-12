<!-- this javascript chunk loads the cloudstreams.css file to override the webMethods.css style -->
<script type="text/javascript">

	$(document).ready ( function () {
		validateCallbackService();
	});
	
	function validateCallbackService() {
		
		var serviceNameInput  = $("input[name='CPROP$errorHandler$Basic$eh.callbackServiceName']")[0];
		var serviceName  = $(serviceNameInput).val();
		serviceNameInput.setCustomValidity('');
		var error = "";
		var isValidServiceName = false;
		var isEnabled = $("select[name='CPROP$errorHandler$Basic$eh.isEnabled']").val() == 'true';

		if(isEnabled && serviceName.trim() == '') {
			serviceNameInput.setCustomValidity(getmsg("missing.input.caption"));
		}
		else if(serviceName.trim() != '') {
			var jsonData = JSON.stringify({serviceName: serviceName, listenerConnectionType : '%value listenerConnectionType%'} );
			
			$.ajax({
				url: "/invoke/wm.cloudstreams.listener.errorhandler:validate",
				type: 'POST',
				dataType: 'json',
				contentType: 'application/json',
				data: jsonData,
				accepts: {
					text: "application/json"
				},
				async: false,
				success: function(data, status) {
					$.each(data, function(key, value) {

						if (key == 'valid') {
							isValidServiceName = value;
						}
						if (key == 'error') {
							error = value;
						}
					});
					if(!isValidServiceName ) {
						serviceNameInput.setCustomValidity(error);
					}
				},
				error: function(xhr) {
					console.log(xhr.responseText);
				}
			});
		
		} else {
			serviceNameInput.setCustomValidity('');
		}
		return isValidServiceName;
	}
	
	function callback(val) {
		var runAs = $("input[name='CPROP$errorHandler$Basic$eh.runAsUser']").val(val);
	}
	
    function loadCSS(filename) {

		var file = document.createElement("link")
		file.setAttribute("rel", "stylesheet")
		file.setAttribute("type", "text/css")
		file.setAttribute("href", filename)
		
		if (typeof file !== "undefined") {
			document.getElementsByTagName("head")[0].appendChild(file)
		}
    }
	
   loadCSS("css/cloudstreams.css")

</script>

%comment%----- Edit connection node -----%endcomment%

%ifvar connectionGroupProperties%
    <!-- <script>setNavigation('connection-list.dsp', '%value TemplateURL%', 'foo');</script> -->
    
    %ifvar readOnly equals('true')%
        %loop connectionGroupProperties%			
			%ifvar ../../basic equals('true')% %comment%----- new code: check if this is showing Basic page -----%endcomment%
				%ifvar hasBasicField equals('true')% %comment%----- new code: check if this group has any field of modelType as Basic -----%endcomment%
					<tr><td colspan=2 class="heading">Connection Groups: %value groupDisplayName%</td></tr>    
				%endif% %comment%----- new code : ending if check of group having any field with modelType as Basic -----%endcomment%
			%endif%
			%ifvar ../../basic equals('false')%
				<tr><td colspan=2 class="heading">Connection Groups: %value groupDisplayName%</td></tr>
			%endif%
				<tr>
				%loop fields%
					%ifvar isHidden equals('false')%
						%ifvar ../../basic equals('true')%
							%ifvar modelType equals('Basic')%
								<script>writeTDspan('row');</script>%value displayName%</td>              
								<script>writeTDspan('rowdata-l');swapRows();</script>
									%ifvar isEncrypted equals('true')%
										******
									%else%
										%ifvar propertyValue%
											%value propertyValue%
										%endif%
									%endif%	
							%endif%	
						%else%	
							<script>writeTDspan('row');</script>%value displayName%</td>              
							<script>writeTDspan('rowdata-l');swapRows();</script>
							%ifvar isEncrypted equals('true')%
									******
							%else%
								%value propertyValue%
							%endif%
						%endif%
					%endif%
				</td>
			</tr>
			%endloop%				
       %endloop%
		
    %else% %comment%----  case where readOnly is false %endcomment%
        %loop connectionGroupProperties%
		
		%ifvar ../../basic equals('true')% %comment%----- new code: check if this is showing Basic page -----%endcomment%
			%ifvar hasBasicField equals('true')% %comment%----- new code: check if this group has any field of modelType as Basic -----%endcomment%
				<tr><td colspan=2 class="heading" >Connection Groups: %value groupDisplayName%</td></tr>			
			%endif%
			%ifvar hasBasicField equals('false')% 
			    <tr class="HIDDENGROUP" style="display:none">
					<td class="heading" colspan=2>Connection Groups: %value groupDisplayName%</td>
				</tr>					
			%endif%
		%endif%
		%ifvar ../../basic equals('false')%
			<tr><td colspan=2 class="heading" >Connection Groups: %value groupDisplayName%</td></tr>
		%endif%
			            
		%loop fields%
			
			%ifvar isHidden equals('false')%
					%ifvar schemaType equals('int')%
					  <script>populateValidationFields("CPROP$%value ../groupType%$%value modelType%$%value propertyKey%")</script>
					%endif%
					%ifvar isRequired equals('true')%
					  <script>populateRequiredFields("CPROP$%value ../groupType%$%value modelType%$%value propertyKey%")</script>
					%endif%
				%ifvar modelType equals('Basic')%
					%ifvar isRequired equals('true')%
						<script>writeTDspan('row');</script>%value displayName%*</td>
					%else%
						<script>writeTDspan('row');</script>%value displayName%</td>
					%endif%
					
					%ifvar isEncrypted equals('true')%
							<script>writeTDspan('rowdata-l'); swapRows();</script>
								<input id=input
									   size=60
									   type=password
									   name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%"
									   value="******" onchange="passwordChanged(this.form, '%value propertyKey%')"
									   >
								</input>
								</td></tr>
		
					%else%
							<script>writeTDspan('rowdata-l'); swapRows();</script>
							%ifvar allowedValues% 
								<select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
									%ifvar propertyValue -notempty%
										%loop allowedValues%
											<option %ifvar allowedValues vequals(propertyValue)% selected %endif%>%value allowedValues%</option>
										%endloop%
									%else%
										%loop allowedValues%
											<option %ifvar allowedValues vequals(defaultValue)% selected %endif%>%value allowedValues%</option>
										%endloop%
									%endif%
								</select>
							%else%
								%ifvar schemaType equals('boolean')%
							          <select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
							        	  <option value="true"  %ifvar propertyValue equals('true')% selected="true" %endif%>true</option>
								          <option value="false" %ifvar propertyValue equals('false')% selected="true" %endif%>false</option>
							          </select>
							        %else%
						        	<!--
                                       WST-2019: Once the username field edit is done invoke the passwordChanged method to handle
                                                 the case where username value is filled using browser autocomplete feature and the
                                                 password is autofilled
                                    -->
									%ifvar propertyKey equals('eh.runAsUser')%
										<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" value="%value propertyValue%" >
											<link rel="stylesheet" type="text/css" href="/WmRoot/subUserLookup.css" />
										<script type="text/javascript" src="/WmRoot/subUserLookup.js"></script>
											<a class="submodal" href="/WmRoot/subUserLookup.dsp"><img border=0 align="bottom" src="icons/magnifyglass.gif"/></a>
										</input>
									%else%
										<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" value="%value propertyValue%" %ifvar propertyKey equals('eh.callbackServiceName')% onBlur="validateCallbackService()" %endif% %ifvar schemaType equals('int')% pattern="[0-9.]+" %endif% />
									%endif%
								%endif%
							%endif%								
							</td>	</tr>
					%endif%
				%endif%
			%endif%
			
			%ifvar isHidden equals('false')%
				%ifvar modelType equals('Advanced')%
					<tr style="display:none">
					<td>%value displayName%</td>
					<td>
					%ifvar isEncrypted equals('true')%
								<input id=input
									   size=60
									   type=password
									   name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%"
									   value="******" onchange="passwordChanged(this.form, '%value propertyKey%')"
									   >
								</input>
								
		
					%else%
					%ifvar allowedValues% 
						<select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
							%ifvar propertyValue -notempty%
								%loop allowedValues%
									<option %ifvar allowedValues vequals(propertyValue)% selected %endif%>%value allowedValues%</option>
								%endloop%
							%else%
								%loop allowedValues%
									<option %ifvar allowedValues vequals(defaultValue)% selected %endif%>%value allowedValues%</option>
								%endloop%
							%endif%
						</select>
					%else%
						%ifvar schemaType equals('boolean')%
							  <select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
								  <option value="true"  %ifvar propertyValue equals('true')% selected="true" %endif%>true</option>
								  <option value="false" %ifvar propertyValue equals('false')% selected="true" %endif%>false</option>
							  </select>
							%else%						       	
							<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
								value="%value propertyValue%" %ifvar schemaType equals('int')% pattern="[0-9.]+" %endif% %ifvar propertyKey equals('eh.errorHandlerServiceName')% readonly title="This field is read only." %endif% >
							</input>
						%endif%
					%endif%	
                 %endif%						
					</td>
					</tr>
				%endif%	
			%endif%
		%endloop%
	        
        %endloop%
    %endif%
%else%
    <tr><td class="error" colspan=4>Connection properties not found</td></tr>
%endif%