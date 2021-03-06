// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require materialize-sprockets
$(document).on('turbolinks:load', function() {
  $('select').formSelect();
  $('.button-collapse').sidenav();
  $('.parallax').parallax();
  $('.alert').append('<button class="waves-effect btn-flat close"><i class="material-icons">close</i></button>');
  $('body').on('click', '.alert .close', function() {
    $(this).parent().fadeOut(300, function() {
        $(this).remove();
    });
  });
});
