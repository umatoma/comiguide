# ----------------------------------------------------------
# AngularCcircleCheckListController
# ----------------------------------------------------------
@comiguideApp.controller 'CcircleChecklistsCtrl',
['$scope', '$attrs', '$http', 'CcircleChecklist', 'ErrorNotify', 'SuccessNotify',
  ($scope, $attrs, $http, CcircleChecklist, ErrorNotify, SuccessNotify) ->
    $scope.comiket_id = $attrs.comiketId
    $scope.list_order = "-id"
    $scope.create_form_active = false
    $scope.ccircle_checklists = []
    $scope.draw_map_line = true

    $http.get("/comikets/#{$scope.comiket_id}/ccircle_checklists.json").success (data) ->
      $scope.new_ccircle_checklist = new CcircleChecklist(data.new_ccircle_checklist)
      angular.forEach data.ccircle_checklists, (v, k) ->
        $scope.ccircle_checklists.push new CcircleChecklist(v)

    $scope.setListOrder = (order) ->
      $scope.list_order = order

    $scope.reloadCheckLists = ->
      $http.get("/comikets/#{$scope.comiket_id}/ccircle_checklists.json").success (data) ->
        $scope.ccircle_checklists = []
        angular.forEach data.ccircle_checklists, (v, k) ->
          $scope.ccircle_checklists.push new CcircleChecklist(v)
        new SuccessNotify("リストをリロードしました。")

    $scope.createCheckList = (checklist) ->
      checklist.create()
      .success (data, status, headers, config) ->
        $scope.ccircle_checklists.push(new CcircleChecklist(data.ccircle_checklist))
        $scope.new_ccircle_checklist.initAttributes()
        new SuccessNotify('リストを追加しました。', data.ccircle_checklist.circle_name)
      .error (data, status, headers, config) ->
        new ErrorNotify('リストの追加に失敗しました。', data, status)

    $scope.updateCheckList = (checklist) ->
      checklist.updateAll()
      .success (data, status, headers, config) ->
        checklist.form.update = false
        new SuccessNotify("リストを更新しました。", checklist.circle_name)
      .error (data, status, headers, config) ->
        new ErrorNotify("リストの更新に失敗しました。", data, status)

    $scope.destroyCheckList = (checklist) ->
      checklist.destroy()
      .success (data, status, headers, config) ->
        index = $scope.ccircle_checklists.indexOf(checklist)
        $scope.ccircle_checklists.splice(index, 1)
        new SuccessNotify("リストを削除しました。", checklist.circle_name)
      .error (data, status, headers, config) ->
        new ErrorNotify("リストの削除に失敗しました。", data, status)

    $scope.toggleCreateFormActive = ->
      $scope.create_form_active = !$scope.create_form_active

    $scope.createMapPath = (cmap_id, day) ->
      params = $.param(cmap_id: cmap_id, day: day, line: $scope.draw_map_line)
      "/comikets/#{$scope.comiket_id}/ccircle_checklists/create_map.pdf?#{params}"

]
