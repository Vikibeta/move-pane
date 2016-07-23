{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'move-pane:split-right': => @movePane 'right'
      'move-pane:split-left' : => @movePane 'left'
      'move-pane:split-up'   : => @movePane 'up'
      'move-pane:split-down' : => @movePane 'down'

  deactivate: ->
    @subscriptions.dispose

  notify: ( message ) ->
    atom.notifications.addInfo message

  movePane: ( direction ) ->
    currentPane = atom.workspace.getActivePane()
    currentItem = currentPane.getActiveItem()
    params =
      'copyActiveItem': true

    if currentPane.getItems().length < 2
      @notify '[move-pane] Moving pane is available only when there are more than 2 tabs in the current pane.'

    switch direction
      when 'right' then currentPane.splitRight( params )
      when 'left'  then currentPane.splitLeft( params )
      when 'up'    then currentPane.splitUp( params )
      when 'down'  then currentPane.splitDown( params )

    currentPane.destroyItem( currentItem )
