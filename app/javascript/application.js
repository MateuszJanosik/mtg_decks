// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "select2"
import $ from 'jquery';
import 'datatables.net-bs5';
import 'datatables.net-bs5/css/dataTables.bootstrap5.css';

$(document).on("turbo:load", function() {
  $(".datatable").each(function() {
    const table = $(this);
    const ajaxUrl = table.data('url')
    const columns = table.data('columns')

    table.DataTable({
      processing: true,
      serverSide: true,
      ajax: ajaxUrl,
      columns: columns,
      responsive: true
    });
  });
});

$(document).on('turbolinks:load', function(event){
  $('.js-select2').select2();
});

$(document).on('cocoon:after-insert', function(e, inserted) {
  $('.js-select2').select2();
})