function initTimer() {
  if (typeof interval !== "undefined") {
    clearInterval(interval);
  }
  interval = setInterval(function() { setQuality(); }, 1000);
  seconds = 0;
  $("#timer").text(seconds);
}

function setQuality() {
  seconds++;
  $("#timer").text(seconds);
  $("#review_seconds").val(seconds);
}

$(document).ready(function () {
  initTimer();
});