Backbone.Views ||= {}

class Backbone.Views.AreaView extends Backbone.View
  className: 'area-show'
  template: JST["backbone/templates/area"]

  events:
    'click #add-polygon': 'toggleDrawing'
    'click #add-circle': 'toggleDrawing'
    'click .aoi-details-header': 'togglePolygonDetails'

  initialize: (options) ->
    @area = options.area
    @area.on('sync', @render)

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

    return @