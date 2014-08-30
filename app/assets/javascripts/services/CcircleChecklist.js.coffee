@comiguideApp.factory 'CcircleChecklist',
['$rootScope', '$http', ($rootScope, $http) ->
  class CcircleChecklist
    constructor: (attr) ->
      self = @
      this.careas = []
      this.cblocks = []
      this.clayouts = []
      this.carea_id = null
      this.cblock_id = null
      this.clayout_id = null
      this.day = 1
      this.circle_name = null
      this.circle_url = null
      this.comment = null
      this.cost = null
      this.color = 'black'

      this.days = [
        { key: 1, value: '１日目' },
        { key: 2, value: '2日目' },
        { key: 3, value: '3日目' }
      ]

      angular.forEach attr, (v, k) ->
        self[k] = v

      $rootScope.$watch ->
        self.carea_id
      , (newValue, oldValue) ->
        careas = self.careas.filter (x) ->
          x.id == self.carea_id
        if careas.length > 0
          self.cblocks = careas[0].cblocks
          self.cblock_id = self.cblocks[0].id

      $rootScope.$watch ->
        self.cblock_id
      , (newValue, oldValue) ->
        if self.carea_id != null && self.cblock_id != null
          url = "/careas/#{self.carea_id}/cblocks/#{self.cblock_id}/clayouts.json"
          $http.get(url).success (data) ->
            self.clayout_id = data.clayouts[0].id
            self.clayouts = data.clayouts

    create:  ->
      data =
        ccircle_checklist:
          comiket_id: this.comiket_id
          clayout_id: this.clayout_id
          day: this.day
          circle_name: this.circle_name
          circle_url: this.circle_url
          comment: this.comment
          cost: this.cost
          color: this.color
      $http.post("/ccircle_checklists.json", data)

    update: (data) ->
      $http.put("/ccircle_checklists/#{this.id}.json", data)

    updateAll: ->
      data =
        ccircle_checklist:
          clayout_id: this.clayout_id
          day: this.day
          circle_name: this.circle_name
          circle_url: this.circle_url
          comment: this.comment
          cost: this.cost
          color: this.color
      this.update(data)

    destroy: ->
      $http.delete("/ccircle_checklists/#{this.id}.json")

    initAttributes: ->
      this.clayout_id = this.careas[0].id
      this.day = 1
      this.circle_name = null
      this.circle_url = null
      this.comment = null
      this.cost = null
      this.color = "black"

    setCareas: (careas) ->
      this.careas = careas
      this.carea_id = careas[0].id

    fullInfo: ->
      self = @
      carea = (self.careas.filter (x) -> x.id == self.carea_id)[0]
      cblock = (self.cblocks.filter (x) -> x.id == self.cblock_id)[0]
      clayout = (self.clayouts.filter (x) -> x.id == self.clayout_id)[0]
      if carea && cblock && clayout
        "#{self.day}日目 #{carea.name} #{cblock.name} - #{clayout.space_no} #{self.circle_name}"
      else
        null
]
