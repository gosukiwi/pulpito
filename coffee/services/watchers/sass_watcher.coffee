app.factory 'SassWatcher', ['Glob', 'Watch', 'Sass', 'FileWriter', (glob, watcher, sass, writer) ->
  # A watcher is a class that watches a directory for certain files and runs
  # the compile action on every file-change.
  class SassWatcher
    constructor: ->
      @folder = null
      @error  = null

    handleError: (err) ->
      @error(err) unless @error is null

    onFileChanged: (sassfile) ->
      outfile = new File sassfile.replace(/(sass|scss)/g, 'css'), @folder
      sass.render
        file: sassfile
        includePaths: [@folder]
        outputStyle: 'nested'
        outFile: outfile.fullpath
        sourceMap: true
      , (err, result) =>
        return @handleError(err) if err
        @writeFiles outfile, result

    writeFiles: (outfile, result) ->
        mapfile = new File(outfile.fullpath + ".map")
        writer [
          { file: outfile, buffer: result.css },
          { file: mapfile, buffer: result.map }
        ], (err) =>
          @handleError(err)

    watch: (folder, err) ->
      @folder = folder
      @error  = err
      glob "#{folder}/**/*.@(sass|scss)", (err, files) =>
        return @handleError(err) if err
        watcher files, $.proxy(@onFileChanged, @)

  new SassWatcher()
]
