import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  handleKeydown(event) {
    if (event.key === "Enter") {
      event.preventDefault()
      event.target.form.requestSubmit()
    } else if (event.key === "Escape") {
      this.cancel()
    }
  }

  cancel() {
    const columnCreator = this.element.closest("[data-controller='column-creator']")
    if (columnCreator) {
      const controller = this.application.getControllerForElementAndIdentifier(
        columnCreator, 
        "column-creator"
      )
      controller.hideForm()
    }
  }

  resetForm() {
    this.inputTarget.value = ""
    if (this.hasToggleTarget) this.toggleTarget.checked = false
    this.cancel()
  }
}