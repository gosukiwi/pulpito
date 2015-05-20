app.controller 'FileListCtrl', ['$scope', 'SassWatcher', ($scope, SassWatcher) ->
  $scope.files    = []
  sassWatcher     = null
  fileListChanged = (files) ->
    $scope.files.push(f) for f in files
    $scope.$apply()

  initialize = ->
    sassWatcher = new SassWatcher(fileListChanged)
  initialize()

  $scope.$watch 'folder', (folder) ->
    sassWatcher.watch folder if folder
]
