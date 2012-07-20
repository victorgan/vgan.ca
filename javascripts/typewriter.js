    // typewriter style caption
    var char = 0;
    var caption = "";
     
    function showCaption(obj) {
        caption = obj.attr('title');
        if(caption)
        {
            var initialWaitTimeMs = 400;
            setTimeout("type()", initialWaitTimeMs );
        }
    }
    
    function type() {	
        $('h1.title').html(caption.substr(0, char++));
        if(  char < caption.length+1 && 
             (caption.charAt(char - 1) == '<') &&
             (caption.charAt(char - 0) == 'b') &&
             (caption.charAt(char + 1) == 'r') &&
             (caption.charAt(char + 2) == '/') &&
             (caption.charAt(char + 3) == '>') 
          )
        {
          char = char + 4;
          $('h1.title').html(caption.substr(0, char));
          var waitTimeMilliseconds = 500;
          setTimeout("type()", waitTimeMilliseconds);
        }
        else if(  char < caption.length+1 && 
            ( (caption.charAt(char - 2) == ',') ||
              (caption.charAt(char - 2) == '!') )
          )
        {
            var waitTimeMilliseconds = 500;
            setTimeout("type()", waitTimeMilliseconds);
        }
        else if(char < caption.length+1 && caption.charAt(char - 2) == '.')
        {
            var waitTimeMilliseconds = 750;
            setTimeout("type()", waitTimeMilliseconds);
        }
        else if(char < caption.length+1)
        {
            var waitTimeMilliseconds = 28;
            setTimeout("type()", waitTimeMilliseconds);
        }
        else 
        {
            char = 0;
            caption = "";
        }	
    }
