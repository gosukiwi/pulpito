app.factory 'SassWatcher', ['Glob', 'Watch', 'Sass', 'FileWriter', 'File', (glob, watcher, sass, writer, File) ->
  # A watcher is a class that watches a directory for certain files and runs
  # the compile action on every file-change.
  class SassWatcher
    constructor: (onChanged) ->
      @folder    = null
      @error     = null
      @onChanged = onChanged

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

    # Watches for all sass files inside a folder. Calls @onChanged with
    # file list.
    watch: (folder, err) ->
      @folder = folder
      @error  = err
      glob "#{folder}/**/*.@(sass|scss)", (err, files) =>
        return @handleError(err) if err
        watcher files, $.proxy(@onFileChanged, @)
        @onChanged (new File(f, @folder) for f in files)
]
