@comiguideApp.factory 'CkigyoChecklist', ($http) ->
  class CkigyoChecklist
    constructor: (attr) ->
      self = @
      this.ckigyo_id = null
      this.comment = null
      this.cost = null
      this.color = 'black'
      angular.forEach attr, (v, k) ->
        self[k] = v

    create: ->
      data =
        ckigyo_checklist:
          ckigyo_id: this.ckigyo_id
          comment: this.comment
          cost: this.cost
          color: this.color
      $http.post("/ckigyo_checklists.json", data)

    update: (data) ->
      $http.put("/ckigyo_checklists/#{this.id}.json", data)

    updateAll: ->
      data =
        ckigyo_checklist:
          comment: this.comment
          cost: this.cost
          color: this.color
      this.update(data)

    destroy: ->
      $http.delete("/ckigyo_checklists/#{this.id}.json")

    initAttributes: (ckigyo_id) ->
      this.ckigyo_id = ckigyo_id
      this.comment = null
      this.cost = null
      this.color = 'black'
