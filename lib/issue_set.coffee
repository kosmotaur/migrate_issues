#currently handles only common format -> youtrack
libxml = require "libxmljs"
exports.IssueSet =
class IssueSet
  constructor: (@issues) ->
  toYouTrack: ->
    doc = new libxml.Document

    root = doc.node "issues"
    @issues.forEach (issue) ->
      issueNode = root.node("issue")
        .node("field").attr(name: "numberInProject")
          .node("value", "" + issue.number).parent().parent()
        .node("field").attr(name : "summary")
          .node("value", "" + issue.summary).parent().parent()
        .node("field").attr(name : "description")
          .node("value", "" + issue.description).parent().parent()
        .node("field").attr(name : "created")
          .node("value", "" + issue.created).parent().parent()
        .node("field").attr(name : "updated")
          .node("value", "" + issue.updated).parent().parent()
        .node("field").attr(name : "reporterName")
          .node("value", "" + issue.reporter).parent().parent()

      if issue.resolved
        issueNode.node("field").attr(name : "resolved")
          .node("value", "" + issue.resolved).parent().parent()

      issue.comments.forEach (comment) ->
        issueNode.node("comment").attr(
          author  : comment.author
          text    : comment.text
          created : comment.created
          updated : comment.updated
        )

    doc.toString()