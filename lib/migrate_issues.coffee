config = require 'config'

exports.migrateIssues = ->
  ghc = new GitHubConnector config.github
  ytc = new YouTrackConnector config.youtrack

  ytc.import ghc