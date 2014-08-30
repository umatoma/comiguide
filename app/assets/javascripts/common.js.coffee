# ----------------------------------------------------------
# ShowModal
# ----------------------------------------------------------
$ ->
  $(document).on "click", ".show-modal", ->
    $modal = $("#Modal")
    $obj = $(this)
    $.ajax
      method: "GET"
      url: $obj.attr("modal-href")
      dataType: "html"
      beforeSend: (xhr) ->
        unless $obj.attr("modal-keep") is "1"
          $modal.find(".modal-title").html("NowLoading...")
          $modal.find(".modal-body .inner").empty()
          $modal.find(".progress").show()
        else
          $modal.find(".progress").hide()
        $modal.modal("show")
    .done (data, textStatus, jqXHR) ->
      $modal.find(".progress").hide()
      $modal.find(".modal-title").html($obj.attr("modal-title"))
      $modal.find(".modal-body .inner")
            .css("opacity", 0.0)
            .html(data)
            .animate({ opacity: 1.0 }, "normal")
    .fail (jqXHR, textStatus, errorThrown) ->
      $modal.modal("hide")
    return false
