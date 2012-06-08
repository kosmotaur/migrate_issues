#currently handles only github -> common format
Comment = (require "./comment").Comment
_ = require "underscore"
exports.Issue =
class Issue
  constructor : (input, sourceType, mappings) ->
    _(mappings.issue).each (mapping, name) =>
      if mapping input then @[name] = mapping input
    @comments = input.comments.map (comment) -> new Comment comment, sourceType, mappings