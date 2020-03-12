%invoke cloudstreams.streaming:isProviderInUse%
<result>
%loop subscribers.using.provider%
%value%
%endloop%
</result>
%endinvoke%