app.factory 'File', ->
  class File
    constructor: (fullPath, cwd) ->
      @fullPath = fullPath
      @fileName = fullPath.split('/').pop()
      @relativePath = if cwd
        fullPath.replace(cwd + '/', '')
      else
        fullPath
