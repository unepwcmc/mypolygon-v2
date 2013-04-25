window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.UploadFileView extends Backbone.View
  template: JST['backbone/templates/upload_file_view']
  events:
    "submit form#workspace-file": "createWorkspace"

  initialize: (options) ->
    @render()

  render: =>
    @$el.html(@template(magpieUrl: pica.config.magpieUrl))

  createWorkspace: ->
    file = $("[name=file]")[0]

  onClose: ->
