import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["labelsList", "labelSelector", "addButton", "newLabelForm", "availableLabelsList"]
  
  connect() {}
  
  showLabelSelector(event) {
    event.preventDefault()
    
    const taskId = this.addButtonTarget.dataset.taskId
    const boardId = this.addButtonTarget.dataset.boardId
    
    if (!taskId) {
      alert("Salve a tarefa primeiro para adicionar etiquetas.")
      return
    }
    
    fetch(`/boards/${boardId}/labels?task_id=${taskId}`, {
      headers: {
        "Accept": "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      this.labelSelectorTarget.classList.remove("hidden")
    })
  }
  
  showNewLabelForm() {
    this.newLabelFormTarget.classList.remove("hidden")
    this.availableLabelsListTarget.classList.add("hidden")
  }

  cancelNewLabelForm() {
    this.newLabelFormTarget.classList.add("hidden")
    this.availableLabelsListTarget.classList.remove("hidden")
  }
  
  addLabel(event) {
    const taskId = event.currentTarget.dataset.taskId
    const labelId = event.currentTarget.dataset.labelId
    
    fetch(`/tasks/${taskId}/labels/${labelId}/add_to_task`, {
      method: "POST",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      this.showLabelSelector(new Event("click"))
    })
  }
  
  removeLabel(event) {
    const taskId = event.currentTarget.dataset.taskId
    const labelId = event.currentTarget.dataset.labelId
    
    fetch(`/tasks/${taskId}/labels/${labelId}/remove_from_task`, {
      method: "DELETE",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      if (!this.labelSelectorTarget.classList.contains("hidden")) {
        this.showLabelSelector(new Event("click"))
      }
    })
  }
  
  labelCreated(event) {
    this.newLabelFormTarget.classList.add("hidden")
    this.availableLabelsListSectionTarget.classList.remove("hidden")

    const { success } = event.detail[0] || { success: false }

    if (success !== false) {
      this.newLabelFormTarget.classList.add("hidden")
    }

    this.showLabelSelector(new Event("click"))
    this.newLabelFormTarget.classList.add("hidden")
  }
}