window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MainUploadFileView extends Backbone.View
  template: JST['main/uploadfile']

  initialize: (options) ->
    @render()

  render: =>
    @$el.html(@template())

  onClose: ->
