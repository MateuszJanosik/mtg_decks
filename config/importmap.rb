# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.12
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js", preload: true
pin 'jquery_ujs', to: "https://cdn.jsdelivr.net/npm/jquery-ujs@1.2.3/src/rails.min.js", preload: true
pin "select2" # @4.1.0
pin "datatables.net", to: "https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"
pin "datatables.net-bs5", to: "https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.min.js"
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.12
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.201
pin "@nathanvda/cocoon", to: "@nathanvda--cocoon.js" # @1.2.14pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
