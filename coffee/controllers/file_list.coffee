app.controller 'FileListCtrl', ['$scope', 'SassWatcher', ($scope, SassWatcher) ->
  $scope.files    = []
  sassWatcher     = null
  onFileWatched = (files) ->
    $scope.files.push(f) for f in files
    $scope.$apply()

  initialize = ->
    sassWatcher = new SassWatcher(onFileWatched)
  initialize()

  $scope.$watch 'folder', (folder) ->
    sassWatcher.watch folder if folder
]
