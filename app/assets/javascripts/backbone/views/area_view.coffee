Backbone.Views ||= {}

class Backbone.Views.AreaView extends Backbone.View
  template: JST["backbone/templates/area"]

  events:
    'click .btn-add-polygon': 'toggleDrawing'

  initialize: (options) ->
    @area = options.area
    @area.on('sync', @render)

    @showAreaPolygonsView = window.pica.currentWorkspace.currentArea.newShowAreaPolygonsView()

  toggleDrawing: (event) ->
    $el = $(event.target)

    if @polygonView?
      @removeNewPolygonView()
    else
      @polygonView = @area.drawNewPolygonView(
        success: () =>
          @removeNewPolygonView()
          @render()
        error: (xhr, textStatus, errorThrown) =>
          alert("Can't save polygon: #{errorThrown}")
      )

  removeNewPolygonView: ->
    if @polygonView?
      @polygonView.close()
      delete @polygonView

  onClose: () ->
    @removeNewPolygonView()
    @showAreaPolygonsView.close()
    @area.off('sync', @render)

  render: =>
    $(@el).html(@template(area: @area))

    return @
