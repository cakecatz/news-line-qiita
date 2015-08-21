fetch = require 'node-fetch'

module.exports =
class NewsLineQiita
  name: 'Qiita'
  API_URL: 'qiita.com/api'
  API_VERSION: 'v2'
  items: []
  itemIndex: null

  constructor: (@newsInterval, @newsNumber) ->

  subscribe: (@newsLine) ->
    # start push news to news-line
    @fetchItems =>
      @process = setInterval =>
        @newsLine.pushNews @getItem()
      , @newsInterval


  fetchItems: (callback) ->
    fetch "#{@getApiUrl()}/items?page=1&per_page=#{@newsNumber}&query=tagr%3AAtom"
      .then (res) ->
        res.json()
      .then (items) =>
        @items = items
        callback()

  unsubscribe: ->
    # stop push news to new-line
    clearInterval @process

  update: ->
    # update to latest news

  getApiUrl: ->
    "http://#{@API_URL}/#{@API_VERSION}"

  getItem: ->
    if @itemIndex >= @newsNumber or @itemIndex is null
      @itemIndex = 0
    else
      @itemIndex++

    @items[@itemIndex]
