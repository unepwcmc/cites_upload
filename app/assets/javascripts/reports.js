// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// Nested forms
// ============

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
  if($(link).parents('.inset').find('.fields:visible').length === 0){
    $(link).parents('.inset').find('.add_file').removeClass('hide');
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("div."+association).append(content.replace(regexp, new_id));
}

function enableDisplayingSelectedFile(translatedText){
  $("div#export, div#import, div#information").delegate('input.upload_file', 'change', function(){
      if($(this).val()!==""){
        $(this).parent().nextAll('span').html(translatedText+": <em>"+$(this).val()+"</em>");
        $(this).parent().nextAll('span').show('slow');
        if($(this).parent().parent().parent().prevAll('.add_file').hasClass('hide')){
          $(this).parent().parent().parent().prevAll('.add_file').removeClass('hide');
        }
      } else{
        $(this).parent().nextAll('span').hide('slow');
      }
  });
}

function confirmSubmission(){
  $("#confirm_submission").modal({backdrop: 'static'});
  $("#new_report").submit(function(event){
    event.preventDefault();
    fillInModalDetails();
    $("#confirm_submission").modal("show");
    });
  $("#cancel").click(function(e){
    e.preventDefault();
    $("#confirm_submission").modal("hide");
    });
  $("#do_submit").click(function(e){
    e.preventDefault();
    $("#new_report").unbind("submit");
    $("#new_report").submit();
  });
}

function fillInModalDetails(){
  $("#confirm_year").html($("#report_year option:selected").text());
  $("#confirm_basis").html($("#report_basis option:selected").text());
  $("#confirm_exports").empty();
  if($("#report_has_exports_false").is(':checked')){
    $("#confirm_exports").append("<li>You said that there are no exports</li>");
  }else{
    $("#uploaded_exports").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        $("#confirm_exports").append("<li>"+$(this).val()+"</li>");
      }
    });
    if($("#confirm_exports").children('li').length === 0){
      $("#confirm_exports").append("<li>No export files were added.</li>");
    }
  }
  $("#confirm_imports").empty();
  if($("#report_has_imports_false").is(':checked')){
    $("#confirm_imports").append("<li>You said that there are no imports</li>");
  }else{
    $("#uploaded_imports").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        $("#confirm_imports").append("<li>"+$(this).val()+"</li>");
      }
    });
    if($("#confirm_imports").children('li').length === 0){
      $("#confirm_imports").append("<li>No import files were added.</li>");
    }
  }
  $("#confirm_additional_information").empty();
  if($("#report_has_additional_information_false").is(':checked')){
    $("#confirm_additional_information").append("<li>You said that there is no additional information</li>");
  }else{
    $("#uploaded_information").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        $("#confirm_additional_information").append("<li>"+$(this).val()+"</li>");
      }
    });
    if($("#confirm_additional_information").children('li').length === 0){
      $("#confirm_additional_information").append("<li>No additional information was added.</li>");
    }
  }
}

