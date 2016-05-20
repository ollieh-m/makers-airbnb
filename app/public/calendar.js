$(document).ready(function () {

		function space() {
			return window.location.pathname.match(/\d+/)
		};

        function host() {
            return window.location.host
        }

    $("#my-calendar").zabuto_calendar({
    	language: "en",
    	ajax: {
    		url: 'http://' + host() + '/available_dates/' + space(),
    		modal: true
    	}
    });

});
