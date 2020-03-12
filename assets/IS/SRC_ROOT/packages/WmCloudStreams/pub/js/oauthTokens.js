//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

$(function () {
    //left right table styles added by cloudstreams.js don't apply to alias info table
    $("div.tokenAlias table td").each(function() {$(this).removeClass("left").removeClass("right")});

    //confirm alias delete
    $("a.delAliasLnk").click(function (e) {
        var aliasName = $(this).find(".delAliasName").text();
        var isDel = confirm(getmsg("delete.token.alias", aliasName));
        if (!isDel) {
             blockEvt(e);
        }
    });

});

