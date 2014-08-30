# ----------------------------------------------------------
# AdminNotificationsCtrl
# ----------------------------------------------------------
@comiguideApp.controller 'AdminNotificationsCtrl',
  ['$scope', '$attrs', '$http', 'Notification', 'ErrorNotify', 'SuccessNotify',
    ($scope, $attrs, $http, Notification, ErrorNotify, SuccessNotify) ->
      $scope.notifications = []
      $scope.new_notification = new Notification()

      $http.get('/admin/notifications.json').success (data) ->
        $scope.notifications = data.notifications

      $scope.createNotification = (notification) ->
        notification.create()
        .success (data, status, headers, config) ->
          notification.initAttributes()
          $scope.notifications.unshift(new Notification(data.notification))
          new SuccessNotify('お知らせを作成しました。', data.notification.title)
        .error (data, status, headers, config) ->
          new ErrorNotify('お知らせの作成に失敗しました。', data, status)
  ]
