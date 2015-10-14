$(document).ready(function () {
  var interval = setInterval(function() { setQuality() }, 1000);
  var quality = 0;
  $("#timer").text(quality);

  function setQuality() {
    quality++;
    $("#timer").text(quality);
    $("#review_quality").val(quality);
  }

  $(document).on("page:change", function() {
    clearInterval(interval);
  });
});