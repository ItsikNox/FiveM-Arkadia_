var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#wrap').fadeOut();
				} else {
					$('#wrap').fadeIn();
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'toggleID':

				if (event.data.state) {
					$('td:nth-child(2),th:nth-child(2)').show();
					$('td:nth-child(5),th:nth-child(5)').show();
					$('td:nth-child(8),th:nth-child(8)').show();
					$('td:nth-child(11),th:nth-child(11)').show();
				}

				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);

				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#taxi').html(jobs.taxi);
				$('#mechanic').html(jobs.mechanic);
				/* $('#slaughterer').html(jobs.slaughterer);
				$('#fueler').html(jobs.fueler);
				$('#lumberjack').html(jobs.lumberjack);
				$('#tailor').html(jobs.tailor); */
				$('#reporter').html(jobs.reporter);
				/* $('#miner').html(jobs.miner); */
				$('#estate').html(jobs.estate);
				$('#cardeal').html(jobs.cardeal);
				$('#arma').html(jobs.arma);
				$('#stato').html(jobs.stato);
				$('#unemployed').html(jobs.unemployed);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				applyPingColor();
				//sortPlayerList();
				break;

			case 'updatePing':
				updatePing(event.data.players);
				applyPingColor();
				break;

			case 'updateServerInfo':
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				if (event.data.playTime) {
					$('#play_time').html(event.data.playTime);
				}

				break;

			default:
				console.log('esx_scoreboard: unknown action!');
				break;
		}
	}, false);
});

function applyPingColor() {
	$('#playerlist tr').each(function () {
		$(this).find('td:nth-child(3),td:nth-child(6),td:nth-child(9),td:nth-child(12)').each(function () {
			var ping = $(this).html();
			var color = 'green';

			if (ping > 150 && ping < 300) {
				color = 'orange';
			} else if (ping >= 300) {
				color = 'red';
			}

			$(this).css('color', color);
			$(this).html(ping + " <span style='color:white;'>ms</span>");
		});

	});
}

// Todo: not the best code
function updatePing(players) {
	jQuery.each(players, function (index, element) {
		if (element != null) {
			$('#playerlist tr:not(.heading)').each(function () {
				$(this).find('td:nth-child(2):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(2).html(element.ping);
				});
				$(this).find('td:nth-child(5):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(5).html(element.ping);
				});
				$(this).find('td:nth-child(8):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(8).html(element.ping);
				});
				$(this).find('td:nth-child(11):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(11).html(element.ping);
				});
			});
		}
	});
}

function sortPlayerList() {
	var table = $('#playerlist'),
		rows = $('tr:not(.heading)', table);

	rows.sort(function(a, b) {
		var keyA = $('td', a).eq(1).html();
		var keyB = $('td', b).eq(1).html();

		return (keyA - keyB);
	});

	rows.each(function(index, row) {
		table.append(row);
	});
}
