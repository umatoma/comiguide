# ----------------------------------------------------------
# UsersController
# ----------------------------------------------------------
@comiguideApp.controller 'AdminUsersCtrl',
['$scope', '$http','User',
  ($scope, $http, User) ->
    $scope.users = []
    $scope.userCurrentPages = 0
    $scope.userTotalPages = 0
    $scope.userTotalCount = 0

    $http.get("/admin/users.json").success (data) ->
      $scope.userCurrentPages = data.current_page
      $scope.userTotalCount = data.total_count
      angular.forEach data.users, (v, k) ->
        $scope.users.push new User(v)

    $scope.pageChanged = ->
      config =
        params:
          page: $scope.userCurrentPages
      $http.get("/admin/users.json", config).success (data) ->
        $scope.users = []
        angular.forEach data.users, (v, k) ->
          $scope.users.push new User(v)
]
