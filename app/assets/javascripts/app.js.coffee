# ----------------------------------------------------------
# AngularModule
# ----------------------------------------------------------
@comiguideApp = angular.module("ComiGuideApp", [
  'ngAnimate',
  'ngSanitize',
  'ui.bootstrap'
])

# ----------------------------------------------------------
# AppendCsrfToken
# ----------------------------------------------------------
@comiguideApp.config ['$httpProvider', ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
]
