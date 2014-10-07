# ----------------------------------------------------------
# NotificationsController
# ----------------------------------------------------------
@comiguideApp.controller 'NotificationsCtrl',
['$scope', '$http','Notification',
  ($scope, $http, Notification) ->
    $scope.notifications = []
    $scope.notificationCurrentPages = 0
    $scope.notificationTotalPages = 0
    $scope.notificationTotalCount = 0

    $http.get("/notifications.json").success (data) ->
      $scope.notificationCurrentPages = data.current_page
      $scope.notificationTotalCount = data.total_count
      angular.forEach data.notifications, (v, k) ->
        $scope.notifications.push new Notification(v)

    $scope.pageChanged = ->
      url = "notifications.json"
      config =
        params:
          page: $scope.notificationCurrentPages
      $http.get(url, config).success (data) ->
        $scope.notifications = []
        angular.forEach data.notifications, (v, k) ->
          $scope.notifications.push new Notification(v)
]
