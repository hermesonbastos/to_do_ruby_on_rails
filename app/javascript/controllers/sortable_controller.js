import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = {
    group: String,
    reorderUrl: String, // para colunas
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      group: this.groupValue,
      ghostClass: "sortable-ghost",
      chosenClass: "sortable-chosen",
      dragClass: "sortable-drag",
      fallbackTolerance: 150,
      fallbackOnBody: true,
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  onEnd(event) {
    event.item.classList.remove("sortable-chosen","sortable-ghost","sortable-drag")
    this.moveTask(event)
  }

  moveTask(event) {
    const taskId        = event.item.dataset.taskId
    const originColumn  = event.from.dataset.columnId
    const targetColumn  = event.to.dataset.columnId
    const newPosition   = Array.from(event.to.querySelectorAll('.task-card')).indexOf(event.item)

    // esconder texto “nenhuma task” se existir
    const noTasksEl = document.getElementById(`no_tasks_text_${targetColumn}`)
    if (noTasksEl) noTasksEl.style.display = 'none'

    fetch(`/columns/${originColumn}/tasks/${taskId}/move`, {
      method: "PATCH",
      headers: this._headers(),
      body: JSON.stringify({ 
        target_column_id: targetColumn, 
        new_position: newPosition 
      })
    })
    .then(r => { if (!r.ok) console.error("Erro ao mover task") })
    .catch(e => console.error("Erro:", e))
  }

  _headers() {
    return {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
    }
  }
}
