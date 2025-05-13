import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showTask(event) {
    const taskId = this.element.dataset.taskId
    const columnId = this.element.closest(".tasks-container").dataset.columnId
    
    fetch(`/columns/${columnId}/tasks/${taskId}`, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(r => {
        console.log("OIIIIII")
        return r.text()
      }
    )
    .then(html => 
      {
        console.log("OIIIIII")
        console.log(html)
        return Turbo.renderStreamMessage(html)
      }
      )
  }
  
  confirmDelete(event) {
    event.stopPropagation() 
    const taskId = this.element.dataset.taskId
    const modal = document.getElementById(`delete_task_modal_${taskId}`)
    // if (modal) {
    //   modal.showModal()
    // }
  }
  
  stopPropagation(event) {
    event.stopPropagation()
  }
}