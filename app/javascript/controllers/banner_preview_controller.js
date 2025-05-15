import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "preview", "hidden"]

  connect() {
    const val = this.hiddenTarget.value
    if (val) {
      this.previewTarget.src = `data:image/jpeg;base64,${val}`
      this.previewTarget.classList.remove("hidden")
    }
  }

  preview() {
    const file = this.fileInputTarget.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = e => {
      this.previewTarget.src = e.target.result
      this.hiddenTarget.value = e.target.result.split(",")[1]
      this.previewTarget.classList.remove("hidden")
    }
    reader.readAsDataURL(file)
  }
}
