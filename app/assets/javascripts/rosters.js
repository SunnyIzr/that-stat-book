$(function() {
  studentSelect()
})

var studentSelect = function() {
  $(document).on('dblclick','.existing-students option',function() {
    $('.confirmed-students').append(this)
  })
}


$(function() {
  var opts = $('#student-list option').map(function(){
    return [[this.value, $(this).text()]];
  });


  $('#student-search').keyup(function(){
    var rxp = new RegExp($('#student-search').val(), 'i');
    var optlist = $('#student-list').empty();
    opts.each(function(){
      if (rxp.test(this[1])) {
        optlist.append($('<option/>').attr('value', this[0]).text(this[1]));
      }
    });
    
  });
  
});