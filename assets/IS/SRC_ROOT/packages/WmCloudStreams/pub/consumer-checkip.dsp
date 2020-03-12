%invoke cloudstreams.consumers:checkIPRange%
    %ifvar isValidRange%
       <result>%value isValidRange%</result>
    %endif%
%endinvoke%