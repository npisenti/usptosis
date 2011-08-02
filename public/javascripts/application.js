// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var updatePercentage = function(){
  var correct = parseInt($("#correct-number").text());
  var incorrect = parseInt($("#incorrect-number").text());
  var percent = String(correct*100/(correct + incorrect)).split(".")[0];

  if ((correct + incorrect) == 0 ){
    $("#percent-stat").text("0 %");
  } else {
    $("#percent-stat").text(percent + " %");
  }

}

$(document).ready(function(){
  //$("#check-button").button();
  $("#roll-again").button();
  $("#roll-again").hide();
  $(".patent-info").hide();
 // $(".left").button();
 // $(".right").button();

  $(".left").click(function(){
    if ($("#answer").text() == "0"){
      $(".left").addClass('correct-answer');
      $(".left").removeClass('hover-me');
      $(".right").removeClass('hover-me');
      $("#correct-number").text(parseInt($("#correct-number").text()) + 1);
    } else {
      $(".right").addClass('correct-answer');
      $(".left").removeClass('hover-me');
      $(".right").removeClass('hover-me');
      $("#incorrect-number").text(parseInt($("#incorrect-number").text()) + 1);
    }
    $(".patent-info").show();
    $("#roll-again").show(); 
    
    updatePercentage();
    
  });
  
  $(".right").click(function(){
      if ($("#answer").text() == "0"){
        $(".left").addClass('correct-answer');
        $(".left").removeClass('hover-me');
        $(".right").removeClass('hover-me');
      $("#incorrect-number").text(parseInt($("#incorrect-number").text()) + 1);
      } else {
        $(".right").addClass('correct-answer');
        $(".left").removeClass('hover-me');
        $(".right").removeClass('hover-me');
      $("#correct-number").text(parseInt($("#correct-number").text()) + 1);
      }

      $(".patent-info").show();
      $("#roll-again").show(); 
    
      updatePercentage();
  
  });

  $("#roll-again").click(function(){
      $.get('/patents/show.js', function(data){
        $(".patent-info").hide();
        $("#roll-again").hide(); 
        $("#check-button").show();
        $(".left").addClass('hover-me');
        $(".right").addClass('hover-me');
        $(".left").removeClass('correct-answer');
        $(".right").removeClass('correct-answer');
      });

  });
});
