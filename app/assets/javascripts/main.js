

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