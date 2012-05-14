config = require './config/config'
GitHubConnector = (require './lib/github_connector').GitHubConnector
githubConnector = new GitHubConnector(config.github)
githubConnector.promise.then (issues) ->
  console.info(issues.length)
  console.info(githubConnector.requestsMade)
