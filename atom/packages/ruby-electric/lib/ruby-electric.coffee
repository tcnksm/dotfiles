RubyElectricView = require './ruby-electric-view'

module.exports =
  rubyElectricView: null

  activate: (state) ->
    @rubyElectricView = new RubyElectricView(state.rubyElectricViewState)

  deactivate: ->
    @rubyElectricView.destroy()

  serialize: ->
    rubyElectricViewState: @rubyElectricView.serialize()
