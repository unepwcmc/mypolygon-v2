// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require leaflet
//= require leaflet.draw
//= require pica
//= require underscore-min
//= require json2
//= require backbone-min
//= require diorama/diorama_managed_region
//= require diorama/diorama_controller
//= require_tree .

var roundToDecimals = function(number, places) {
    places = Math.pow(10, places);
    return Math.round(number * places) / places;
};

$(document).ready(function() {
  var map, tileLayer, tileLayerUrl, boundariesLayer, boundariesLayerUrl;

  // Create a leaflet map to use
  map = L.map('map',{
    center: [54, 24.5],
    zoom: 4
  });

  tileLayerUrl = 'http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png';
  tileLayer = new L.TileLayer(tileLayerUrl).addTo(map);

  // Layers
  var overlayMaps = {
    'Protected Areas': L.tileLayer('http://184.73.201.235/blue/{z}/{x}/{y}'),
    'Boundaries and Places': L.tileLayer('http://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}').addTo(map)
  };

  L.control.layers({}, overlayMaps).addTo(map);

  // Start a new pica application, with the given options
  window.pica = new Pica.Application({
    magpieUrl: "http://magpie.unepwcmc-005.vm.brightbox.net",
    projectId: 5,
    map: map
  });

  var tileLayerView = pica.showTileLayers();

  var mainController = new Backbone.Controllers.MainController();
  $('#sidebar').html(mainController.$el);

  $('#search form').submit(function(e) {
    e.preventDefault();

    $.getJSON('http://nominatim.openstreetmap.org/search', {format: 'json', q: $('#search form #query').val()}, function(data) {
      if(data.length > 0) {
        map.fitBounds([
          [parseFloat(data[0].boundingbox[0]), parseFloat(data[0].boundingbox[2])],
          [parseFloat(data[0].boundingbox[1]), parseFloat(data[0].boundingbox[3])]
        ]);
      }
    });

    return false;
  });
});

/*
// Upload file (http://stackoverflow.com/questions/6718664/is-it-possible-to-peform-an-asynchronous-cross-domain-file-upload)
$(document).ready(function() {
  var form = $('form')

  form.on('submit', function() {
    var input = document.getElementsByName('file')[0];

    // STEP 1
    // retrieve a reference to the file
    // <input type="file"> elements have a "files" property
    var file = input.files[0];

    // STEP 2
    // create a FormData instance, and append the file to it
    var fd = new FormData();
    fd.append('file', file);

    // STEP 3 
    // send the FormData instance with the XHR object
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:3000/workspaces/from_file', true);
    xhr.onreadystatechange = function(event) {
      var xhr = event.target;

      if (xhr.readyState === 4 && xhr.status === 200) {
          console.log(xhr.responseText);
      }
    };
    xhr.send(fd);

    return false;
  });
});
*/
