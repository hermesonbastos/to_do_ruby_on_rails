import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["settingsButton", "doneToggle"]

  connect() {}

  toggleDoneColumn(event) {
    event.target.form.requestSubmit()
  }

  confirmDelete(event) {
    event.preventDefault()
    
    const columnId = this.element.dataset.columnId

    const modal = document.getElementById(`delete_column_modal_${columnId}`)
    if (modal) {
      modal.showModal()
    }
  }
}