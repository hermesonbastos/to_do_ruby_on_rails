import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    this.dialog = this.element

    if (!this.dialog.open && this.shouldAutoOpen()) this.open()
  }

  shouldAutoOpen() {
    return this.dialog.classList.contains("modal-open") ||
           this.dialog.dataset.autoOpen === "true"
  }

  open() {
    this.dialog.showModal();
    this.dialog.classList.remove("modal-open")
  }

  close() {
    this.dialog.close()
  }

  afterSubmit(event) {
    if (event.detail.success) this.close()
  }

  cancel(event) { 
    event.preventDefault();
    this.close()
  }
}
