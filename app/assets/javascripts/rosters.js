$(function() {
  studentSelect()
})

var studentSelect = function() {
  $('.existing-students option').dblclick(function() {
    $('.confirmed-students').append(this)
  })
}
