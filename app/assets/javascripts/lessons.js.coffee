$ ->
  $("#lessons tbody").sortable
    axis: 'y'
    update: ->
      data = $(this).sortable('serialize')
      $.post($(this).data('update-url'),data)