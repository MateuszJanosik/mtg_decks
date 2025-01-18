import "jquery";
import "@hotwired/turbo-rails";
import "controllers";
import "jquery_ujs";
import "select2";
import "@nathanvda/cocoon";
import "bootstrap";

$(document).on("turbo:load", function() {
  $('.js-select2').select2({
    theme: 'bootstrap-5'
  });
});

$(document).on('cocoon:after-insert', function(e) {
  $('.js-select2').select2({
    theme: 'bootstrap-5'
  });
});

$(document).on("turbo:submit-end", (event) => {
  if (event.target.id === "new-comment-form") {
    event.target.reset();
  }
});

$(document).on('turbo:before-cache', function() {
  $('.js-select2').each(function() {
    if ($(this).hasClass("select2-hidden-accessible")) {
      $(this).select2('destroy');
    }
  });
});
