# ----------------------------------------------------------
# AngularC1circleSearchController
# ----------------------------------------------------------
@comiguideApp.controller 'C1circleSearchCtrl',
['$scope', '$rootScope',
  ($scope, $rootScope) ->
    $scope.searchKeyword = null
    $scope.doSearch = ->
      params =
        name: $scope.searchKeyword
        kana: $scope.searchKeyword
      $rootScope.$broadcast('doC1circleSearch', params)
]
