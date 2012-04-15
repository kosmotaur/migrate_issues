{spawn} = require 'child_process'
{readdir} = require 'fs'

log = (data) -> console.log data.toString()
error = (data) -> console.error data.toString()

task 'build', 'Run tests and coffelint sources', ->
  invoke 'lint'
  invoke 'test'

task 'lint', 'Coffeelint sources', ->

  lint = spawn 'node_modules/coffeelint/bin/coffeelint', ['-r', 'lib']
  lint.stdout.on 'data', log
  lint.stderr.on 'data', error

task 'test', 'Run tests', ->
  nodeunit = spawn 'node_modules/nodeunit/bin/nodeunit', ['test/']
  nodeunit.stdout.on 'data', log
  nodeunit.stderr.on 'data', error
