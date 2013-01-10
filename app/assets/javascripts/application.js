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
//= require_tree .

$(document).ready(function() {
  var map, tileLayer, tileLayerUrl;

  // Create a leaflet map to use
  map = L.map('map',{
    center: [24.5,54],
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

  // Create a new workspace to work in
  window.pica.newWorkspace();

  // Show drawn polygons on the map
  var showAreaPolygonsView = window.pica.currentWorkspace.currentArea.newShowAreaPolygonsView();

  // Show our custom PolyActionsView when any of the polygons are clicked
  showAreaPolygonsView.on("polygonClick", function(polygon, event) {
    new PicaExample.PolyActionsView(polygon, event);
  });

  // The area view listens for the currentArea 'sync' event, and displays the stats
  new PicaExample.AreaView("#area-stats");

  // Draw a new polygon view when user clicks add button
  $('#add-polygon-btn').click(function() {
    window.pica.currentWorkspace.currentArea.drawNewPolygonView();
  });
});
