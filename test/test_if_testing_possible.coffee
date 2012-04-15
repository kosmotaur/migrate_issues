suite = exports;

suite["Test if testing possible"] =
  "test expect one assertion": (test) ->
    test.expect 1
    test.ok true
    test.done()