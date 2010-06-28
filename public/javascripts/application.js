var problems_edit = problems_create = problems_update = problems_new = {
  run: function () {
    var map;
    var geocoder;
    var markersArray = [];
    var markerAdded = false; // mark that marker is not added
    var lastResults = [];
  
    function addMarker(location) {
      marker = new google.maps.Marker({position: location, map: map});
      markersArray.push(marker);

      // save lat and lng to hidden fields
      $("#problem_latitude").val(location.lat());
      $("#problem_longitude").val(location.lng());

      markerAdded = true; // mark that marker is added
    }

    function deleteMarker () {
      if (markersArray) {
        for (i in markersArray) {
          markersArray[i].setMap(null);
        }
        markersArray.length = 0;
      }

      // delete lat and lng from hidden fields
      $("#problem_latitude").val('');
      $("#problem_longitude").val('');

      markerAdded = false; // mark that marker is not added
    }

    var initialize = function (lat, lng) {
      geocoder = new google.maps.Geocoder();

      if (lat && lng) {
        var latlng = new google.maps.LatLng(lat, lng);
      } else {
        var latlng = new google.maps.LatLng(42, 21.4333333);
      }

      var myOptions = {zoom: 15, center: latlng, mapTypeId: google.maps.MapTypeId.SATELLITE};

      map = new google.maps.Map($("#map_canvas")[0], myOptions);

      google.maps.event.addListener(map, 'click', function(event) {
        if (!markerAdded) {
          addMarker(event.latLng);
        }
      });
    }

    var displayResults = function () {
      $("#geocode_results").html('');
      for (var i = 0; i < lastResults.length; i++) {
        var result = lastResults[i];
        $("#geocode_results").append(
          $('<div/>').append(
            $('<a/>').attr({id: "address_" + i, "class": "dym_address", href: "#"}).text(result.formatted_address)
          )
        )
      }
    }

    var searchAddress = function (address) {
      if (!address) {
        return;
      }

      if (geocoder) {
        geocoder.geocode( { 'address': address}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            if (results.length) {
              lastResults = results;
              var result = results[0];
              //deleteMarker();
              map.setCenter(result.geometry.location);
              $("#address").val(result.formatted_address);
            } else {
              lastResults = [];
            }

            displayResults();
          } else {
            console.log("Geocode was not successful for the following reason: " + status);
          }
        });
      }
    }

    $("#delete_marker").click(function (e) {
      e.preventDefault();
      deleteMarker();
    });

    $('#address').keyup(function (e) {
      if(e.which == 13){
        e.preventDefault();
        searchAddress($(this).val());
      }
    });

    $("#search_address").click(function (e) {
      e.preventDefault();
      searchAddress($("#address").val());
    });

    $(".dym_address").live("click", function () {
      var resultId = Number($(this).attr("id").match(/\d+/), 10);
      var result = lastResults[resultId];
      map.setCenter(result.geometry.location);
      $("#address").val(result.formatted_address);
    })

    //$("#problem_submit").click(function () {
      //$("form").attr({"action": $("form").attr("action") + "?location=" + $("#address").val()});
    //})

    // initialize marker if lat & lng and not empty

    var lat = $("#problem_latitude").val();
    var lng = $("#problem_longitude").val();

    initialize(lat, lng);

    if (lat && lng) {
      var problemLatLng = new google.maps.LatLng(lat, lng);
      addMarker(problemLatLng);
    }

    // initialize map to searched address
    //var address = window.location.search.match(/\?location=(.*)/);
    //if (address && address.length) {
      //searchAddress(decodeURIComponent(address[1]));
    //}
  }
}

var problems_show = {
  run: function () {
    var initialize = function () {
      var latlng = new google.maps.LatLng(_lat, _lng);

      var myOptions = {zoom: 15, center: latlng, mapTypeId: google.maps.MapTypeId.SATELLITE};

      var map = new google.maps.Map($("#map_canvas")[0], myOptions);
      var problemLatLng = new google.maps.LatLng(_lat, _lng);
      new google.maps.Marker({position: problemLatLng, map: map});
    }

    initialize();
  }
}

$(function () {
  var body_id = $('body').attr("id");
  if (body_id) {
    controller_action = body_id;
    if (typeof window[controller_action] !== 'undefined') {
      window[controller_action]['run']();
    }
  }
})
