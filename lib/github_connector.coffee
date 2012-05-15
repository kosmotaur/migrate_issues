Deferred = require("./deferred").Deferred
https = require "https"
url = require "url"
_ = require("underscore")

exports.GitHubConnector =
  class GitHubConnector

    constructor : (@config) ->
      @d = new Deferred
      @promise = @d.promise()

      @issues = []
      @requestOptions =
        host  : "api.github.com"
        path  : "/repos/" + config.repo.user + "/" + config.repo.name + "/issues"
        auth  : config.auth.user + ":" + config.auth.pass
        query : {}
      @requestIssues()

    requestIssues : ->
      resBody = ""
      req = https.request @requestOptions, (res) =>
        res.on "data", (chunk) -> resBody += chunk
        res.on "end", =>
          @issues = @issues.concat JSON.parse resBody
          rest = res.headers.link.split(",").reduce ((memo, el) ->
            split = el.split(";")
            split[0] = split[0].trim().replace(/(^<|>$)/g, "")
            split[1] = split[1].trim().replace(/(^rel="|"$)/g, "")
            memo[split[1]] = split[0]
            memo
          ), {}
          if rest and rest.next
            _(@requestOptions).extend(url.parse rest.next)
            @requestIssues()
          else

            @d.resolve(@issues)
      req.end()