var TimerController = {
  init: function() {
    this.setQuizStartTime()
    this.startTimer()
  },
  setQuizStartTime: function() {
    TimerModel.quizStartTime = parseInt($('.time')[0].value)
  },
  startTimer: function() {
    setInterval(function() {
    $('.timer').text( TimerModel.quizStartTime + parseInt( (new Date - TimerModel.startTime) / 1000 ));
    $('.time')[0].value = TimerModel.quizStartTime + parseInt( (new Date - TimerModel.startTime) / 1000 );
}, 1000);
  }
}

var TimerModel = {
  startTime: new Date,
  quizStartTime: 0
}

var TimerView = {
  
}
