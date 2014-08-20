$(function() {
  var opts = $('tbody tr').map(function(){
    return [[this, $(this).find('a').html()]];
  });


  $('#member-search').keyup(function(){
    var rxp = new RegExp($('#member-search').val(), 'i');
    var optlist = $('tbody').empty();
    opts.each(function(){
      if (rxp.test(this[1])) {
        optlist.append(this[0])
      }
    });
    
  });
  
});