@comiguideApp.directive 'ckigyoModal',
  ['$modal',
    ($modal) ->
      restrict: 'A'
      link: (scope, element, attr) ->
        element.on 'click', ->
          $modal.open
            templateUrl: '/ckigyos/show_modal_template'
            controller: 'CkigyoModalInstanceCtrl'
            resolve:
              ckigyo_id: ->
                attr.ckigyoId
  ]
