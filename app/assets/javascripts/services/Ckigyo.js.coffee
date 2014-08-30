@comiguideApp.factory 'Ckigyo', ($http) ->
  class Ckigyo
    constructor: (attr) ->
      self = @
      angular.forEach attr, (v, k) ->
        self[k] = v
