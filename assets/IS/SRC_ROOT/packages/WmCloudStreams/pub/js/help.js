//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

function setDocPage(docUrl) {
    var helpLnk = $("#helpUrl", parent.frames.topmenu.document);
    if (helpLnk) {
        helpLnk.attr('href', docUrl);
    }
}

