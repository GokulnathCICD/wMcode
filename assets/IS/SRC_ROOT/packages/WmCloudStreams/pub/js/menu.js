//  Copyright (c) 2013-2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

/**
 * @author mgunasek
 */

$(document).ready(function() {

 $('.TreeView li').each(function(){
          var curr = $(this);
          curr.click(function(evt){
                if (curr.find('ul').size()>0) {
                   $(this).toggleClass('expanded').toggleClass('collapsed');
                }
                evt.stopPropagation();
          });
    });

    $('a').click(function(){
       $('a').removeClass('selected');
       $(this).addClass('selected'); 
    });

});

