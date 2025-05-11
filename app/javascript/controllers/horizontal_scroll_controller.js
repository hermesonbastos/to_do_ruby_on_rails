import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('wheel', this.handleWheel.bind(this), { passive: false })
  }

  disconnect() {
    this.element.removeEventListener('wheel', this.handleWheel.bind(this))
  }

  handleWheel(event) {
    if (event.deltaY !== 0) {
      event.preventDefault()
      this.element.scrollLeft += event.deltaY + event.deltaX
    }
  }
}