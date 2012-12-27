// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery-1.4.4.min
//= require jquery.wymeditor
//= require rails

$(function () {
  jQuery(".wymeditor").wymeditor({
    basePath: "/wymeditor/",
    iframeBasePath: "/wymeditor/iframe/default/",
    skinPath: "/wymeditor/skins/default/",
    wymPath: "/assets/admin.js"
  });

  $('form').submit(function () {
    $.each(WYMeditor.INSTANCES, function (i, e) {
      jQuery.wymeditors(i).update();
    });
  });
});
