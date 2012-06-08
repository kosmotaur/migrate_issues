Deferred = require("./deferred").Deferred
https = require "https"
url = require "url"
request = require "request"
fs = require "fs"

exports.YouTrackConnector =
  class YouTrackConnector

    constructor : (@config) ->
      @d = new Deferred

      request.post(
        @config.url + "/rest/user/login?login=" + @config.auth.user + "&password=" + @config.auth.pass,
        (err, res, body) =>
          @cookie = res.headers["set-cookie"]
          @d.resolve()
      )

      @d

    importIssues: (issueSet) ->
      d = new Deferred

      @d.then =>
        reqOptions = {}
        reqOptions.url = url.parse @config.url + "/rest/import/" + @config.project + "/issues" + (if @config.test then "?test=true" else "")
        reqOptions.method = "PUT"
        reqOptions.body = issueSet.toYouTrack()
        reqOptions.headers = {}
        reqOptions.headers["Cookie"] = @cookie.join(";")
        reqOptions.headers["Content-Type"] = "application/xml"
        reqOptions.headers["Content-Length"] = reqOptions.body.length

        request(reqOptions, (err, res, body) =>
          d.resolve(body)
        )

      d