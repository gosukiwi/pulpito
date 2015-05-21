app.factory 'File', ['SassFileSettings', 'CoffeeFileSettings', (SassFileSettings, CoffeeFileSettings) ->
  class File
    constructor: (fullPath, cwd) ->
      @fullpath  = fullPath

      parts      = fullPath.split('/')
      @filename  = parts.pop()
      @dirname   = parts.join('/')
      @extension = @filename.substr(@filename.indexOf('.') + 1).toLowerCase()

      @relativepath = if cwd
        fullPath.replace(cwd + '/', '')
      else
        fullPath

      # Set up the appropriate settings for this file
      settings =
        sass:   SassFileSettings
        coffee: CoffeeFileSettings
      @settings = new settings[@extension](@, cwd)
]
