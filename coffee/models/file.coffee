app.factory 'File', ->
  class File
    constructor: (fullPath, cwd) ->
      @fullpath = fullPath

      parts = fullPath.split('/')
      @filename = parts.pop()
      @dirname  = parts.join('/')

      @relativepath = if cwd
        fullPath.replace(cwd + '/', '')
      else
        fullPath
