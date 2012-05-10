IssuesConnector = (require './abstract/issues_connector.coffee').IssuesConnector

exports.YoutrackConnector =
  class YoutrackConnector extends IssuesConnector