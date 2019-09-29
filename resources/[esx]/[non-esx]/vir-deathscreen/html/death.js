$(document).ready(function() {
  
    var counter = 0;
    var c = 0;
    var i = setInterval(function(){
    
      counter++;
      c++;
        
      if(counter == 101) {
          clearInterval(i);
      }
    }, 2000);
});