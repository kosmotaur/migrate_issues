config = require '../config/config'
githubConnector = new (require './github_issues_connector').GithubConnector config.github
youtrackConnector = new (require './youtrack_issues_connector').YoutrackConnector config.youtrack

exports.migrateIssues = ->
  youtrackConnector.issues = githubConnector.issues