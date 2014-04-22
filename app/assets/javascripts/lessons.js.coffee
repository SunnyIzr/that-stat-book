$ ->
  $("#lessons tbody").sortable
    axis: 'y'
    update: ->
      data = {yellow: [], orange: [], green: [], blue: [], purple: [], red: [], brown: [], black: []}
      $('.lesson').each ->
        data[$(this).data('color')].push(this.id)
      console.log(data)
      $.post($(this).data('update-url'),{lesson:data})