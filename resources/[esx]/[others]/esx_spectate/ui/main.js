$(function(){

	$('.users').on('click', '.spec', function(){

		let target = $(this).data('spectate');

		let player = $('.spectate').attr('id');

		if (target == player) {
			alert("Tu ne peux pas te regarder toi même !");
		} else {
			$('.spectate').fadeOut();
			$.post('http://esx_spectate/select', JSON.stringify({id: target}));
		}

	});

	$('.users').on('click', '.kick', function(){

		let target = $(this).data('kick');

		let reason = prompt("KICK REASON", "Nom + Prénom RP sur STEAM, Merci.");

		if (reason == null || reason == "") {
		    alert("MISSING KICK REASON")
		} else {
		    $('.spectate').fadeOut();
			$.post('http://esx_spectate/kick', JSON.stringify({id: target, reason: reason}));
		}
	});

	$('.header').on('click', '#close', function(){
		$('.spectate').fadeOut();
		$.post('http://esx_spectate/quit');
	});

	window.addEventListener('message', function(event){
		if (event.data.type == "show"){
			let data = event.data.data;
			let player = event.data.player;
			$('.spectate').attr('id', player);
			populate(data);
			setTimeout(function(){
				$('.spectate').fadeIn();
			}, 200)
		}
	});

	$(document).keyup(function(e){
		if (e.keyCode == 27){
			$('.spectate').fadeOut();
			$.post('http://esx_spectate/close');
		}
	})

});

function populate(data){
	$('.spectate .users').html('');

	data.sort(function(a, b) {
		let idA = a.id;
		let idB = b.id;
		if (idA < idB)
	        return -1 
	    if (idA > idB)
	        return 1
	    return 0
	});

	for (var i = 0; i < data.length; i++) {
		let id = data[i].id;
		let name = data[i].name;

		let element = 	'<div class="user">' +
							'<span class="user-id">' + id + '</span>' +
							'<span class="user-name">' + name + '</span>' +
							'<span class="user-actions">' +
								'<button class="spec" data-spectate="' + id + '">Spectate</button>' +
								'<button class="kick" data-kick="' + id + '">KICK</button>' +
							'</span>' +
						'</div>';

		$('.spectate .users').append(element);
	}

}