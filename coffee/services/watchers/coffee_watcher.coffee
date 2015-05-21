app.factory 'CoffeeWatcher', ['Glob', 'Watch', 'Coffee', 'File', 'Fs', 'FileWriter', (glob, watcher, coffee, File, fs, writer) ->
  # A watcher is a class that watches a directory for certain files and runs
  # the compile action on every file-change.
  class CoffeeWatcher
    constructor: (onChanged) ->
      @folder    = null
      @error     = null
      @onChanged = onChanged

    handleError: (err) ->
      @error(err) unless @error is null

    onFileChanged: (sourcefile) ->
      outfile = sourcefile.replace(/coffee/g, 'js')
      fs.readFile sourcefile, (err, data) =>
        return @handleError(err) if err
        @compile data.toString(),
          generatedFile: outfile
          bare: false
          header: false
          filename: sourcefile
          #sourceFiles: [@folder]

    compile: (data, options) ->
      try
        js = coffee.compile(data, options)
        writer [
          { file: new File(options.generatedFile, @folder), buffer: new Buffer(js) }
        ], (err) =>
          @handleError(err)
      catch err then @handleError(err)

    # Watches for all coffee files inside a folder. Calls @onChanged with
    # file list.
    watch: (folder, err) ->
      @folder = folder
      @error  = err
      glob "#{folder}/**/*.coffee", (err, files) =>
        return @handleError(err) if err
        watcher files, $.proxy(@onFileChanged, @)
        @onChanged (new File(f, @folder) for f in files)
]
