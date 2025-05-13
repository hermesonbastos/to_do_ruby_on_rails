import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect () {
    const saved = localStorage.getItem("theme") || "custom360"
    document.documentElement.dataset.theme = saved

    this.checkboxTargets.forEach(cb => {
      cb.checked = cb.value === saved
    })
  }
  

  toggle (event) {
    const newTheme = event.target.checked ? event.target.value : "custom360"
    document.documentElement.dataset.theme = newTheme
    localStorage.setItem("theme", newTheme)
    document.cookie = `theme=${newTheme}; path=/; max-age=31536000`
  }
}
