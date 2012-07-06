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
  $("div#exports, div#imports, div#additional_information").delegate('input.upload_file', 'change', function(){
      if($(this).val()!==""){
        var objRE = new RegExp(/([^\/\\]+)$/);
        var strName = objRE.exec($(this).val());
        $(this).parent().nextAll('span').html(translatedText+": <em>"+strName[1]+"</em>");
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
  $("form.report-form").submit(function(event){
    event.preventDefault();
    var year = $("#report_year").val();
    checkReportExists(year, true);
  });
  $("#cancel").click(function(e){
    e.preventDefault();
    $("#confirm_submission").modal("hide");
    $("#do_submit").show();
    $("#confirmation_warning").hide();
  });
  $("#do_submit").click(function(e){
    e.preventDefault();
    $(this).unbind('click');
    $("form.report-form").unbind("submit");
    $("form.report-form").submit();
  });
}

function fillInModalDetails(){
  $("#confirm_year").html($("#report_year option:selected").text());
  $("#confirm_basis").html($("#report_basis option:selected").text());
  var objRE = new RegExp(/([^\/\\]+)$/);
  var strName = '';
  $("#confirm_exports").empty();
  if($("#report_has_exports_false").is(':checked')){
    if($("#report_no_trade_exports").is(':checked')){
      $("#confirm_exports").append("<li>No trade occurred</li>");
    }else {
      $("#confirm_exports").append("<li>No export files were added.</li>");
    }
  }else if($("#report_has_exports_true").is(':checked')){
    $("#uploaded_exports").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        strName = objRE.exec($(this).val());
        $("#confirm_exports").append("<li>"+strName+"</li>");
      }
    });
    if($("#confirm_exports").children('li').length === 0){
      $("#confirm_exports").append("<li>No export files were added. <span class='warning'>Please add a file or select 'No' if you do not have any files to upload.</span></li>");
      $("#do_submit").hide();
      $("#confirmation_warning").show();
    }
  }else {
    $("#confirm_exports").append("<li><span class='warning'>Please select one option ('Yes' or 'No').</span></li>");
    $("#do_submit").hide();
    $("#confirmation_warning").show();
  }
  $("#confirm_imports").empty();
  if($("#report_has_imports_false").is(':checked')){
    if($("#report_no_trade_imports").is(':checked')){
      $("#confirm_imports").append("<li>No trade occurred</li>");
    } else {
      $("#confirm_imports").append("<li>No import files were added.</li>");
    }
  }else if($("#report_has_imports_true").is(':checked')){
    $("#uploaded_imports").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        strName = objRE.exec($(this).val());
        $("#confirm_imports").append("<li>"+strName+"</li>");
      }
    });
    if($("#confirm_imports").children('li').length === 0){
      $("#confirm_imports").append("<li>No import files were added. <span class='warning'>Please add a file or select 'No' if you do not have any files to upload.</span></li>");
      $("#do_submit").hide();
      $("#confirmation_warning").show();
    }
  } else {
    $("#confirm_imports").append("<li><span class='warning'>Please select one option ('Yes' or 'No').</span></li>");
    $("#do_submit").hide();
    $("#confirmation_warning").show();
  }
  $("#confirm_additional_information").empty();
  if($("#report_has_additional_information_false").is(':checked')){
    $("#confirm_additional_information").append("<li>No additional information was added.</li>");
  }else{
    $("#uploaded_additional_information").find('.upload_file').each(function(){
      if($(this).nextAll('input[type=hidden]').val()!=="1" && $(this).val() !== ""){
        strName = objRE.exec($(this).val());
        $("#confirm_additional_information").append("<li>"+strName+"</li>");
      }
    });
    if($("#confirm_additional_information").children('li').length === 0){
      $("#confirm_additional_information").append("<li>No additional information was added.</li>");
    }
  }
}

function hasFilesOrNot(){
  $("input[type=radio]").change(function(){
    if(this.value == "true"){
      //hide no trade if present
      $(this).parents('.clearfix').nextAll('.no_trade').hide('slow');
      //remove tick from no trade checkbox
      $(this).parents('.clearfix').nextAll('.no_trade').find('input').attr('checked', false);
      //show files controls
      $(this).parents('.clearfix').nextAll('.files_control').show('slow');
      //change the documents that were marked to be removed by the user interaction with Yes or No question.
      $(this).parents('.clearfix').nextAll('.files_control').find('.to_be_removed').each(function(){
        $(this).val("0").removeClass("to_be_removed");
      });
    } else{
      $(this).parents('.clearfix').nextAll('.no_trade').show('slow');
      $(this).parents('.clearfix').nextAll('.files_control').hide('slow');
      //Mark all the documents of this type to be destroyed, unless they are already marked for destruction.
      $(this).parents('.clearfix').nextAll('.files_control').find("input[type=hidden]").each(function(){
        if($(this).val() != "1"){
          $(this).addClass("to_be_removed");
          $(this).val("1");
        }
      });
    }
  });
}

function existingReport(){
  $("#existing_report").modal({backdrop: 'static'});
  $("#existing_report_cancel").click(function(e){
    e.preventDefault();
    $("#existing_report").modal('hide');
  });
  $("#report_year").change(function(){
    var year = $(this).val();
    checkReportExists(year, false);
  });
}

function checkReportExists(year, submission){
  var result;
  $.ajax({
    url: '/users/'+CURRENT_USER+'/has_report',
    data: {year: year},
    dataType: 'json',
    success: function(report_id){
      if(report_id !== -1 && report_id !== CURRENT_REPORT){
        $("#existing_report_year").text(year);
        $("#edit_existing").attr("href", '/reports/'+report_id+'/edit');
        $("#existing_report").modal('show');
      } else if(submission){
        fillInModalDetails();
        $("#confirm_submission").modal("show");
      }
      result = report_id;
    }
  });
  return result;
}
