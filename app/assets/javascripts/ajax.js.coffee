jQuery ($) ->
  $("a[data-update]").live("ajax:success",
    (data, status, xhr) ->
      $("#"+$(this).attr("data-update")).html(status)
      return null
    )
  return null
