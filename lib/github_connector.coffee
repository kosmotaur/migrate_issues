Deferred = require("./deferred").Deferred
$ = require "jquery"
https = require "https"
url = require "url"
_ = require "underscore"
Issue = require("./issue").Issue
IssueSet = require "./issue_set"
fs = require "fs"

exports.GitHubConnector =
  class GitHubConnector

    constructor : (@config) ->
      @d = new Deferred

      Object.defineProperty @, "issues",
        get : => @d

      @requestsFinished = 0
      @githubIssues = []
      @requestBaseOptions =
        host    : "api.github.com"
        auth    : config.auth.user + ":" + config.auth.pass
        headers : {'User-Agent': 'migrate_issues'}
        query   : {}
      @requestIssuesOptions =
        _.extend(
          {},
          @requestBaseOptions,
          path : "/repos/" + @config.repo.user + "/" + @config.repo.name + "/issues"
        )
      @requestIssues().then (issues) =>
        if issues.length is 1 and issues[0].message
          throw new Error ("GitHub responded: " + issues[0].message)
        @githubIssues = issues
        @requestComments().then =>
          issues = @githubIssues.map (issue) => new Issue issue, "github", @config.mappings
          @issues = issues
          @d.resolve issues

    request : (reqOptions, onReqEnd) ->
      d = new Deferred

      resBody = ""
      req = https.request reqOptions, (res) =>
        res.on "data", (chunk) =>
          resBody += chunk
        res.on "end", =>
          @requestsFinished++
          onReqEnd resBody
          if res.headers.link
            rest = res.headers.link.split(",").reduce ((memo, el) ->
              split = el.split(";")
              split[0] = split[0].trim().replace(/(^<|>$)/g, "")
              split[1] = split[1].trim().replace(/(^rel="|"$)/g, "")
              memo[split[1]] = split[0]
              memo
            ), {}
          if rest and rest.next
            (@request (_.extend {}, reqOptions, url.parse rest.next), onReqEnd).then -> d.resolve()
          else
            d.resolve()
      req.end()

      d

    requestIssues : ->
      d = new Deferred

      issues = []
      (@request @requestIssuesOptions, (resBody) ->
        issues = issues.concat JSON.parse resBody).then -> d.resolve issues

      d

    readIssuesFromFile : ->
      d = new Deferred

      fs.readFile 'issues.json', (err, data) =>
        d.resolve JSON.parse data.toString()

      d

    requestComments : ->
      d = new Deferred

      $.when.apply(null, @githubIssues.map (issue, i) =>
        comments = []
        perIssueDeferred =
          @request(
            _.extend(
              {},
              @requestBaseOptions,
              url.parse "https://api.github.com/repos/#{@config.repo.user}/#{@config.repo.name}/issues/#{issue.number}/comments",
            ),
            (resBody) =>
              comments = comments.concat JSON.parse resBody
          ).then =>
            issue.comments = comments
            @githubIssues[i] = issue
      ).then ->
        d.resolve()

      d