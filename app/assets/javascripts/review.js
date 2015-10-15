function initTimer() {
  var interval;
  var quality;
  if (typeof interval !== "undefined") {
    clearInterval(interval);
  }
  interval = setInterval(function() { setQuality(); }, 1000);
  quality = 0;
  $("#timer").text(quality);
}

function setQuality() {
  var quality;
  quality++;
  $("#timer").text(quality);
  $("#review_quality").val(quality);
}

$(document).ready(function () {
  initTimer();
});