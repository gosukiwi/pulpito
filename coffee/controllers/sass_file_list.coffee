app.controller 'SassFileListCtrl', ['$scope', 'File', 'Glob', 'Watch', 'Sass', 'FileWriter', ($scope, File, glob, watcher, sass, writer) ->
  $scope.files = []

  handleError = (err) ->
    console.log 'Error:', err

  onSassFileChanged = (sassfile) ->
    outfile = new File sassfile.replace(/(sass|scss)/g, 'css'), $scope.folder
    sass.render
      file: sassfile
      includePaths: [$scope.folder]
      outputStyle: 'nested'
      outFile: outfile.fullpath
      sourceMap: true
    , (err, result) ->
      return handleError(err) if err
      mapfile = new File(outfile.fullpath + ".map")
      writer [
        { file: outfile, buffer: result.css },
        { file: mapfile, buffer: result.map }
      ], (err) ->
        handleError(err) if err

  $scope.$watch 'folder', (folder) ->
    glob "#{folder}/**/*.sass", (er, files) ->
      # Save files in scope
      $scope.files = (new File(f, folder) for f in files)
      $scope.$apply()
      # Watch folder files to compile
      watcher(files, onSassFileChanged)
]
