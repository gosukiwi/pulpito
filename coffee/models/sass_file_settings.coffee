app.factory 'SassFileSettings', ->
  class SassFileSettings
    constructor: (file, cwd) ->
      @outfile     = new File file.fullpath.replace(/(sass|css)/g, 'css'), cwd
      @outputStyle = 'nested'
      @sourceMap   = true
