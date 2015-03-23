@comiguideApp.factory 'C1circle', ->
  class C1circle
    constructor: (attr) ->
      self = @
      this.comic1_id = null
      this.c1layout_id = null
      this.space_no_sub = 'a'
      this.name = null
      this.kana = null
      this.url = null
      this.updated_at = null
      this.created_at = null
      this.c1layout = null

      this.space_no_subs = [
        { key: 'a', value: 'a' },
        { key: 'b', value: 'b' }
      ]

      angular.forEach attr, (v, k) ->
        self[k] = v

    spaceInfo: ->
      block_name = this.c1layout.c1block.name
      space_no = this.c1layout.space_no
      "#{block_name}-#{space_no}-#{this.space_no_sub}"

    fullInfo: ->
      "#{this.spaceInfo()} #{this.name}"
