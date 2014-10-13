@comiguideApp.controller 'HomeIndexCtrl',
['$scope', '$http',
  ($scope, $http) ->
    $http.get("/", { params: { format: 'json' } }).success (data) ->
      $scope.usersCount = data.users_count
      $scope.ccircleChecklistsCount = data.ccircle_checklists_count
      $scope.ckigyoChecklistsCount = data.ckigyo_checklists_count
      $scope.c1circleChecklistsCount = data.c1circle_checklists_count
      console.log(data)
]
