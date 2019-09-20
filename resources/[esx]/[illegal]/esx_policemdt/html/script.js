// Define the `nui` module
var nui = angular.module('nui', [])
.config( [
    '$compileProvider',
    function( $compileProvider )
    {   
        $compileProvider.imgSrcSanitizationWhitelist('nui://');
        // Angular before v1.2 uses $compileProvider.urlSanitizationWhitelist(...)
    }
]);


nui.controller('nuiController', function nuiController( $scope, $document, $window ) {
	
	window.addEventListener('message', function(event) {		
        if ( event.data.type == 'GUI_pmobilet' ) {					
			if ( event.data.StatusJS == true ) {
				$('#loading_preview').show();
				$('#players_page').hide();
				$('#vehicles_page').hide();
				$(".selected").removeClass("selected");
				$("#warrants_menu").addClass("selected");
				$.post('http://esx_policemdt/esx_policemdt:GetWarrantsClient', JSON.stringify({
					page: 1
				}));
			}
			if ( event.data.ForceVehSearch == true ) {
				$('#loading_preview').show();
				$('#players_page').hide();
				$('#vehicles_page').hide();
				$('#search_page').hide();
				$('#form_page').hide();
				$('#table_page').hide();
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$(".selected").removeClass("selected");
				$("#search_li").addClass("selected");
				////console.log('JS Plate: ' + event.data.number);
				$.post('http://esx_policemdt/esx_policemdt:SearchVehicleClient', JSON.stringify({
					plate: event.data.number
				}));
			}
			if ( event.data.StatusJS == false ) {
				$('#wrapper').hide();
				document.getElementById("warrants_memes").innerHTML = '';
				document.body.style.backgroundColor = "transparent";
			}
			if ( event.data.newList == true ) {
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$('#table_page').show();
				$('#loading_preview').hide();
				document.getElementById("warrants_memes").innerHTML = event.data.html;
				document.getElementById("page_div").innerHTML = event.data.pag_div;
			}
			if ( event.data.newBolosList == true ) {
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$('#loading_preview').hide();
				document.getElementById("warrants_memes").innerHTML = event.data.html;
				document.getElementById("page_div").innerHTML = event.data.pag_div;
			}
			if ( event.data.newArrestsList == true ) {
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$('#loading_preview').hide();
				document.getElementById("warrants_memes").innerHTML = event.data.html;
				document.getElementById("page_div").innerHTML = event.data.pag_div;
			}
			if ( event.data.newPlayerSearch == true ) {
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$('#loading_preview').hide();
				$('#search_page').hide();
				$('#players_page').show();
				document.getElementById("search_table").innerHTML = event.data.html;
			}
			if ( event.data.newVehicleSearch == true ) {
				document.body.style.backgroundColor = "#222222";
				$('#wrapper').show();
				$('#loading_preview').hide();
				$('#search_page').hide();
				$('#vehicles_page').show();
				document.getElementById("search_table_vehicles").innerHTML = event.data.html;
			}
			if ( event.data.report_added == true ) {
				$('#loading_preview').hide();
				$("#notify_box").removeClass("alert-success");
				$("#notify_box").removeClass("alert-danger");
				$("#notify_box").addClass("alert-success");
				document.getElementById("notify_text").innerHTML = 'New report has been sent';
				$('#notify_box').show();
			}
        }
    });
	
});