window.Backbone ||= {}
window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    @mainRegion = new Backbone.Diorama.ManagedRegion()
    @$el = @mainRegion.$el

    # Default state
    @uploadOrDraw()
  
  uploadOrDraw: =>
    uploadOrDrawView = new Backbone.Views.UploadOrDrawView()
    @mainRegion.showView(uploadOrDrawView)

    @changeStateOn(
      {event: 'upload', publisher: uploadOrDrawView, newState: @uploadFile},
      {event: 'showWorkspace', publisher: uploadOrDrawView, newState: @showWorkspace}
    )
  
  showWorkspace: () =>
    workspaceShowView = new Backbone.Views.WorkspaceShowView()
    @mainRegion.showView(workspaceShowView)
  
  uploadFile: =>
    uploadFileView = new Backbone.Views.UploadFileView()
    @mainRegion.showView(uploadFileView)

    @changeStateOn(
      {event: '', publisher: uploadFileView, newState: @uploadOrDraw}
    )
  
