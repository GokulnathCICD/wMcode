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
				<tr>
					%ifvar groupType equals('oauth_v20_authorization_code')%
						<td class="heading" colspan=2>Connection Groups: %value groupDisplayName%
							<span style="float: right; margin-right: 10px;">
								<input id="groupType" name="groupType" type="hidden" value="%value groupType%" />
								<script type="text/javascript" src="../WmRoot/webMethods.js.txt"></script>
								<link rel="stylesheet" type="text/css" href="../WmRoot/subUserLookup.css" />
								<script type="text/javascript" src="js/modal.js"></script>
								<script type="text/javascript" src="js/jquery-min.js"></script>
								<a class="submodal" style="color: #fff;" href="/WmCloudStreams/oauth-authorization-code-flow">Generate Access Token</a>
							</span>
						</td>
					%else% 
						%ifvar groupType equals('oauth_v20_jwt')%
							<td class="heading" colspan=2>Connection Groups: %value groupDisplayName%
								<span style="float: right; margin-right: 10px;">
									<input id="groupType" name="groupType" type="hidden" value="%value groupType%" />
									
									<script type="text/javascript" src="../WmRoot/webMethods.js.txt"></script>
									<link rel="stylesheet" type="text/css" href="../WmRoot/subUserLookup.css" />
									<script type="text/javascript" src="js/modal.js"></script>
									<script type="text/javascript" src="js/jquery-min.js"></script>
									<a class="submodal" style="color: #fff;" href="/WmCloudStreams/oauth-jwt-flow">Generate Access Token</a>
								</span>
							</td>
						%else% 
							<td class="heading" colspan=2>Connection Groups: %value groupDisplayName% </td>
						%endif%
					%endif%
				</tr>
		%ifvar hasBasicField equals('false')%
			<tr class="HIDDENGROUP" style="display:none">
				<td class="heading" colspan=2>Connection Groups: %value groupDisplayName%</td>
			</tr>					
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
				<tr>
					%ifvar isRequired equals('true')%
						<script>writeTDspan('row');</script>%value displayName%*</td>
					%else%
						<script>writeTDspan('row');</script>%value displayName%</td>
					%endif%
					
					%ifvar isEncrypted equals('true')%
						<script>writeTDspan('rowdata-l'); swapRows();</script>
							<input id=input size=60
									   type=password
									   name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%"
									   value="" onchange="passwordChanged(this.form, '%value propertyKey%')"></input></td></tr>
		
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
									<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
										value="%value propertyValue%"  %ifvar propertyKey equals('cr.username')% onBlur="passwordChanged(this.form, 'cr.password')" %endif%>
									</input>
							%endif%
						%endif%
					%endif%
					</td></tr>
				%else%
					%ifvar modelType equals('Advanced')%
					<tr style="display:none">
						%ifvar isRequired equals('true')%
							<script>writeTD('row');</script>%value displayName%*</td>
						%else%
							<script>writeTD('row');</script>%value displayName%</td>
						%endif%
					
						<td>
						%ifvar isEncrypted equals('true')%
								<input id=input
									   size=60
									   type=password
									   name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%"
									   value="" onchange="passwordChanged(this.form, '%value propertyKey%')"
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
								<select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" %ifvar propertyKey equals('oauth_v20.refreshAccessToken')%onChange="handleRefreshTokenChange(this.form);"%endif%>
									<option value="true"  %ifvar propertyValue equals('true')% selected="true" %endif%>true</option>
									<option value="false" %ifvar propertyValue equals('false')% selected="true" %endif%>false</option>
								</select>
							%else%						       	
								<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
									value="%value propertyValue%">
								</input>
							%endif%
						%endif%
						</td>
					</tr>
					%endif%
				%endif%
				%else% <!-- if modelType is meta -->
					%ifvar modelType equals('Meta')%
					<tr style="display:none" class="meta" >	
						%ifvar isRequired equals('true')%
							<td>%value displayName%*</td>
						%else%
							<td>%value displayName%</td>
						%endif%
						<td>
							%ifvar allowedValues% 
							<select id=input class="meta-field" name="%value propertyKey%">
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
									<select id=input class="meta-field" name="%value propertyKey%">
										<option value="true"  %ifvar propertyValue equals('true')% selected="true" %endif%>true</option>
										<option value="false" %ifvar propertyValue equals('false')% selected="true" %endif%>false</option>
									</select>
								%else%
									<input id=input class="meta-field" name="%value propertyKey%" 
												value="%value defaultValue%" size=60 %ifvar isHidden equals('true')% type="hidden" %endif% /> 
								%endif%
						%endif%
						</td>
					</tr>
					%endif%	
				%endif%	
			%endif%
			
	
			<!-- inside hidden meta fields -->
			%ifvar isHidden equals('true')%
				%ifvar modelType equals('Meta')%
					<tr style="display:none" class="meta" >	
						<td>%value displayName%</td>
						<td>
							<input id=input name="%value propertyKey%" value="%value defaultValue%" 
										size=60 %ifvar isHidden equals('true')% type="hidden" %endif% /> 
						</td>
					</tr>
				%endif%	
			%endif%	
		%endif%
		%endif%
    %endloop%
	%endloop%
%endif%
%else%
    <tr><td class="error" colspan=4>Connection properties not found</td></tr>
%endif%
