$(function() {
  studentSelect()
  studentSelectBtn()
  updateStudentsBtn()
})

var studentSelect = function() {
  $(document).on('dblclick','.existing-students option',function() {
    $('.confirmed-students').append(this)
  })
}

var studentSelectBtn = function(){
  $('#move-student').click(function(e){
    e.preventDefault();
    $('.existing-students option:selected').each(function(){
      $('.confirmed-students').append(this)  
    })
  })
}

var updateStudentsBtn = function(){
  $('.update-students-btn').click(function(e){
    if ($('.confirmed-students option').size() == 0) {
      e.preventDefault();
      alert('You have not selected any students to add...')
    }
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