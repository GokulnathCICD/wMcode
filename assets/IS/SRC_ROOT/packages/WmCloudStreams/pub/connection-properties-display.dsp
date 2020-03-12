%comment%----- Displays connection type parameters -----%endcomment%
%ifvar connectionGroupProperties%
    <script>resetRows();</script>

    %loop connectionGroupProperties%
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
		%else%
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
					<script>if("%value modelType%" != "Meta") populateRequiredFields("CPROP$%value ../groupType%$%value modelType%$%value propertyKey%")</script>
				%endif%
			%ifvar modelType equals('Basic')%
				<tr>
					%ifvar isRequired equals('true')%
						<script>writeTD('row');</script>%value displayName%*</td>
					%else%
						<script>writeTD('row');</script>%value displayName%</td>
					%endif%
					
					%ifvar isEncrypted equals('true')%
						<script>writeTD('rowdata-l');swapRows();</script>
						<input id=input size=60 
							   type=password
							   name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%"
							   value="%value defaultValue%" onchange="passwordChanged(this.form, '%value propertyKey%')"></input></td></tr>
		
					%else%
						<script>writeTD('rowdata-l'); swapRows();</script>
						%ifvar allowedValues% 
		                        <select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
                                %loop allowedValues%
									%ifvar propertyValue -notempty%
										<option %ifvar allowedValues vequals(propertyValue)% selected %endif%>%value allowedValues%</option>
									%else%
										<option %ifvar allowedValues vequals(defaultValue)% selected %endif%>%value allowedValues%</option>
									%endif%
	                            %endloop%
		                        </select>
							%else%

								%ifvar schemaType equals('boolean')%
								  <select id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%">
									  <option value="true"  %ifvar propertyValue equals('true')% selected="true" %endif%>true</option>
									  <option value="false" %ifvar propertyValue equals('false')% selected="true" %endif%>false</option>
								  </select>
								%else%						       	
									%ifvar propertyValue -notempty%
										<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
												value="%value propertyValue%" %ifvar schemaType equals('int')% pattern="^[-+]?[0-9]*[.,]?[0-9]+$" %endif%>
										</input>
									%else%
										<input id=input size=60 name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
											value="%value defaultValue%" %ifvar schemaType equals('int')% pattern="^[-+]?[0-9]*[.,]?[0-9]+$" %endif%>
										</input>
									%endif%
								%endif%
								
							%endif%
						</td>
					%endif%
				</tr>
			%else%
				%ifvar modelType equals('Advanced')% <!-- if modelType is not Basic -->
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
                                       value="%value defaultValue%" onchange="passwordChanged(this.form, '%value propertyKey%')">
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
								%ifvar propertyValue -notempty%
									<input id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
										value="%value propertyValue%" size=60 %ifvar schemaType equals('int')% pattern="^[-+]?[0-9]*[.,]?[0-9]+$" %endif%> 
									</input>
								%else%
									<input id=input name="CPROP$%value ../groupType%$%value modelType%$%value propertyKey%" 
										value="%value defaultValue%" size=60 %ifvar schemaType equals('int')% pattern="^[-+]?[0-9]*[.,]?[0-9]+$" %endif%> 
									</input>
								%endif%
							%endif%
						%endif%
					%endif%
								
					</td>
				</tr>	
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
		
		%else%
			<!-- inside hidden meta fields -->
			%ifvar isHidden equals('true')%
				%ifvar modelType equals('Meta')%
					<tr style="display:none" class="meta" >	
						<td>%value displayName%</td>
						<td>
							<input id=input class="meta-field" name="%value propertyKey%" value="%value defaultValue%" 
										size=60 %ifvar isHidden equals('true')% type="hidden" %endif% /> 
						</td>
					</tr>
				%endif%	
			%endif%	
		%endif%
    %endloop%
	%endloop%
%endif%
