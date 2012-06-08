fs = require("fs")
d = require("./lib/migrate_issues").migrateIssues()
d.then (res) ->
  fs.createWriteStream("youtrack_response.xml").write(res)
  console.info "done, youtrack response written to youtrack_response.xml"