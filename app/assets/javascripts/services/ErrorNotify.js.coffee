@comiguideApp.factory 'ErrorNotify', ->
  class ErrorNotify
    constructor: (title, data = false, status = false) ->
      if status == 422
        errors = angular.fromJson(data)
        error_message = ''
        angular.forEach errors, (v, k) ->
          error_message += "・#{v}<br>"

        @createErrorNofity(title, error_message)
      else
        @createErrorNofity(title)

    createErrorNofity: (title, text = false) ->
      new PNotify
        title: title
        text: text
        width: '350px'
        type: 'error'
        delay: 2000
