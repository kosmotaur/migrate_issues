GitHubConnector = require("../lib/github_connector").GitHubConnector
config = require("../config/config.coffee")

suite = exports

suite.setUp = (callback) ->
  @ghc = new GitHubConnector config.github
  callback()

suite["Test github connector"] =
  "test if issues field is a getter"               : (test) ->
    descriptor = Object.getOwnPropertyDescriptor @ghc, 'issues'
    test.ok typeof descriptor, 'object'
    test.ok typeof descriptor.get, 'function'
    test.done()
  "test if issues getter returns a promise"        : (test) ->
    console.dir(@ghc.issues)
    test.ok typeof @ghc.issues.then, "function"
    test.done()
  "test if promise calling back with issues array" : (test) ->
    test.expect 1
    @ghc.issues.then (issues) ->
      console.dir(issues)
      test.ok Array.isArray issues
      test.done()
