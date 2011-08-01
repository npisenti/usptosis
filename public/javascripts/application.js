// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function(){
  $("#check-button").button();
  $("#roll-again").button();
  $("#roll-again").hide();

  $("#check-button").click(function(){ 
    if ($("#answer").text() == "0"){
      $(".left").css('background', 'green');
      } else {
      $(".right").css('background', 'green');
      }
     $("#roll-again").show(); 
     $("#check-button").hide();
    });
$("#roll-again").click(function(){
  window.location.reload();
  });
});
