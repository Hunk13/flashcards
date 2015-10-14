function initTimer() {
  if (typeof interval !== "undefined") {
    clearInterval(interval);
  }
  interval = setInterval(function() { updateCounter() }, 1000);
  seconds = 0;
  $("#timer").text(seconds);
}

function updateCounter() {
  seconds++;
  $("#timer").text(seconds);
  $("#review_quality").val(seconds);
}

$(document).ready(function () {
  initTimer();
});