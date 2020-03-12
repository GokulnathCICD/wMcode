%invoke cloudstreams.services:getVirtualServices%

%ifvar packagesWithVirtualServices -notempty%
%loop packagesWithVirtualServices%
<div class="packageDetails">
    <div class="pkgHeader">
        <img src="images/ns_package.gif" alt="IS package"/>

        <span class="pkgName">%value packageName%</span>
    </div>

    %ifvar services -notempty %
    %loop services%
    <div class="service">
        <div class="vsHeader">
            <img src="images/Service16.gif" alt="Virtual Service">
            <span class="vsName">%value name%</span>
        </div>
        <form class="serviceDetails" action="service-details.dsp" method="post">
            <input type="hidden" name="serviceName" value="%value name%"/>
            <input type="hidden" name="type" value="vsd"/>
            [<a class="vsd" href="#">VSD</a>]
            %ifvar wsdlUrl -notempty% [<a href="%value wsdlUrl%?wsdl" target="_blank">WSDL</a>]%endif%
        </form>
        <table class="tableView">
           <tr>
               %ifvar wsdlUrl -notempty%<td class="endpoint" align="left">%value wsdlUrl%</td>%endif%
            </tr>
            <tr>
                <td align="left"><span class="details">Operations</span>
                    <ul class="listitems">
                        %loop operations%
                        <li>%value operations%</li>
                        %endloop%
                    </ul>
                </td>
            </tr>
        </table>
    </div>
    %endloop%
    %else%
    <div class="noVS">No Virtual Services in this package</div>
    %endif%
</div>
%endloop%
%else%
   <div class="info">No Virtual Services available</div>
%endif%
%endinvoke%