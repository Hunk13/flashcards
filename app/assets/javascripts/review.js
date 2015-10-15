var quality;

function initTimer() {
  var interval;
  if (typeof interval !== "undefined") {
    clearInterval(interval);
  }
  interval = setInterval(function() { setQuality(); }, 1000);
  quality = 0;
  $("#timer").text(quality);
}

function setQuality() {
  quality++;
  $("#timer").text(quality);
  $("#review_quality").val(quality);
}

$(document).ready(function () {
  initTimer();
});