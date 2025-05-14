import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (event) => {
      if (event.target === this.element) {
        this.close();
      }
    });
  }

  open() {
    this.element.classList.add('modal-open');
  }

  afterSubmit() {
    this.close();
  }

  close() {
    this.element.classList.remove('modal-open');
    
    if (this.element.dataset.modalRemoveOnClose === "true") {
      setTimeout(() => this.element.remove(), 150);
    }
  }

  cancel(event) {
    event.preventDefault()
    this.element.classList.remove("modal-open")
    if (this.data.get("removeOnClose") === "true") {
      setTimeout(() => this.element.remove(), 150)
    }
  }

}