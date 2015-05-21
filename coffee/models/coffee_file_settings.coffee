app.factory 'CoffeeFileSettings', ->
  class CoffeeFileSettings
    constructor: (file, cwd) ->
      @outfile     = new File file.fullpath.replace(/coffee/g, 'js'), cwd
      @sourceMap   = true
