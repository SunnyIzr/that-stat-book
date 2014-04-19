var TimerController = {
  init: function() {
    this.startTimer()
  },
  startTimer: function() {
    setInterval(function() {
    TimerModel.quizCountDown();
    }, 1000);
  }
}

var TimerModel = {
  quizCountDown: function(){
    console.log('hello!!')
    quizId = window.location.href.split('=')[1]
    $.post('/countdown', {quiz_id: quizId}, function(res) {
      console.log('h')
      newTime = res
      console.log(newTime)
      TimerView.setNewTime(newTime)
    })
  }
}

var TimerView = {
  setNewTime: function(newTime){
    $('.timer').text(newTime);    
  }
}
