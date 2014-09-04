@comiguideApp.factory 'C1circleChecklist',
['$rootScope', '$http', ($rootScope, $http) ->
  class C1circleChecklist
    constructor: (attr) ->
      self = @
      this.comic1_id = null
      this.c1block_id = null
      this.c1layout_id = null
      this.space_no_sub = 0
      this.circle_name = null
      this.circle_url = null
      this.comment = null
      this.cost = null
      this.color = 'black'
      this.rank = null
      this.updated_at = null
      this.created_at = null

      this.c1blocks = []
      this.c1layouts = []
      this.space_no_subs = [
        { key: 0, value: 'a' },
        { key: 1, value: 'b' }
      ]

      angular.forEach attr, (v, k) ->
        self[k] = v

      $rootScope.$watch ->
        self.c1block_id
      , (newValue, oldValue) ->
        if newValue != null && newValue != oldValue
          self.updateC1layouts()

    create: ->
      data =
        c1circle_checklist:
          comic1_id: this.comic1_id
          c1layout_id: this.c1layout_id
          space_no_sub: this.space_no_sub
          circle_name: this.circle_name
          circle_url: this.circle_url
          comment: this.comment
          cost: this.cost
          color: this.color
      $http.post("/c1circle_checklists.json", data)

    update: (data) ->
      $http.put("/c1circle_checklists/#{this.id}.json", data)

    updateAll: ->
      data =
        c1circle_checklist:
          c1layout_id: this.c1layout_id
          space_no_sub: this.space_no_sub
          circle_name: this.circle_name
          circle_url: this.circle_url
          comment: this.comment
          cost: this.cost
          color: this.color
      this.update(data)

    destroy: ->
      $http.delete("/c1circle_checklists/#{this.id}.json")

    initAttributes: ->
      this.c1block_id = this.c1blocks[0].id
      this.space_no_sub = 0
      this.circle_name = null
      this.circle_url = null
      this.comment = null
      this.cost = null
      this.color = 'black'
      this.rank = null
      this.updated_at = null
      this.created_at = null

    updateC1layouts: ->
      self = @
      url = "/c1blocks/#{self.c1block_id}/c1layouts.json"
      $http.get(url, { cache: true }).success (data) ->
        self.c1layout_id = data.c1layouts[0].id
        self.c1layouts = data.c1layouts

    spaceNoSubName: ->
      self = @
      (self.space_no_subs.filter (x) -> x.key == self.space_no_sub)[0].value

    fullInfo:->
      self = @
      c1block = (self.c1blocks.filter (x) -> x.id == self.c1block_id)[0]
      c1layout = (self.c1layouts.filter (x) -> x.id == self.c1layout_id)[0]
      if c1block && c1layout
        "#{c1block.name} - #{c1layout.space_no}#{self.spaceNoSubName()} #{self.circle_name}"
      else
        null
]
