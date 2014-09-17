@comiguideApp.factory 'Notification',
['$http',
  ($http) ->
    class Notification
      constructor: (attr = {}) ->
        self = @
        self.status_options = [
          { key: 1, value: 'Publish' },
          { key: 2, value: 'Draft' },
          { key: 3, value: 'Close' }
        ]
        self.status = 1

        angular.forEach attr, (v, k) ->
          self[k] = v

      create: ->
        data =
          notification:
            title: this.title
            content: this.content
            status: this.status
        $http.post("/admin/notifications.json", data)

      update: (data) ->
        $http.put("/admin/notifications/#{this.id}.json", data)

      updateAll: ->
        data =
          notification:
            title: this.title
            content: this.content
            status: this.status
        this.update(data)

      destroy: ->
        $http.delete("/admin/notifications/#{this.id}.json")

      initAttributes: ->
        this.title = null
        this.content = null
        this.status = 1

      statusName: ->
        (@status_options.filter (x) => x.key == @status)[0].value
]
