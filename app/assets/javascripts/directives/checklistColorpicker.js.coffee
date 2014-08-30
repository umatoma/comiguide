@comiguideApp.directive 'checklistColorpicker', ->
  restrict: 'E'
  require: 'ngModel'
  replace: true
  templateUrl: '/templates/checklist_colorpicker'
  link: (scope, element, attrs, ngModel) ->
    scope.colors = ['black', 'gray', 'red', 'green', 'blue', 'yellow', 'orange']
    scope.color = ngModel.$viewValue

    scope.$watch ->
      ngModel.$viewValue
    , (newColor, oldColor) ->
      scope.color = newColor

    scope.isSelected = (color) ->
      scope.color == color

    scope.setColor = (color) ->
      scope.color = color
      ngModel.$setViewValue(color)
