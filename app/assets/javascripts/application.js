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

$(document).ready(function() {
  var map, tileLayer, tileLayerUrl;

  // Create a leaflet map to use
  map = L.map('map',{
    center: [54, 24.5],
    minZoom: 7,
    zoom: 9
  });

  tileLayerUrl = 'http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png';
  tileLayer = new L.TileLayer(tileLayerUrl, {
    maxZoom: 18
  }).addTo(map);

  // Start a new pica application, with the given options
  window.pica = new Pica.Application({
    magpieUrl: "http://magpie.unepwcmc-005.vm.brightbox.net",
    projectId: 4,
    map: map
  });

  var mainController = new Backbone.Controllers.MainController();
  $('#sidebar').html(mainController.$el);
});

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
