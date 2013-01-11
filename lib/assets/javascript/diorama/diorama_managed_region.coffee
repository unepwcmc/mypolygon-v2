# Manages display and removal of multiple views which are switched between.
# It does this by storing a reference to the current view, then calling it's .close()
# function when another view is switched to
#
# Inspired by: http://lostechies.com/derickbailey/2011/09/15/zombies-run-managing-page-transitions-in-backbone-apps/
window.Backbone.Diorama ||= {}
class Backbone.Diorama.ManagedRegion
  constructor: (options) ->
    @tagName = (options.tagName if options?) || 'div'
    @$el = $("<#{@tagName}>")

  # Close the current view, render the given view into @element
  showView: (view) ->
    if (@currentView)
      @currentView.close()

    this.currentView = view
    this.currentView.render()

    @$el.html(this.currentView.el)

  # Returns true if element is empty
  isEmpty: () ->
    return @$el.is(':empty')

# Augment backbone view to add close method
# Inspired by http://stackoverflow.com/questions/7567404/backbone-js-repopulate-or-recreate-the-view/7607853#7607853
_.extend(Backbone.View.prototype, 
  # Unbind and call onClose method, if implementer of backbone.view has implemented one
  close: () ->
    @unbind()
    @remove()
    @onClose() if @onClose # Some views have specific things to clean up
)
