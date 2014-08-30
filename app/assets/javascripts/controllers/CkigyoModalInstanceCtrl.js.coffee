@comiguideApp.controller 'CkigyoModalInstanceCtrl',
  ['$scope', '$modalInstance', 'ckigyo_id', '$http',
    ($scope, $modalInstance, ckigyo_id, $http) ->
      $http.get("/ckigyos/#{ckigyo_id}.json").success (data) ->
        $scope.initParams(data)

      $scope.initParams = (data) ->
        $scope.ckigyo = data.ckigyo
        $scope.prev_ckigyo = data.prev_ckigyo
        $scope.next_ckigyo = data.next_ckigyo
        $scope.ckigyo_checklists = data.ckigyo_checklists

      $scope.showPrevCkigyo = ->
        $http.get("/ckigyos/#{$scope.prev_ckigyo.id}.json").success (data) ->
          $scope.initParams(data)

      $scope.showNextCkigyo = ->
        $http.get("/ckigyos/#{$scope.next_ckigyo.id}.json").success (data) ->
          $scope.initParams(data)

      $scope.hasPrevCkigyo = ->
        $scope.prev_ckigyo && $scope.prev_ckigyo.id

      $scope.hasNextCkigyo = ->
        $scope.next_ckigyo && $scope.next_ckigyo.id

      $scope.close = ->
        $modalInstance.close()
  ]
