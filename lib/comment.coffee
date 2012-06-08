#currently handles only github -> common format
_ = require "underscore"
exports.Comment =
class Comment
  constructor: (input, sourceType, mappings) ->
    _(mappings.comment).each (mapping, name) =>
      if mapping input then @[name] = mapping input
