# ----------------------------------------------------------
# AngularUserMypageController
# ----------------------------------------------------------
@comiguideApp.controller 'UsersMypageCtrl',
['$scope', '$attrs', '$http', 'User', 'CcircleChecklist', 'C1circleChecklist', 'Notification',
  ($scope, $attrs, $http, User, CcircleChecklist, C1circleChecklist, Notification) ->
    $scope.comiket_id = $attrs.comiketId
    $scope.ccircle_checklists = []
    $scope.c1circle_checklists = []
    $scope.notifications = []

    $http.get('/users/mypage.json').success (data) ->
      $scope.user = new User(data.user)
      $scope.ckigyo_checklists = data.ckigyo_checklists

      angular.forEach data.notifications, (v, k) ->
        $scope.notifications.push new Notification(v)

      angular.forEach data.ccircle_checklists, (v, k) ->
        $scope.ccircle_checklists.push new CcircleChecklist(v)

      angular.forEach data.c1circle_checklists, (v, k) ->
        $scope.c1circle_checklists.push new C1circleChecklist(v)

    $http.get("/comikets/#{$scope.comiket_id}/ckigyos/ranking.json", params: { limit: 5 }).success (data) ->
      $scope.ckigyos = data.ckigyos
]
