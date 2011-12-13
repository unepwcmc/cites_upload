// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require_self

$(document).ready(function(){
  $("input[type=radio]").change(function(){
    if(this.value == "true"){
      $(this).parents('.clearfix').next().show('slow');
      //change the documents that were marked to be removed by the user interaction with Yes or No question.
      $(this).parents('.clearfix').next().find('.to_be_removed').each(function(){
        $(this).val("0").removeClass("to_be_removed");
      });
    } else{
      $(this).parents('.clearfix').next().hide('slow');
      //Mark all the documents of this type to be destroyed, unless they are already marked for destruction.
      $(this).parents('.clearfix').next().find("input[type=hidden]").each(function(){
        if($(this).val() != "1"){
          $(this).addClass("to_be_removed");
          $(this).val("1");
        }
      });
    }
  });
  if($("#new_report").length > 0){
    confirmSubmission();
  }
});
