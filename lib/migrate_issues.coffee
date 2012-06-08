Deferred = require("./deferred").Deferred
config = require '../config/config'
IssueSet = require("./issue_set").IssueSet

exports.migrateIssues = ->
  d = new Deferred

  ghc = new (require './github_connector').GitHubConnector config.github
  ytc = new (require './youtrack_connector').YouTrackConnector config.youtrack
  ghc.d.then (issues) ->
    ytc.importIssues(new IssueSet issues).then (res) ->
      d.resolve(res)

  d