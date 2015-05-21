app.controller 'FileListCtrl', ['$scope', 'SassWatcher', 'CoffeeWatcher', ($scope, SassWatcher, CoffeeWatcher) ->
  $scope.files       = []
  $scope.currentFile = null

  sassWatcher        = null
  coffeeWatcher      = null

  onFileWatched = (files) ->
    $scope.files.push(f) for f in files
    $scope.$apply()

  initialize = ->
    sassWatcher = new SassWatcher(onFileWatched)
    coffeeWatcher = new CoffeeWatcher(onFileWatched)
  initialize()

  $scope.$watch 'folder', (folder) ->
    return unless folder
    sassWatcher.watch folder
    coffeeWatcher.watch folder

  $scope.setCurrentFile = (file) ->
    $scope.currentFile = file
]
