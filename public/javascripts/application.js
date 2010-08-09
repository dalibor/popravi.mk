/*
 * Time ago in words
 */
var DateHelper = {
  // Takes the format of "Jan 15, 2007 15:45:00 GMT" and converts it to a relative time
  // Ruby strftime: %b %d, %Y %H:%M:%S GMT
  time_ago_in_words_with_parsing: function(from) {
    var date = new Date; 
    date.setTime(Date.parse(from));
    return this.time_ago_in_words(date);
  },
  
  time_ago_in_words: function(from) {
    return this.distance_of_time_in_words(new Date, from);
  },
 
  distance_of_time_in_words: function(to, from) {
    var distance_in_seconds = ((to - from) / 1000);
    var distance_in_minutes = Math.floor(distance_in_seconds / 60);
 
    if (distance_in_minutes == 0) { return 'пред помалку од минута'; };
    if (distance_in_minutes == 1) { return 'пред минута'; };
    if (distance_in_minutes < 45) { return 'пред ' + distance_in_minutes + ' минути'; };
    if (distance_in_minutes < 90) { return 'пред 1 час'; };
    if (distance_in_minutes < 1440) { return 'пред ' + Math.floor(distance_in_minutes / 60) + ' часа'; };
    if (distance_in_minutes < 2880) { return 'пред 1 ден'; };
    if (distance_in_minutes < 43200) { return 'пред ' + Math.floor(distance_in_minutes / 1440) + ' дена'; };
    if (distance_in_minutes < 86400) { return 'пред 1 месец'; };
    if (distance_in_minutes < 525960) { return 'пред ' + Math.floor(distance_in_minutes / 43200) + ' месеци'; };
    if (distance_in_minutes < 1051199) { return 'пред 1 година'; };

    return 'пред ' + (distance_in_minutes / 525960).floor() + ' години';
  }
};

/*
 * Make link from urls in tweet
 */
jQuery.fn.autolink = function () {
  return this.each( function(){
    var r = /((http|https|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
    $(this).html( $(this).html().replace(r, '<a href="$1" target="_blank">$1</a> ') );
  });
};

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
    };

    function deleteMarker () {
      if (markersArray) {
        for (i in markersArray) {
          markersArray[i].setMap(null);
        };
        markersArray.length = 0;
      };

      // delete lat and lng from hidden fields
      $("#problem_latitude").val('');
      $("#problem_longitude").val('');

      markerAdded = false; // mark that marker is not added
    };

    var initialize = function (lat, lng) {
      geocoder = new google.maps.Geocoder();

      if (lat && lng) {
        var latlng = new google.maps.LatLng(lat, lng);
      } else {
        var latlng = new google.maps.LatLng(42, 21.4333333);
      };

      var myOptions = {zoom: 15, center: latlng, mapTypeId: google.maps.MapTypeId.SATELLITE};

      map = new google.maps.Map($("#map_canvas")[0], myOptions);

      google.maps.event.addListener(map, 'click', function(event) {
        if (!markerAdded) {
          addMarker(event.latLng);
        } else {
          deleteMarker();
          addMarker(event.latLng);
        }
      });
    };

    var displayResults = function () {
      $("#geocode_results").html('');
      for (var i = 0; i < lastResults.length; i++) {
        var result = lastResults[i];
        $("#geocode_results").append(
          $('<div/>').append(
            $('<a/>').attr({id: "address_" + i, "class": "dym_address", href: "#"}).text(result.formatted_address)
          )
        );
      };
    };

    var searchAddress = function (address) {
      if (!address) {
        return;
      };

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
            };

            displayResults();
          } else {
            console.log("Geocode was not successful for the following reason: " + status);
          };
        });
      }
    };

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

    $(".dym_address").live("click", function (e) {
      e.preventDefault();
      var resultId = Number($(this).attr("id").match(/\d+/), 10);
      var result = lastResults[resultId];
      map.setCenter(result.geometry.location);
      $("#address").val(result.formatted_address);
    });

    // prevent submitting form by hitting Enter
    $(window).keydown(function(event){
      if(event.keyCode == 13) {
        event.preventDefault();
        return false;
      }
    });

    // initialize marker if lat & lng and not empty
    var lat = $("#problem_latitude").val();
    var lng = $("#problem_longitude").val();

    initialize(lat, lng);

    if (lat && lng) {
      var problemLatLng = new google.maps.LatLng(lat, lng);
      addMarker(problemLatLng);
    };
  }
};

var problems_show = {
  run: function () {
    var initialize = function () {
      var latlng = new google.maps.LatLng(_lat, _lng);

      var myOptions = {zoom: 15, center: latlng, mapTypeId: google.maps.MapTypeId.SATELLITE};

      var map = new google.maps.Map($("#map_canvas")[0], myOptions);
      var problemLatLng = new google.maps.LatLng(_lat, _lng);
      new google.maps.Marker({position: problemLatLng, map: map});
    };

    initialize();
  }
};

var welcome_index = {
  run: function () {
    //var user_timeline = function(username, count, callback){
      //requestURL = "http://twitter.com/statuses/user_timeline/" + username + ".json?callback=?&count=" + count;
      //$.getJSON(requestURL, callback);
    //};

    //user_timeline("PopraviMK", 5, function (json, status) {
      //var tweets = $("#tweets");
      //$.each(json, function(i) {
        //tweets.append(
          //$("<p/>").append(
            //$('<a/>').attr({href: "http://twitter.com/" + this.user.screen_name}).append(
              //$('<img/>').attr({"src": this.user.profile_image_url})
            //),
            //$('<div/>').attr({"class": "t_user"}).text(this.user.screen_name),
            //$('<div/>').attr({"class": "t_text"}).text(this.text),
            //$('<div/>').attr({"class": "t_date"}).text(DateHelper.time_ago_in_words_with_parsing(this.created_at))
          //).autolink()
        //)
      //});
    //});

    var search_results = function(query, count, callback){
      requestURL = "http://search.twitter.com/search.json?callback=?&q=" + query + "&rpp=" + count;
      $.getJSON(requestURL, callback);
    };

    search_results("popravimk", 5, function (json, status) {
      var tweets = $("#tweets");
      $.each(json.results, function(i) {
        tweets.append(
          $("<p/>").append(
            $('<a/>').attr({href: "http://twitter.com/" + this.from_user}).append(
              $('<img/>').attr({"src": this.profile_image_url})
            ),
            $('<div/>').attr({"class": "t_user"}).text(this.from_user),
            $('<div/>').attr({"class": "t_text"}).text(this.text),
            $('<div/>').attr({"class": "t_date"}).text(DateHelper.time_ago_in_words_with_parsing(this.created_at))
          ).autolink()
        )
      });
    });
  }
};

$(function () {
  var body_id = $('body').attr("id");
  if (body_id) {
    controller_action = body_id;
    if (typeof window[controller_action] !== 'undefined') {
      window[controller_action]['run']();
    }
  }
})
