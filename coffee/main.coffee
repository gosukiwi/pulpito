app = angular.module 'openreload', ['ngRoute']
app.config ($routeProvider) ->
  $routeProvider
    .when('/sass',
      templateUrl: 'templates/sass_file_list.html'
      controller:  'SassFileListCtrl'
    )
    .when('/coffee',
      templateUrl: 'templates/coffee_file_list.html'
      controller:  'CoffeeFileListCtrl'
    )
window.app = app
