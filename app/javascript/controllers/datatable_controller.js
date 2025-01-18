import { Controller } from "@hotwired/stimulus";
import "datatables.net";
import "datatables.net-bs5";

export default class extends Controller {
  connect() {
    this.initializeDataTable();
    this.setupEventListeners();
  }

  initializeDataTable() {
    const table = this.element;
    if ($.fn.DataTable.isDataTable(table)) {
      this.dataTable = $(table).DataTable();
      this.resetFilterInputs();
      return;
    }
    const ajaxUrl = table.dataset.url;
    const columns = JSON.parse(table.dataset.columns);
    this.dataTable = $(table).DataTable({
      processing: true,
      serverSide: true,
      ajax: ajaxUrl,
      columns: columns,
      responsive: true
    });
  }

  resetFilterInputs() {
    document.querySelectorAll('.filter-input').forEach(input => {
      input.value = null;
      const event = new Event('change');
      input.dispatchEvent(event);
    });
  }

  setupEventListeners() {
    document.querySelector('.apply-filters').addEventListener('click', this.applyFilters.bind(this));
    document.querySelector('.reset-filters').addEventListener('click', this.resetFilters.bind(this));
  }

  applyFilters(event) {
    event.preventDefault();
    const table = this.element;
    const url = new URL(table.dataset.url, window.location.origin);
    const filters = new URLSearchParams();

    document.querySelectorAll('.filter-input').forEach(input => {
      const inputId = input.dataset.select2Id;
      const value = input.value;
      if (value) {
        filters.append(`filters[${inputId}]`, value);
      }
    });

    url.search = filters.toString();

    this.dataTable.ajax.url(url.toString()).load();
  }

  resetFilters() {
    this.resetFilterInputs();
    const table = this.element;
    this.dataTable.ajax.url(table.dataset.url).load();
  }
}
