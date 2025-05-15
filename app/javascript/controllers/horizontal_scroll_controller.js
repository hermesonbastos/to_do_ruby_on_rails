import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    this.boundHandleWheel = this.handleWheel.bind(this)

    this.toggleWheel = () => {
      if (window.innerWidth >= 768) {
        if (!this.enabled) {
          this.element.addEventListener("wheel", this.boundHandleWheel, { passive: false })
          this.enabled = true
        }
      } else {
        if (this.enabled) {
          this.element.removeEventListener("wheel", this.boundHandleWheel)
          this.enabled = false
        }
      }
    }

    this.toggleWheel()
    window.addEventListener("resize", this.toggleWheel)
  }

  disconnect () {
    if (this.enabled) {
      this.element.removeEventListener("wheel", this.boundHandleWheel)
    }
    window.removeEventListener("resize", this.toggleWheel)
  }

  handleWheel (event) {
    if (event.deltaY !== 0) {
      event.preventDefault()
      this.element.scrollLeft += event.deltaY + event.deltaX
    }
  }
}
