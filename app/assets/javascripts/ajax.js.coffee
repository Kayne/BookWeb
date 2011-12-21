jQuery ($) ->
  $("a[data-update]").bind("ajax:before",
    ->
      $("#"+$(this).attr("data-update")).html('<p><img src="/ajax-loader.gif" alt="Ładowanie..." /></p>')
      return null
    )
  $("a[data-update]").bind("ajax:success",
    (data, status, xhr) ->
      $("#"+$(this).attr("data-update")).html(status)
      return null
    )
  return null
