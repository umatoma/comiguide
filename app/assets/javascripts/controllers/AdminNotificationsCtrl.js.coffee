# ----------------------------------------------------------
# AdminNotificationsCtrl
# ----------------------------------------------------------
@comiguideApp.controller 'AdminNotificationsCtrl',
['$scope', '$attrs', '$http', 'Notification', 'ErrorNotify', 'SuccessNotify',
  ($scope, $attrs, $http, Notification, ErrorNotify, SuccessNotify) ->
    $scope.notifications = []
    $scope.new_notification = new Notification()

    $http.get('/admin/notifications.json').success (data) ->
      angular.forEach data.notifications, (v, k) ->
        $scope.notifications.push new Notification(v)

    $scope.createNotification = (notification) ->
      notification.create()
      .success (data, status, headers, config) ->
        notification.initAttributes()
        $scope.notifications.unshift(new Notification(data.notification))
        new SuccessNotify('お知らせを作成しました。', data.notification.title)
      .error (data, status, headers, config) ->
        new ErrorNotify('お知らせの作成に失敗しました。', data, status)

    $scope.updateNotification = (notification) ->
      notification.updateAll()
      .success (data, status, headers, config) ->
        notification.updateFormActive = false
        new SuccessNotify('お知らせを更新しました。', notification.title)
      .error (data, status, headers, config) ->
        new ErrorNotify('お知らせの更新に失敗しました。', data, status)

    $scope.destroyNotification = (notification) ->
      notification.destroy()
      .success (data, status, headers, config) ->
        index = $scope.notifications.indexOf(notification)
        $scope.notifications.splice(index, 1)
        new SuccessNotify('リストを削除しました。', notification.title)
      .error (data, status, headers, config) ->
        new ErrorNotify('リストの削除に失敗しました。', data, status)
]
