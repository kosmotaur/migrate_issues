vows = require 'vows'
assert = require 'assert'

vows.describe('Vows').addBatch(
  "Vows" :
    topic         : true
    "are present" : (topic) ->
      assert.strictEqual topic, true
).export(module)