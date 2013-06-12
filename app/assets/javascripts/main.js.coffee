# console is undefined error for internet explorer
#console = log: ->  unless window.console

#window.roundToDecimals = (number, places) ->
#  places = Math.pow(10, places)
#  Math.round(number * places) / places

$(document).ready ->

  # Some (extra long) urls:
  baseTileLayerUrl = "http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png"
  placesTileLayerUrl = "http://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}"

  # Create a leaflet map to use
  map = L.map("map",
    center: [54, 24.5]
    zoom: 4
  )
  tileLayer = new L.TileLayer(baseTileLayerUrl).addTo(map)

  # Extra Layers for Pica
  overlayMaps =
    "Boundaries and Places": L.tileLayer(placesTileLayerUrl)
  
  # Start a new pica application, with the given options
  window.pica = new Pica.Application(
    magpieUrl: "http://magpie.unepwcmc-005.vm.brightbox.net",
    projectId: 8
    map: map
    delegateLayerControl: yes
    extraOverlays: overlayMaps
  )

  mainController = new Backbone.Controllers.MainController()
  $("#sidebar").html mainController.$el
  $("#search form").submit (e) ->
    e.preventDefault()
    $.getJSON "http://nominatim.openstreetmap.org/search",
      format: "json"
      q: $("#search form #query").val()
    , (data) ->
      map.fitBounds [[parseFloat(data[0].boundingbox[0]), parseFloat(data[0].boundingbox[2])], [parseFloat(data[0].boundingbox[1]), parseFloat(data[0].boundingbox[3])]]  if data.length > 0

    false

