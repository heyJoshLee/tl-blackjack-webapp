$(document).ready(function() {
  $("form#hit_form input").click(function() {
    alert("player hits!");
    return false;
  });
});