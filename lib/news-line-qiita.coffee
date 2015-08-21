Qiita = require './qiita.coffee'
{CompositeDisposable} = require 'atom'

module.exports = NewsLineQiita =

  activate: (state) ->

  consumeNewsLine: (@newsLine) ->
    @qiita = new Qiita @newsLine.newsInterval,
      @newsLine.newsNumber
    @newsLine.registerSite @qiita

  deactivate: ->
    @subscriptions.dispose()
