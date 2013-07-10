#currently handles only github -> common format
Comment = (require "./comment").Comment
_ = require "underscore"
exports.Issue =
class Issue
  constructor : (input, sourceType, mappings) ->
    _(mappings.issue).each (mapping, name) =>
      result = mapping input
      if result? then @[name] = result
    @comments = input.comments.map (comment) -> new Comment comment, sourceType, mappings
