$(document).ready(function () {

		function space() {
			return window.location.pathname.match(/\d+/)
		};

    $("#my-calendar").zabuto_calendar({
    	language: "en",
    	ajax: {
    		url: 'http://localhost:9292/available_dates/' + space(),
    		modal: true
    	}
    });

});
