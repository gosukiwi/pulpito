app = angular.module 'openreload', ['ngRoute']
app.config ($routeProvider) ->
  $routeProvider
    .when('/todo',
      templateUrl: 'templates/some_tpl.html'
      controller:  'Something'
    )
window.app = app
