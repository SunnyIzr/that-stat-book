$(function() {
  studentSelect()
  studentSelectBtn()
  updateStudentsBtn()
  profSelect()
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

var profSelect = function(){
  $('#professor-list').change(function(){
    profId = $(this).val()
    $.getJSON('/rosters-prof/' + profId, function(res){
      appendRosterSelect(res)
    })
  })
}

var appendRosterSelect = function(rosters){
  var rosterList = "<select id='roster-list' name='roster' size='5'>"
  $.each(rosters, function(k,v){
    newOption = "<option value='" + v.id + "'>" + v.title + "</option>"
    rosterList += newOption
  })
  rosterList += '</select>'
  console.log(rosterList)
  $('#class-select').html(rosterList)
}














