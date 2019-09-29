// MADE BY KALU AND KASHNAR
// [ALL CITY]
// version : 1.00
// update : 16/06/2018
// info: 

    window.onData = function(data) {
    	if (data.setDisplay == true) {
            $("body").css('background', '#131313bd');
            $("#container").css('display', 'flex');
    	} else {
            $('*').css('background', 'transparent');
            $("#container").css('display', 'none');
    	}
    	
    }


    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            onData(event.data)
        });
    }

