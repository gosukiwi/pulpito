app.controller 'SassFileListCtrl', ['$scope', 'File', ($scope, File) ->
  $scope.files = []

  $scope.$watch 'folder', (folder) ->
    glob "#{folder}/**/*.@(sass|scss)", (er, files) =>
      # Save files in scope
      $scope.files = (new File(f, folder) for f in files)
      $scope.$apply()
]
