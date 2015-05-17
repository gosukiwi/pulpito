app.controller 'SassFileListCtrl', ['$scope', 'File', ($scope, File) ->
  glob = require('glob')

  $scope.files = []

  $scope.$watch 'folder', (folder) ->
    glob "#{folder}/**/*.sass", (er, files) ->
      $scope.files = (new File(f, folder) for f in files)
      $scope.$apply()
]
