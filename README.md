Migrate issues between GitHub Issues and YouTrack

Package currently supports only GitHub API v3 -> YouTrack 3.x issues migration.
Before using, copy config/config.coffee.template to config/config.coffee, fill in credentials, repo names, URL of your YouTrack installation. If needed, edit mapping functions to convert field values of issues to desired format.

To use from command line, do `coffee index.coffee`. You will get the result report written to `youtrack_response.xml`. Please leave test flag in the config file set to true at first, to see if everything goes smooth. You can avoid messing up your YouTrack issues this way. If you get an error-free report XML, you can change it to false to do the actual import.

To use programmatically, `mi = require "lib/migrate_issues"`, then you can `mi.migrateIssues()`. It returns a [jQuery Deferred](http://api.jquery.com/category/deferred-object/) object. Use its `then` method to attach callbacks. They will be called with YouTracks response XML string.

(The MIT License)

Copyright (c) 2012 Marek Stasikowski <marek.stasikowski@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.