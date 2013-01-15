Backbone.Views ||= {}

class Backbone.Views.WorkspaceShowView extends Backbone.View
  template: JST["backbone/templates/area_tabs"]

  events:
    'click #add-area': 'addArea'
    'click .tab': 'changeTab'
    'click #delete-area': 'removeArea'

  initialize: () ->
    @currentTab = new Backbone.Diorama.ManagedRegion()

  changeTab: (event) ->
    $el = $(event.target)
    pica.currentWorkspace.setCurrentArea(pica.currentWorkspace.areas[$el.attr('data-area-id')])

    @render()

  addArea: ->
    if pica.currentWorkspace.areas.length <= 3
      workspace = pica.currentWorkspace

      area = new Pica.Models.Area()

      workspace.addArea(area)
      pica.currentWorkspace.setCurrentArea(area)
      @render()

  removeArea: () ->
    if @areas.length > 1
      id = @areas.indexOf(@currentArea)
      area = @areas.splice(id,1)[0]

      area.delete()

      @currentArea = @areas[@areas.length - 1]
      pica.currentWorkspace.currentArea = @currentArea
      @render()

  render: =>
    @$el.html(@template(areas: pica.currentWorkspace.areas, currentArea: pica.currentWorkspace.currentArea))

    areaView = new Backbone.Views.AreaView(area: pica.currentWorkspace.currentArea)
    @currentTab.showView(areaView)
    @$el.find('#area-tabs').append(@currentTab.$el)

    return @
