import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showTask(event) {
    event.preventDefault();

    const taskId = this.element.dataset.taskId
    const columnId = this.element.closest(".tasks-container").dataset.columnId
    
    fetch(`/columns/${columnId}/tasks/${taskId}`, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(r => {
        return r.text()
      }
    )
    .then(html => 
      {
        return Turbo.renderStreamMessage(html)
      }
      )
  }
  
  confirmDelete(event) {
    event.stopPropagation()
    const taskId = this.element.dataset.taskId
    const modal = document.getElementById(`delete_task_modal_${taskId}`)
    console.log(taskId)
    if (modal) {
      modal.classList.add("modal-open")
    }
  }

  closeModal(event) {
    event.stopPropagation()
    let taskId = event.target.dataset.taskId
    if (!taskId) {
      taskId = this.element.dataset.taskId
    }
    const modal = document.getElementById(`delete_task_modal_${taskId}`)
    if (modal) {
      modal.classList.remove("modal-open")
    }
  }
  stopPropagation(event) {
    event.stopPropagation()
  }
}