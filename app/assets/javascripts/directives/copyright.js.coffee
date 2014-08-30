@comiguideApp.directive 'copyright', ->
  restrict: 'E'
  replace: true
  scope:
    name: '@'
    url: '@'
  template: '<p class="text-center">Copyright &copy; {{ year }} <a href="{{ url }}" target="_blank">{{ name }}</a>. All Rights Reserved.</p>'
  link: ($scope) ->
    $scope.year = new Date().getFullYear()
