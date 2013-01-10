Backbone.Views ||= {}

class Backbone.Views.AreaView extends Backbone.View
  template: JST["backbone/templates/area"]

  events:
    'click .btn-add-polygon': 'toggleDrawing'

  initialize: (options) ->
    @area = options.area

  toggleDrawing: (event) ->
    $el = $(event.target)

    if @polygonView?
      @removeNewPolygonView()
    else
      @polygonView = window.pica.currentWorkspace.currentArea.drawNewPolygonView(() =>
        @removeNewPolygonView()
        @render()
      )

  removeNewPolygonView: ->
    if @polygonView?
      @polygonView.close()
      delete @polygonView

  close: () ->
    @removeNewPolygonView()

  render: =>
    $(@el).html(@template(area: @area))

    return @
