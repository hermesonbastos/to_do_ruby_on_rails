import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
    const savedTheme = localStorage.getItem("theme") || "custom360"
    this.applyTheme(savedTheme)
    this.checkboxTargets.forEach(cb => {
      cb.checked = (cb.value === savedTheme)
    })
  }

  toggle(event) {
    const newTheme = event.target.checked 
      ? event.target.value 
      : "custom360"

    this.applyTheme(newTheme)
  }

  applyTheme(theme) {
    document.documentElement.dataset.theme = theme
    localStorage.setItem("theme", theme)
    document.cookie = `theme=${theme}; path=/; max-age=31536000`
  }
}
