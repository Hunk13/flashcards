$(document).on("page:change", function () {
  var interval = setInterval(function() { timer() }, 1000);
  var quality = 0;
  $("#timer").text(quality);

  function timer() {
    quality++;
    $("#timer").text(quality);
    $("#review_quality").val(quality);
  }

  $(document).on("page:change", function() {
      clearInterval(interval);
  });
});