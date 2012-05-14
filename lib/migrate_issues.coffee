config = require '../config/config'
githubConnector = new (require 'github_connector').GithubConnector config.github
youtrackConnector = new (require 'youtrack_connector').YoutrackConnector config.youtrack

exports.migrateIssues = ->
  youtrackConnector.issues = githubConnector.issues