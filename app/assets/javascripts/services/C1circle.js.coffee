@comiguideApp.factory 'C1circle', ->
  class C1circle
    constructor: (attr) ->
      self = @
      this.comic1_id = null
      this.c1layout_id = null
      this.space_no_sub = 0
      this.name = null
      this.kana = null
      this.url = null
      this.updated_at = null
      this.created_at = null
      this.c1layout = null

      this.space_no_subs = [
        { key: 0, value: 'a' },
        { key: 1, value: 'b' }
      ]

      angular.forEach attr, (v, k) ->
        self[k] = v

    spaceNoSubName: ->
      self = @
      (self.space_no_subs.filter (x) -> x.key == self.space_no_sub)[0].value

    spaceInfo: ->
      block_name = this.c1layout.c1block.name
      space_no = this.c1layout.space_no
      space_no_sub_name = this.spaceNoSubName()
      "#{block_name}-#{space_no}-#{space_no_sub_name}"

    fullInfo: ->
      "#{this.spaceInfo()} #{this.name}"
