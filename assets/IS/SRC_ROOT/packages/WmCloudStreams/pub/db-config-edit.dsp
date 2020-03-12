<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Database Configuration</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/db-config.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Edit Database Configuration
</div>

<div id="container">

    <ul class="listitems">
        <li><a href="db-config.dsp">Return</a></li>
    </ul>

    %ifvar action equals('save')%
      %invoke cloudstreams.db:updateSettings%
        %ifvar messages -notempty%
           <div class="error">
              <span>Following errors were reported during save:</span>
              <ul class="listitems">
              %loop messages%
                    <li>%value message%</li>
              %endloop%
              </ul>
           </div>
        %else%
           <div class="success">
               <span>Successfully saved CloudStreams database configuration!</span>
           </div>
        %endif%
      %endinvoke%
    %endif%

    <div id="dbConfig" class="config">

        <form name="saveDbConfig" method="POST" action="db-config-edit.dsp">
		<input type="hidden" id="form-tag" name="form-tag" value="db-config-edit"/>

        %invoke cloudstreams.db:getSettings%
        <table class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Database Configuration</th>
            </tr>
            </thead>
            <tbody>
			<tr>
                <td nowrap>Connection Pool Alias</td>
                <td nowrap>
                    %ifvar cloudstreams.jdbc.functional.pool.alias -notempty%
                        <span>%value cloudstreams.jdbc.functional.pool.alias%</span>
                    %else%
                        <span class="nopool">Not configured</span>
                    %endif%
                </td>
            </tr>
            <tr>
                <td>
                    <label for="dbEnable">Database Publishing</label>
                </td>
                <td>
                    <input type="checkbox" id="dbEnable" name="pg.jdbc.active"
                    %ifvar pg.jdbc.active equals('true')% checked='checked' value='true'%else% value='false' %endif% />
                </td>
            </tr>
            <tr>
                <td>
                    <label for="perfEnabled">Publish performance metrics to database</label>
                </td>
                <td>
                    <input type="checkbox" id='perfEnabled' name="pg.PgMenConfiguration.perfDataEnabled"
                    %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true' %endif%
                    %ifvar pg.jdbc.active equals('false')% disabled='disabled' value='false' %endif% />
                </td>
            </tr>
            <tr>
                <td>Publish Interval</td>
                <td>
                    <div id="report-interval">
                        <input name="pg.PgMenConfiguration.reportInterval" type="text" id="reportInterval"
                               value="%value pg.PgMenConfiguration.reportInterval%"
                        %ifvar pg.jdbc.active equals('false')% disabled='disabled' value='false' %endif%/>
                        minutes
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="pubEvents">Publish events to database <div>(Error, Lifecycle, Policy Violation)</div></label>
                </td>
                <td>
                    <input type='checkbox' id='pubEvents' name='pg.publish.events'
                    %ifvar pg.publish.events equals('true')% checked='checked' value='true' %endif%
                    %ifvar pg.jdbc.active equals('false')% disabled='disabled' value='false' %endif%
                    />
                </td>
            </tr>
            </tbody>
        </table>
        %endinvoke%

            <div id="formButtons">
                <input type="submit" name="btnSubmit" id="btnSubmit" value="Save"/>
            </div>

            <input type="hidden" id="action" name="action" value="save"/>

        </form>
    </div>

</div>
</body>
</html>