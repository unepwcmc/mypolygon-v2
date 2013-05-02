Backbone.Views ||= {}

class Backbone.Views.AreaView extends Backbone.View
  className: 'area-show'
  template: JST["backbone/templates/area"]

  events:
    'click #add-polygon': 'toggleDrawing'
    'click #add-circle': 'toggleDrawing'
    'click .aoi-details-header': 'togglePolygonDetails'
    'click #upload-file': 'startUploadFile'

  initialize: (options) ->
    @area = options.area
    @area.on('sync', @render)

    pica.on('syncStarted', @showLoadingSpinner)
    pica.on('syncFinished', @hideLoadingSpinner)

    @showAreaPolygonsView = window.pica.currentWorkspace.currentArea.newShowAreaPolygonsView()

  toggleDrawing: (event) ->
    $el = $(event.target)
    type = $el.attr('data-type')

    if @polygonView?
      @removeNewPolygonView()
    else
      @polygonView = @area["drawNew#{type}View"].call(@area,
        success: () =>
          @removeNewPolygonView()
          @render()
        error: (xhr, textStatus, errorThrown) =>
          alert("Can't save polygon: #{errorThrown}")
      )

  startUploadFile: ->
    @fileView = @area.newUploadFileView(success:@onFileUploadSuccess)
    @$el.append(@fileView.el)

  onFileUploadSuccess: =>
    @fileView = null
    @area.fetch(
      success: (data) ->
        console.log('fetched after file upload')
      error: (a,b,c) ->
        console.log('failed to fetch after file upload')
    )

  showLoadingSpinner: =>
    $('.loading').empty().show().append().append(@makeSpinner().el)
    @showSpinner = true

  spinnerOptions:
    lines: 11 # The number of lines to draw
    length: 15 # The length of each line
    width: 6 # The line thickness
    radius: 18 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    direction: 1 # 1: clockwise, -1: counterclockwise
    color: "#000" # #rgb or #rrggbb
    speed: 1 # Rounds per second
    trail: 50 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: "spinner" # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: "auto" # Top position relative to parent in px
    left: "auto" # Left position relative to parent in px

  makeSpinner: ->
    new Spinner(@spinnerOptions).spin()

  hideLoadingSpinner: =>
    $('.loading').hide()
    @showSpinner = false

  togglePolygonDetails: (event)->
    $el = $(event.target)
    $el.toggleClass('hide')
    $el.next('.aoi-details').slideToggle()

  removeNewPolygonView: ->
    if @polygonView?
      @polygonView.close()
      delete @polygonView

  onClose: () ->
    @removeNewPolygonView()
    @showAreaPolygonsView.close()
    @area.off('sync', @render)

    pica.off('syncStarted', @showLoadingSpinner)
    pica.off('syncFinished', @hideLoadingSpinner)

  resultsArrToObj: ->
    if @area.get('results')?
      keyedResults = {}
      _.each(@area.get('results'), (result)->
        keyedResults[result.display_name] = result
      )
      return keyedResults
    else
      return {}

  render: =>
    $(@el).html(@template(area: @area, results: @resultsArrToObj()))
    @$el.append(@fileView.el) if @fileView?
    if @showSpinner?
      @showLoadingSpinner()

    return @
