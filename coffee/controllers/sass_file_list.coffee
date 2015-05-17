app.controller 'SassFileListCtrl', ['$scope', 'File', 'Glob', 'Watch', 'Sass', 'Fs', ($scope, File, glob, watcher, sass, fs) ->
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
      fs.mkdir outfile.dirname, '0777', (err, res) ->
        return handleError(err) if err && err.code != 'EEXIST'
        fs.writeFile outfile.fullpath, result.css, 0, result.css.length
        fs.writeFile outfile.fullpath + '.map', result.map, 0, result.map.length

  $scope.$watch 'folder', (folder) ->
    glob "#{folder}/**/*.sass", (er, files) ->
      # Save files in scope
      $scope.files = (new File(f, folder) for f in files)
      $scope.$apply()
      # Watch folder files to compile
      watcher(files, onSassFileChanged)
]
