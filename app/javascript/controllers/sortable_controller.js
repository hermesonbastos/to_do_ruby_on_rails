import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    group: String,
    reorderUrl: String,
    url: String,
    columnId: String 
  }

  connect() {
    console.log(this.element)
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      group: this.groupValue,
      sort: this.groupValue === "columns",
      handle: this.groupValue === "columns" ? ".column-handle" : undefined,
      ghostClass: "sortable-ghost",
      chosenClass: "sortable-chosen",
      dragClass: "sortable-drag",
      fallbackTolerance: this.groupValue === "tasks" ? 150 : undefined,
      fallbackOnBody: this.groupValue === "tasks" ? true : undefined,
      onChoose:  this.groupValue === "tasks" ? (e => e.item.classList.add("sortable-chosen"))  : undefined,
      onUnchoose:this.groupValue === "tasks" ? (e => e.item.classList.remove("sortable-chosen","sortable-ghost","sortable-drag")) : undefined,
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  onEnd(event) {
    event.item.classList.remove("sortable-chosen","sortable-ghost","sortable-drag")

      console.log("ta executando")

    if (this.groupValue === "columns") {
      this.reorderColumns()
    } else {
      if (event.from !== event.to) {
        this.moveTask(event)
      } else {
        this.reorderTasks()
      }
    }
  }

  reorderColumns() {
    const ids = Array.from(this.element.children)
      .filter(el => el.dataset.columnId)
      .map(el => el.dataset.columnId)
    if (!ids.length) return

    fetch(this.reorderUrlValue, {
      method: "PATCH",
      headers: this._headers(),
      body: JSON.stringify({ column_ids: ids })
    })
  }

  reorderTasks() {
    const ids = Array.from(this.element.querySelectorAll(".task-card"))
      .map(el => el.dataset.taskId)
    if (!ids.length) return

    fetch(this.urlValue, {
      method: "PATCH",
      headers: this._headers(),
      body: JSON.stringify({ task_ids: ids })
    })
  }

  moveTask(event) {
    const taskId = event.item.dataset.taskId
    const targetColumnId = event.to.dataset.columnId

    fetch(`/columns/${this.columnIdValue}/tasks/${taskId}/move`, {
      method: "PATCH",
      headers: {
        ...this._headers(),
        "Accept": "text/vnd.turbo-stream.html"
      },
      body: JSON.stringify({ target_column_id: targetColumnId })
    })
    .then(r => r.text())
    .then(html => Turbo.renderStreamMessage(html))
  }

  _headers() {
    return {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
    }
  }
}
