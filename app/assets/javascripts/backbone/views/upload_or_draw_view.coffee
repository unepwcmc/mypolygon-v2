window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.UploadOrDrawView extends Backbone.View
  template: JST['backbone/templates/upload_or_draw']
  events:
    "click #start-draw": "triggerShowNewWorkspace"
    "click #start-upload": "triggerStartUpload"

  initialize: (options) ->
    @render()

  render: =>
    @$el.html(@template())

  triggerShowNewWorkspace: =>
    window.pica_app.newWorkspace()
    @trigger('showWorkspace')

  triggerStartUpload: =>
    @trigger('startUpload')

  onClose: ->
