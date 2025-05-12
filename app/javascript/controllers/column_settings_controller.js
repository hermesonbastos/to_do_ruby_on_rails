import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["settingsButton", "doneToggle", "positionMenu"]

  static values  = {
    boardId: Number,
    columnId: Number,
    currentPosition: Number
  }

  toggleDoneColumn(event) {
    event.target.form.requestSubmit()
  }

  confirmDelete(event) {
    event.preventDefault()
    
    const columnId = this.element.dataset.columnId
    
    const modal = document.getElementById(`delete_column_modal_${columnId}`)
    if (modal) {
      modal.showModal()
    }
  }
  
  showNewTaskModal(event) {
    event.preventDefault()
    
    const columnId = this.element.dataset.columnId
    
    const modal = document.getElementById(`new_task_modal_${columnId}`)
    if (modal) {
      modal.showModal()
    }
  }
}