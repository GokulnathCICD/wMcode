<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Integration Server - CloudStreams Consumers</title>
    <link rel="stylesheet" href="/WmRoot/webMethods.css" type="text/css"/>
    <link rel="stylesheet" href="css/cloudstreams.css" type="text/css"/>
    <link rel="stylesheet" href="css/consumer-edit.css" type="text/css"/>
    <link rel="stylesheet" href="css/messages.css" type="text/css"/>
    <script src="js/jquery-min.js" type="text/javascript"></script>
    <script src="js/validate.js" type="text/javascript"></script>
    <script src="js/messages.js" type="text/javascript"></script>
    <script src="js/cloudstreams.js" type="text/javascript"></script>
    <script src="js/consumer-edit.js" type="text/javascript"></script>
</head>
<body>

<div id="heading" class="breadcrumb">
    CloudStreams &gt; Administration &gt; %ifvar name%Edit%else%Add New%endif% Consumer Configuration
</div>
<div id="container">
    %switch action%
    %case 'save'%
        %invoke cloudstreams.consumers:saveConsumer%
        %ifvar saved equals('true')%
            <div class="success">Successfully saved consumer %ifvar name -notempty%'%value name%'%endif% configuration!</div>
        %else%
            <div class="error">Error saving Consumer configuration [%value name%]. %value err%</div>
        %endif%
        %onerror%
            <div class="error">Unexpected error saving consumer %ifvar name -notempty%'%value name%'%endif% configuration! Error: %value errorMessage%</div>
        %endinvoke%
    %endswitch%
    <ul class="listitems">
        <li><a href="consumers.dsp">Return</a></li>
    </ul>
    <div class="required-msg">Fields marked with <span class="required">*</span> are required</div>

    %invoke cloudstreams.consumers:getConsumer%
    <form action="consumer-edit.dsp" method="post">
        <table class="tableView">
            <thead>
            <tr>
                <th colspan="2" class="heading">Consumer Configuration %ifvar name%[%value name%]%endif%</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td nowrap><label for="name">Name<span class="required">*</span></label></td>
                <td><input type="text"  name="consumer.name" id="name" value="%value consumer.name%" placeholder="Consumer name"/></td>
            </tr>
            <tr>
                <td nowrap><label for="consumerDesc">Description</label></td>
                <td><textarea name="description" id="consumerDesc" cols="80" rows="5" placeholder="Optional description">%value description%</textarea></td>
            </tr>
            <tr>
                <td nowrap>
                    <input type="checkbox" id="selectIPAddress" name="selectIPAddress" %ifvar ranges -notempty%checked='checked' value='true'%endif%/>
                    <label for="selectIPAddress">IP Addresses</label>
                </td>
                <td>
                    <div id="ipAddressContainer">
                        <div>
                            <span>From</span>
                            <input type="text" name="from" value="" />
                            <span>To</span>
                            <input type="text" name="to" value="" />
                            <img src="images/add.png" class="addRangeImg" alt="Add IP Address"/>
                        </div>
                        %ifvar ranges -notempty%
                        %loop ranges%
                        <div>
                            <span>From</span>
                            <input type="text" name="from" value="%value rangeFrom%"/>
                            <span>To</span>
                            <input type="text" name="to" value="%value rangeTo%"/>
                            <img src="images/add.png" class="addRangeImg" alt="Add IP Address"/>
                            <img src="images/remove.png" class="removeRangeImg" alt="Remove IP Address"/>
                        </div>
                        %endloop%
                        %endif%
                    </div>
                </td>
            </tr>
            <tr>
                <td nowrap>
                    <input type="checkbox" id="selectTokens" name="selectTokens" %ifvar tokens -notempty%checked='checked' value='true'%endif%/>
                    <label for="selectTokens">Identification Token</label>
                </td>
                <td>
                    <div id="tokensContainer">
                        <div>
                            <span>Name</span>
                            <input type="text" value="" name="tokens"/>
                            <img src="images/add.png" class="addTokenImg"/>
                        </div>
                        %ifvar tokens -notempty%
                        %loop tokens%
                        <div>
                            <span>Name</span>
                            <input type="text" value="%value token%" name="tokens"/>
                            <img src="images/add.png" class="addTokenImg"/>
                            <img src="images/remove.png" class="removeTokenImg"/>
                        </div>
                        %endloop%
                        %endif%

                    </div>
                </td>
            </tr>
            <tr>
                <td nowrap>
                    <input type="checkbox" id="selectCert" name="selectCert" %ifvar subjectDN%checked="checked" value="true"%endif%/>
                    <label for="selectCert">X.509 Certificate</label>
                </td>
                <td>
                    <div id="certFileContainer"><input type="text" class="url" name="certFile" id="certFile" placeholder="Path to certificate file on server"/>
                    %ifvar subjectDN%<div id="currentCert">(<span>Current Certificate:</span> DN: %value subjectDN%)</div>%endif%</div>
                </td>
            </tr>
            </tbody>
        </table>

        <div id="formButtons">
            <input type="submit" id="btnSubmit" value="Save"/>
        </div>
        <input type="hidden" id="action" name="action" value="save"/>
    	<input type="hidden" name="name" value="%value name%"/> <!-- the consumer name being edited -->
    </form>
    %onerror%
        <div class="error">Error loading consumer '%value name%' details! %value errorMessage%</div>
    %endinvoke%

    <div id="tokenDivTemplate">
        <span>Name</span>
        <input type="text" value="" name="tokens"/>
        <img src="images/add.png" class="addTokenImg" alt="Add Token"/>
        <img src="images/remove.png" class="removeTokenImg" alt="Remove Token"/>
    </div>

    <div id="ipRangeDivTemplate">
        <span>From</span>
        <input type="text" name="from" value=""/>
        <span>To</span>
        <input type="text" name="to" value=""/>
        <img src="images/add.png" class="addRangeImg" alt="Add IP Address"/>
        <img src="images/remove.png" class="removeRangeImg" alt="Remove IP Address"/>
    </div>

</div>
</body>
</html>