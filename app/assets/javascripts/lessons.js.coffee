$ ->
  $('.sortable').nestedSortable
    handle: 'div',
    items: 'li',
    toleranceElement: '> div'
    update: ->
      $.post('/lessons/sort', $('ol.sortable').nestedSortable('serialize'))