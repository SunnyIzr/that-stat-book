var timerFunc = setInterval(function() {
      TimerModel.quizCountDown();
    }, 1000)


var TimerModel = {
  quizCountDown: function(){
    quizId = window.location.href.split('=')[1]
    $.post('/countdown', {quiz_id: quizId}, function(res) {
      newTime = res
      if (newTime == '0:00') {
        TimerView.setNewTime(newTime)
        clearInterval(timerFunc)
        window.location = '/quizzes/'+quizId+'/incomplete'
      } else {
        TimerView.setNewTime(newTime)
      }
    })
  }
}

var TimerView = {
  setNewTime: function(newTime){
    $('.timer').text(newTime);    
  }
}
