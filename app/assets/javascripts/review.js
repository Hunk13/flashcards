function initTimer() {
  if (typeof interval !== "undefined") {
    clearInterval(interval);
  }
  interval = setInterval(function() { updateCounter() }, 1000);
  quality = 0;
  $("#timer").text(quality);
}

function updateCounter() {
  quality++;
  $("#timer").text(quality);
  $("#review_quality").val(quality);
}

$(document).ready(function () {
  initTimer();
});