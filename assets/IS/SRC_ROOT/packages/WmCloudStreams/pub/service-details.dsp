<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title>%value serviceName% %ifvar type equals('vsd')% [VSD] %endif%</title>
    <link type="text/css" rel="stylesheet" href="css/shCore.css"/>
    <link type="text/css" rel="stylesheet" href="css/shThemeDefault.css"/>
    <script type="text/javascript" src="js/shCore.js"></script>
    <script type="text/javascript" src="js/shBrushXml.js"></script>
    <style type="text/css">
        * {
            font-family: "Roboto", "Arial", "sans-serif";
            padding: 0;
            margin: 0 2px;
            font-size: 12px;
        }
    </style>
</head>

<body>
<pre class="brush:xml;">
%ifvar type equals('vsd')%
%invoke cloudstreams.services:getVSD%
%value vsd%
%endinvoke%
%endif%
</pre>
</body>
<script type="text/javascript">
    SyntaxHighlighter.config.clipboardSwf = 'js/clipboard.swf';
    SyntaxHighlighter.all();
</script>
</html>

