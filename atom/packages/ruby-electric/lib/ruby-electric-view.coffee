{View} = require 'atom'

module.exports =
class RubyElectricView extends View
  @content: ->
    @div class: 'ruby-electric overlay from-top', =>
      @div "The RubyElectric package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "ruby-electric:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "RubyElectricView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
