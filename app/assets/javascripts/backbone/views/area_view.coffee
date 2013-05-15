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

    pica_app.on('syncStarted', @showLoadingSpinner)
    pica_app.on('syncFinished', @hideLoadingSpinner)

    @showAreaPolygonsView = pica_app
      .currentWorkspace.currentArea.newShowAreaPolygonsView()

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
    $('.spinner').show()
    @showSpinner = true

  hideLoadingSpinner: =>
    $('.spinner').hide()
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

    pica_app.off('syncStarted', @showLoadingSpinner)
    pica_app.off('syncFinished', @hideLoadingSpinner)

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
