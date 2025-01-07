import "@hotwired/turbo-rails";
import "controllers";
import "jquery";
import "jquery_ujs"
import "select2";
import "datatables.net";
import "datatables.net-bs5";
import "@nathanvda/cocoon";
import "bootstrap";

$(document).on("turbo:load", function() {
  $(".datatable").each(function() {
    const table = $(this);
    const ajaxUrl = table.data('url');
    const columns = table.data('columns');

    if (ajaxUrl && columns) {
      table.DataTable({
        processing: true,
        serverSide: true,
        ajax: ajaxUrl,
        columns: columns,
        responsive: true
      });
    }
  });

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
})


$(document).on('turbo:before-cache', function() {
  var dataTable = $($.fn.dataTable.tables(true)).DataTable();
  if (dataTable !== null) {
    dataTable.clear();
    dataTable.destroy();
  }

  $('.js-select2').each(function() {
    if ($(this).hasClass("select2-hidden-accessible")) {
      $(this).select2('destroy');
    }
  });
});