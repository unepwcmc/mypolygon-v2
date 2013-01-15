window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.UploadFileView extends Backbone.View
  template: JST['backbone/templates/upload_file_view']

  initialize: (options) ->
    @render()

  render: =>
    @$el.html(@template())

  onClose: ->
