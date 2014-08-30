# ----------------------------------------------------------
# AngularCkigyoCheckListController
# ----------------------------------------------------------
@comiguideApp.controller "CkigyoChecklistsCtrl",
['$scope', '$attrs', '$http', 'CkigyoChecklist', 'Ckigyo', 'ErrorNotify', 'SuccessNotify',
  ($scope, $attrs, $http, CkigyoChecklist, Ckigyo, ErrorNotify, SuccessNotify) ->
    $scope.comiket_id = $attrs.comiketId
    $scope.ckigyos = []
    $scope.ckigyo_checklists = []
    $scope.create_form_active = false
    $scope.list_order = "-id"

    $http.get("/comikets/#{$scope.comiket_id}/ckigyo_checklists.json").success (data) ->
      $scope.new_ckigyo_checklist = new CkigyoChecklist(data.new_ckigyo_checklist)
      angular.forEach data.ckigyo_checklists, (v, k) ->
        $scope.ckigyo_checklists.push new CkigyoChecklist(v)

    $http.get("/comikets/#{$scope.comiket_id}/ckigyos.json").success (data) ->
      angular.forEach data.ckigyos, (v, k) ->
        $scope.ckigyos.push new Ckigyo(v)

    $scope.$on "showCkigyoChecklistForm", (e, ckigyo) ->
      $scope.new_ckigyo_checklist.initAttributes(ckigyo.id)
      $scope.create_form_active = true
      offset = angular.element('.checklists-functions').offset()
      angular.element('body').animate { scrollTop: offset.top }, 'normal'

    $scope.setListOrder = (order) ->
      $scope.list_order = order

    $scope.toggleCreateFormActive = ->
      $scope.create_form_active = !$scope.create_form_active

    $scope.closeCreateForm = ->
      $scope.create_form_active = false

    $scope.reloadCheckLists = ->
      $http.get("/comikets/#{$scope.comiket_id}/ckigyo_checklists.json").success (data) ->
        $scope.ckigyo_checklists = []
        angular.forEach data.ckigyo_checklists, (v, k) ->
          $scope.ckigyo_checklists.push new CkigyoChecklist(v)
        new SuccessNotify("リストをリロードしました。")

    $scope.createCheckList = (checklist) ->
      checklist.create()
      .success (data, status, headers, config) ->
        $scope.new_ckigyo_checklist.initAttributes($scope.ckigyos[0].id)
        $scope.ckigyo_checklists.push(new CkigyoChecklist(data.ckigyo_checklist))
        $scope.closeCreateForm()
        new SuccessNotify("リストを追加しました。", data.ckigyo_checklist.ckigyo.full_info)
      .error (data, status, headers, config) ->
        new ErrorNotify("リストの追加に失敗しました。", data, status)

    $scope.updateCheckList = (checklist) ->
      checklist.updateAll()
      .success (data, status, headers, config) ->
        checklist.form.update = false
        new SuccessNotify("リストを更新しました。", checklist.ckigyo.full_info)
      .error (data, status, headers, config) ->
        new ErrorNotify("リストの更新に失敗しました。", data, status)

    $scope.destroyCheckList = (checklist) ->
      checklist.destroy()
      .success (data, status, headers, config) ->
        index = $scope.ckigyo_checklists.indexOf(checklist)
        $scope.ckigyo_checklists.splice(index, 1)
        new SuccessNotify("リストを削除しました。", checklist.ckigyo.full_info)
      .error (data, status, headers, config) ->
        new ErrorNotify("リストの削除に失敗しました。", data, status)
]
