# ----------------------------------------------------------
# AngularC1circleCheckListController
# ----------------------------------------------------------
@comiguideApp.controller 'C1circlesCtrl',
['$scope', '$attrs', '$http','C1circle',
  ($scope, $attrs, $http, C1circle) ->
    $scope.comic1_id = $attrs.comic1Id
    $scope.c1circles = []
    $scope.c1circleCurrentPages = 0
    $scope.c1circleTotalPages = 0
    $scope.c1circleTotalCount = 0

    $http.get("/comic1s/#{$scope.comic1_id}/c1circles.json").success (data) ->
      $scope.c1circleCurrentPages = data.current_page
      $scope.c1circleTotalCount = data.total_count
      angular.forEach data.c1circles, (v, k) ->
        $scope.c1circles.push new C1circle(v)

    $scope.pageChanged = ->
      url = "/comic1s/#{$scope.comic1_id}/c1circles.json"
      config =
        params:
          page: $scope.c1circleCurrentPages
      $http.get(url, config).success (data) ->
        $scope.c1circles = []
        angular.forEach data.c1circles, (v, k) ->
          $scope.c1circles.push new C1circle(v)
]
