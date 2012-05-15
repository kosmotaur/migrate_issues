GitHubConnector = require("../lib/github_connector").GitHubConnector
config = require("../config/config.coffee")

suite = exports

suite.setUp = (callback) ->
  @ghc = new GitHubConnector config.github
  callback()

suite["Test github connector"] =
  "test if connector exposes a promise"        : (test) ->
    test.ok typeof @ghc.promise.then, "function"
    test.done()
  "test if promise calling back with issues array" : (test) ->
    test.expect 1
    @ghc.promise.then (issues) ->
      test.ok Array.isArray issues
      test.done()
