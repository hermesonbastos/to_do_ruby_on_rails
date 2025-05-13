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
    if (!modal) return

    // adiciona a classe que mostra o modal
    modal.classList.add("modal-open")
  }

  
  close(event) {
        event.preventDefault();

    console.log("dsaodsaddsa")
    
    const columnId = this.element.dataset.columnId
        console.log(columnId)

    console.log(document)
    const modal = document.getElementById(`delete_column_modal_${columnId}`)
   modal.classList.remove('modal-open');

  }

  showNewTaskModal(event) {
    event.preventDefault()
    
    const columnId = this.element.dataset.columnId
    console.log("aaaa")
    const modal = document.getElementById(`new_task_modal_${columnId}`)
      if (!modal) return

    // adiciona a classe que mostra o modal
    modal.classList.add("modal-open")
  }
}