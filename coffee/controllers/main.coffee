app.controller 'MainCtrl', ['$scope',  ($scope) ->
  $scope.folders       = []
  $scope.currentFolder = null

  $scope.selectFolder = (folder) ->
    $scope.currentFolder = folder

  $scope.addFolder = (path) ->
    $scope.folders.push path.replace(/\\/g, '/')
    $scope.$apply()
]
