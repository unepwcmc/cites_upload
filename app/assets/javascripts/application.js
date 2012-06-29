// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  if($("form.report-form").length > 0){
    hasFilesOrNot();
    confirmSubmission();
    existingReport();
  }
  //autoclose flash messages
  setTimeout(function() { 
    if($(".alert-message").length > 0 ){
      $(".alert-message").children('a.close').trigger('click'); 
    }
  }, 5000);
  $("table").tablesorter();
  $(".tooltips").twipsy();
});
