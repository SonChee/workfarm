$ ->
  $(document).on "click", ".search-form-toggle", (e) ->
    e.preventDefault()
    target = $(this).attr("data-target")
    $("##{target}").slideToggle("slow")