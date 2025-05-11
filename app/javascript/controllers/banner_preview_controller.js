import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "preview", "hidden"]

  preview() {
    const file = this.fileInputTarget.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = e => {
      const base64 = e.target.result.split(",")[1]
      this.previewTarget.src = e.target.result
      this.hiddenTarget.value = base64
    }
    reader.readAsDataURL(file)
  }
}
