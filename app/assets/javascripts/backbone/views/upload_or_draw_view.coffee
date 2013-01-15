window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.UploadOrDrawView extends Backbone.View
  template: JST['backbone/templates/upload_or_draw']
  events: 
    "click #start-draw": "triggerShowNewWorkspace"

  initialize: (options) ->
    @render()

  render: =>
    @$el.html(@template())

  triggerShowNewWorkspace: =>
    window.pica.newWorkspace()
    @trigger('showWorkspace')

  onClose: ->
