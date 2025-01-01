import "@hotwired/turbo-rails";
import "controllers";
import "jquery";
import "select2";
import "datatables.net";
import "datatables.net-bs5";
import "@nathanvda/cocoon";

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

  $('.js-select2').select2();
});

document.addEventListener('cocoon:after-insert', function(e) {
  $('.js-select2').select2();
});