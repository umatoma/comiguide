@comiguideApp.factory 'SuccessNotify', ->
  class SuccessNotify
    constructor: (title, text = false) ->
      @createSuccessNofity(title, text)

    createSuccessNofity: (title, text = false) ->
      new PNotify
        title: title
        text: text
        width: '350px'
        type: 'success'
        delay: 2000
