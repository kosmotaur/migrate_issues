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
  lint.on 'exit', ->
    console.info "Linting complete"

task 'test', 'Run tests', ->
  readdir "test", (err, files) ->
    vows = spawn 'node_modules/vows/bin/vows', files.map (file) -> 'test/' + file
    vows.stdout.on 'data', log
    vows.stderr.on 'data', error
    vows.on 'exit', ->
      console.info "Testing complete"