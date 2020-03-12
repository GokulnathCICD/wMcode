%ifvar action equals('getAliases')%
    %invoke cloudstreams.UIConfig:getAliases%
       %loop aliasNames%
            <option>%value name%</option>
       %endloop%
    %endinvoke%
%endif%