<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>CloudStreams Database Configuration</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; Database
</div>

<div id="container">

    <ul class="listitems">
        <li><a href="db-config-edit.dsp">Edit</a></li>
    </ul>

    <div id="dbConfig" class="config">
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
                <td nowrap>Database Publishing</td>
                <td>
                    %ifvar pg.jdbc.active equals('true')%Enabled%else%Disabled%endif%
                </td>
            </tr>
            <tr>
                <td>
                    <label for="perfEnabled">Publish performance metrics to database</label>
                </td>
                <td>
                    <input type="checkbox" id='perfEnabled' name="pg.PgMenConfiguration.perfDataEnabled" disabled readonly
                    %ifvar pg.PgMenConfiguration.perfDataEnabled equals('true')% checked='checked' value='true' %endif% />
                </td>
            </tr>
            <tr>
                <td nowrap>Publish Interval</td>
                <td>%value pg.PgMenConfiguration.reportInterval%
                    %ifvar pg.PgMenConfiguration.reportInterval equals(1)%minute%else%minutes%endif%</td>
            </tr>
            <tr>
                <td>
                    <label for="pubEvents">Publish events to database <div>(Error, Lifecycle, Policy Violation)</div></label>
                </td>
                <td>
                    <input type='checkbox' id='pubEvents' name='pg.publish.events' disabled readonly
                    %ifvar pg.publish.events equals('true')% checked='checked' value='true' %endif% />
                </td>
            </tr>
            </tbody>
        </table>
        %endinvoke%
    </div>

</div>
</body>
</html>