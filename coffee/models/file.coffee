app.factory 'File', ->
  class File
    constructor: (fullPath, cwd) ->
      @fullpath  = fullPath

      parts      = fullPath.split('/')
      @filename  = parts.pop()
      @dirname   = parts.join('/')
      @extension = @filename.substr(@filename.indexOf('.') + 1)

      @relativepath = if cwd
        fullPath.replace(cwd + '/', '')
      else
        fullPath
