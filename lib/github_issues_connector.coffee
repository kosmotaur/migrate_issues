IssuesConnector = (require './abstract/issues_connector.coffee').IssuesConnector

exports.GithubConnector =
  class GithubConnector extends IssuesConnector