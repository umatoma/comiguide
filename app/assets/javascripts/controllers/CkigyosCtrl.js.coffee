# ----------------------------------------------------------
# AngularCkigyosController
# ----------------------------------------------------------
@comiguideApp.controller 'CkigyosCtrl',
['$scope', '$attrs', '$http', '$rootScope', 'Ckigyo',
  ($scope, $attrs, $http, $rootScope, Ckigyo) ->
    $scope.comiket_id = $attrs.comiketId
    $scope.list_order = 'kigyo_no'
    $scope.list_active = true

    $http.get("/comikets/#{$scope.comiket_id}/ckigyos.json").success (data) ->
      $scope.ckigyos = []
      angular.forEach data.ckigyos, (v, k) ->
        $scope.ckigyos.push new Ckigyo(v)

    $scope.toggleListActive = ->
      $scope.list_active = !$scope.list_active

    $scope.createCheckList = (ckigyo) ->
      $rootScope.$broadcast('showCkigyoChecklistForm', ckigyo)
]
