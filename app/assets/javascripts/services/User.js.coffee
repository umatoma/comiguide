@comiguideApp.factory 'User', ($http) ->
  class User
    constructor: (attr) ->
      self = @
      angular.forEach attr, (v, k) ->
        self[k] = v
