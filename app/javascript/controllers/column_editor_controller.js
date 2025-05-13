import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "input", "newTaskButton"]

  showEdit() {
    this.displayTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.inputTarget.value = this.displayTarget.textContent.trim()
    this.inputTarget.focus()

    this.newTaskButtonTarget.classList.add("hidden")
  }

  hideEdit(event) {
    if (event && this.formTarget.contains(event.relatedTarget)) {
      return
    }
    
    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")

    this.newTaskButtonTarget.classList.remove("hidden")
  }

  cancel(event) {
    event.preventDefault();
    this.close();
  }


  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      this.formTarget.requestSubmit()
    } else if (event.key === "Escape") {
      this.hideEdit()
    }
  }
}