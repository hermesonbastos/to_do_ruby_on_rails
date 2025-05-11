import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "form", "placeholder"]

  showForm() {
    this.buttonTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.placeholderTarget.classList.remove("hidden")
    
    setTimeout(() => {
      const input = this.formTarget.querySelector("input[name='column[name]']")
      if (input) input.focus()
    }, 100)
  }

  hideForm() {
    this.buttonTarget.classList.remove("hidden")
    this.formTarget.classList.add("hidden")
    this.placeholderTarget.classList.add("hidden")
  }
}