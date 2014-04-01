var TimerController = {
  init: function() {
    this.startTimer()
  },
  startTimer: function() {
    setInterval(function() {
    $('.time').text( parseInt( (new Date - TimerModel.startTime) / 1000 ));
}, 1000);
  }
}

var TimerModel = {
  startTime: new Date
}

var TimerView = {
  
}
