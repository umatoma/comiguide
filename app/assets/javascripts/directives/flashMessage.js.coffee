@comiguideApp.directive 'flashMessage',
['$window', ($window) ->
  restrict: 'E'
  scope:
    message: '@'
    type: '@'
  link: (scope) ->
    scope.notify = (title, type) ->
      new PNotify
        title: title
        text: scope.message
        type: type
        hide: false
        animation: 'slide'

    switch scope.type
      when 'alert'
        scope.notify('Error', 'error')
      when 'notice'
        scope.notify('Info', 'info')
]
