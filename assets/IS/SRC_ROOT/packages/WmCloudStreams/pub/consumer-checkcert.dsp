%invoke cloudstreams.consumers:checkCertFile%
%ifvar isValidCert%
<result>
    <certValid>%value isValidCert%</certValid>
    <errMsg>%value certErrMessage%</errMsg>
</result>
%endif%
%endinvoke%