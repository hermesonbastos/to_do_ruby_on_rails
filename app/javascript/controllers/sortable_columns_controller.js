import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".column-handle",
      ghostClass: "sortable-ghost",
      chosenClass: "sortable-chosen",
      dragClass: "sortable-drag",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) {
      this.sortable.destroy()
    }
  }

  onEnd(event) {
    const columnIds = Array.from(this.element.children)
      .filter(el => el.dataset.columnId)
      .map(el => el.dataset.columnId)
    
    if (columnIds.length === 0) return
    
    const csrfToken = document.querySelector("meta[name='csrf-token']").content
    
    fetch(this.element.dataset.reorderUrl, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ column_ids: columnIds })
    })
  }
}