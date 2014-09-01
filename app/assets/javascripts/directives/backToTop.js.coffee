@comiguideApp.directive 'backToTop',
['$window', ($window) ->
  restrict: 'E'
  replace: true
  template: '<div class="back-to-top" back-to-top><i class="fa fa-chevron-up fa-2x"></i></div>'
  link: (scope, element) ->
    body = angular.element('body')
    angular.element($window).scroll ->
      if $(this).scrollTop() > body.height() * 0.5
        element.fadeIn()
      else
        element.fadeOut()

    element.bind 'click', ->
      angular.element('body').animate
        scrollTop: 0
      , 'slow'
      false
]
