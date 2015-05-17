app.controller 'MainCtrl', ['$scope', ($scope) ->
  $scope.folder = null

  $scope.setFolder = (path) ->
    $scope.folder = path.replace(/\\/g, '/')
    $scope.$apply()
]
