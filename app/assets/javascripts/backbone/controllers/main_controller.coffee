window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    @mainRegion = new Backbone.Diorama.ManagedRegion()
    $('body').append(@mainRegion.$el)

    # Start action
    @index()

  index: =>
