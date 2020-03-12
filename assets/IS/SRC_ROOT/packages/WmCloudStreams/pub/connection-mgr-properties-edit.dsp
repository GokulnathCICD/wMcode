%comment%------ Edit connection node ------%endcomment%
%ifvar connectionManagerProperties%
<script>resetRows();</script>

<TR>
   <TD colspan="2" class="heading">Connection Management Properties</TD>
</TR>   
    %ifvar readOnly equals('true')%
        %loop connectionManagerProperties/fields%        
        <tr>
        <script>writeTDspan('row');</script>
        %value displayName%</td>
        <script>writeTDspan('rowdata-l');swapRows();</script>      
        %value propertyValue%</td></tr>        
        %endloop%  
    %else%
    %comment%-- edit mode --%endcomment%
      %loop connectionManagerProperties/fields%   
        <tr>
        <script>writeTDspan('row');</script>%value displayName%</td>
		%ifvar schemaType equals('int')%
			<script>populateValidationFields("CMGRPROP$%value propertyKey%")</script>
		%endif%
        %ifvar schemaType equals('boolean')%
          <script>writeTDspan('rowdata-l');swapRows();</script>      
          <select name="CMGRPROP$%value propertyKey%" %ifvar propertyKey equals('poolable')%onChange="handlePoolableChange(this.form);"%endif%>
          	<option value="true"  %ifvar propertyValue equals('true')%selected="true"%endif%>true</option>
          	<option value="false" %ifvar propertyValue equals('false')%selected="true"%endif%>false</option>
          </select></td></tr>
        %else%
            <script>writeTDspan('rowdata-l');swapRows();</script>
			%ifvar allowedValues%
			<select id=input name="CMGRPROP$%value propertyKey%"
				%ifvar propertyKey equals('timeoutType')%onChange="handleSessionManagementChange(this.form);"%endif%>
				%loop allowedValues%
					<option value="%value allowedValues%" %ifvar allowedValues vequals(propertyValue)% selected %endif%>%value allowedValues%</option>
				%endloop%
			</select>
			%else%
				<input id=input size=60 name="CMGRPROP$%value propertyKey%" value="%value propertyValue%">
				</input>
			%endif%
			</td></tr>
        %endif%      
      %endloop%
    %endif%  

%else%
  <TR><TD class="error">Connection Management properties not found</TD></TR>
%endif%

