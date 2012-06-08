{spawn} = require 'child_process'
{readdir} = require 'fs'

log = (data) -> console.log data.toString()
error = (data) -> console.error data.toString()

task 'lint', 'Coffeelint sources', ->

  lint = spawn 'node_modules/coffeelint/bin/coffeelint', ['-r', 'lib']
  lint.stdout.on 'data', log
  lint.stderr.on 'data', error
