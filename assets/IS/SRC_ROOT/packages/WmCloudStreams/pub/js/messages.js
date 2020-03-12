/* Auto-generated text file from Localization Framework 7.7.12.43 Version=trunk Locale= DO NOT EDIT BY HAND! */

String.prototype.format = function(args) {
    var txt = this, i = args.length;
    while (i--) {
        txt = txt.replace(new RegExp('\\{' + i + '\\}', 'gm'), args[i]);
    }
    return txt;
};

/**
 * arg1 = msg key
 * arg2..n = msg params
 */
function getmsg() {
    var msg = messages[arguments[0]];
    if (msg == undefined) {
        msg = messages["missing.msg"];
        arguments[1] = arguments[0];
    }
    if (arguments.length > 1) {
       var args = [];
       for (var i=1; i<arguments.length; i++) args.push(arguments[i]);
       msg = msg.format(args);
    }
    return msg;
}

var messages = {

    "config.error": "There are configuration errors in the form. Required fields are highlighted.\nPlease correct them and try again! ",
    "delete.config": "Are you sure you want to delete this STS configuration?",
    "missing.msg": "Missing message key [{0}]!",
    "pjs1": "missing.msg",
    "port.remove.error": "Cannot remove primary HTTP port [{0}]. CloudStreams is always available on the primary port",
    "pwd.no.match": " Passwords don\'t match!",
    "pwd.wrong.len": "Password length must be >= {0} characters!",
    "save": "Save",
    "saving": "Saving...",
    "sts.epr.missing": "STS Endpoint value must be specified",
    "sts.name.bad.char": "STS name contains an illegal character \'{0}\'",
    "sts.name.missing": "STS name must be specified",
    "testing": "Testing...",
    "url.invalid": "URL is invalid (should be http(s)://domain:port)",
    "username.bad.char": "Username contains an illegal character \'{0}\'",
    "name.bad.char": "Name contains an illegal character \'{0}\'",
    "invalid.ip": "Invalid IP Address",
    "delete.streaming.subscriber": "Delete streaming subscriber configuration \'{0}\'?",
    "delete.streaming.provider": "Delete streaming provider configuration \'{0}\'?",
    "confirm.delete.provider": "The provider \'{0}\' is used by the following streaming subscribers:\n{1}\n\nAre you sure you want to delete it?",
    "delete.token.alias": "Delete token alias \'{0}\'?",
    "delete.consumer": "Delete consumer \'{0}\'?",
    "connection.view.basic": "Basic view",
    "connection.view.advanced": "Advanced view",
    "many.password.fields": "Error: Too many password fields.",
    "errors": "Error(s):",
    "retype.password": "Password for {0} must be retyped for confirmation.",
    "pwd.mismtach": "The passwords entered for \'{0}\' do not match.",
    "missing.required.field": "Missing required field(s) - ",
    "invalid.number": "\'{0}\' value must be a valid number.",
    "folder.name": "Folder Name",
    "connection.name": "Connection Name",
    "missing.field.name": "{0} required for connection resource.",
    "missing.filter.criteria": "Please enter Filter criteria.",
    "spcl.chars.in.filter": "Filter criteria has special characters. These are not allowed. Please remove them and try again.",
    "missing.search.criteria": "Please enter search criteria.",
    "log.enable.warning": "CAUTION !!! \n \n Enabling wire logging will log all data transmitted to and from CloudStreams when executing \nHTTP requests. This log should only be enabled to debug problems because it will produce a \n large amount of log data.  \n Further, enabling wire logging will reveal sensitive data, for example, user credentials\n and authorization headers in the logs. It is recommended to filter out or mask the sensitive\n data before sharing the logs.",
    "confirm.connector.delete": "OK to delete the \'{0}\' connector?\n\n\\",
    "confirm.connector.reload": "OK to reload the \'{0}\' connector?\n\nReloading a connector may cause sessions currently using connections for that provier to fail.",
    "confirm.connector.disable": "OK to disable the \'{0}\' connector?\n\n",
    "confirm.connector.enable": "OK to enable the \'{0}\' connector?\n\n",
    "confirm.connection.disable": "OK to disable the \'{0}\' connection?\n\nDisabling a connection causes all services to be unavailable for use.",
    "confirm.connection.enable": "OK to enable the \'{0}\' connection?\n\n",
    "confirm.connection.delete": "OK to delete the \'{0}\' connection?\n\n",
    "invalid.input.field": "Invalid input field(s) - ",
    "largeStream.enable.warning": "Large data configuration enables CloudStreams to send and receive large binary streams over HTTP/HTTPS. This ensures that during outbound and inbound invocation, if the stream is greater than the Threshold Size, the entire stream is not stored in memory. Before enabling the large data handling capability of CloudStreams, configure the TSpace properties (watt.server.tspace.*) in the Integration Server Administrator > Settings > Extended > Show and Hide Keys page.\nSee the webMethods Integration Server Administrator\u2019s Guide for information on the TSpace properties.",
    "confirm.listener.disable": "Do you want to disable the \'{0}\' listener?\n\nDisabling a listener stops all incoming events for the listener.",
    "confirm.listener.enable": "Do you want to enable the \'{0}\' listener?\n\nWhen a listener is enabled, you will not be able to change the listener\'s subscription and event actions from webMethods Designer Service Development.",
    "redirect.uri.note": "Add this URI in the Redirect URIs (Callback URL) field of the OAuth application settings section, in your SaaS provider.",
    "redirect.uri": "Redirect URI",
    "error.caption": "Error: ",
    "description.caption": "Description: ",
    "missing.input.caption": "Missing input"

};
