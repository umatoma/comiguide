# ----------------------------------------------------------
# AngularC1circleCheckListController
# ----------------------------------------------------------
@comiguideApp.controller 'C1circleChecklistsCtrl',
['$scope', '$attrs', '$http', 'C1circleChecklist', 'C1circle', 'ErrorNotify', 'SuccessNotify',
  ($scope, $attrs, $http, C1circleChecklist, C1circle, ErrorNotify, SuccessNotify) ->
    $scope.comic1_id = $attrs.comic1Id
    $scope.list_order = "-id"
    $scope.create_form_active = false
    $scope.c1circle_checklists = []
    $scope.c1circles = []

    $http.get("/comic1s/#{$scope.comic1_id}/c1circles.json").success (data) ->
      angular.forEach data.c1circles, (v, k) ->
        $scope.c1circles.push new C1circle(v)

    $http.get("/comic1s/#{$scope.comic1_id}/c1circle_checklists.json").success (data) ->
      $scope.new_c1circle_checklist = new C1circleChecklist(data.new_c1circle_checklist)
      angular.forEach data.c1circle_checklists, (v, k) ->
        $scope.c1circle_checklists.push new C1circleChecklist(v)

    $scope.setListOrder = (order) ->
      $scope.list_order = order

    $scope.reloadCheckLists = ->
      $http.get("/comic1s/#{$scope.comic1_id}/c1circle_checklists.json").success (data) ->
        $scope.c1circle_checklists = []
        angular.forEach data.c1circle_checklists, (v, k) ->
          $scope.c1circle_checklists.push new C1circleChecklist(v)
        new SuccessNotify("リストをリロードしました。")

    $scope.createCheckList = (checklist) ->
      checklist.create()
      .success (data, status, headers, config) ->
        new_checklist = new C1circleChecklist(data.c1circle_checklist)
        $scope.c1circle_checklists.push(new_checklist)
        $scope.new_c1circle_checklist.initAttributes()
        new SuccessNotify('リストを追加しました。', new_checklist.fullInfo())
      .error (data, status, headers, config) ->
        new ErrorNotify('リストの追加に失敗しました。', data, status)

    $scope.updateCheckList = (checklist) ->
      checklist.updateAll()
      .success (data, status, headers, config) ->
        checklist.form.update = false
        new SuccessNotify('リストを更新しました。', checklist.fullInfo())
      .error (data, status, headers, config) ->
        new ErrorNotify('リストの更新に失敗しました。', data, status)

    $scope.destroyCheckList = (checklist) ->
      checklist.destroy()
      .success (data, status, headers, config) ->
        index = $scope.c1circle_checklists.indexOf(checklist)
        $scope.c1circle_checklists.splice(index, 1)
        new SuccessNotify('リストを削除しました。', checklist.fullInfo())
      .error (data, status, headers, config) ->
        new ErrorNotify('リストの削除に失敗しました。', data, status)

    $scope.toggleCreateFormActive = ->
      $scope.create_form_active = !$scope.create_form_active
  ]
