$(document).ready(function(){
  // triggerLearningModuleDropdown()
})

videoLoad =  function() {
  $('.new-video-load').click(function(event){
    event.preventDefault();
    url = $(this).attr('href')
     $.getJSON(url,function(response) {
      $('.video-preview').html(response.html)
      $('.video-preview').css('margin-bottom','100px')
    })
  })
}

videoView = function(){
  $("video").on('play', function(e) {
    userId = $(this).data('user-id')
    videoId = $(this).data('video-id')
    $.post('/video_views',{user_id: userId, video_id: videoId}, function(){})
  });
  $("video").on('pause', function(e) { $('video').off() })
}

var triggerLearningModuleDropdown = function(){
  $('.dropdown-title').click(function(e){
    e.preventDefault()
    // console.log($(this).find('.dropdown-toggle'))
    $(this).find('.dropdown-toggle').click()
  })
}