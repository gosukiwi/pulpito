app.controller 'MainCtrl', ['$scope', 'SassWatcher', ($scope, sassWatcher) ->
  $scope.folder = null

  setUpWatchers = (folder) ->
    sassWatcher.watch folder

  $scope.setFolder = (path) ->
    $scope.folder = path.replace(/\\/g, '/')
    $scope.$apply()
    setUpWatchers($scope.folder)
]
