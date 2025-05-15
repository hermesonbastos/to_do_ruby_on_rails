import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  confirmDelete(event) {
    const boardId = event.currentTarget.dataset.boardId
    const modal = document.getElementById(`delete_board_modal_${boardId}`)
    modal.classList.add("modal-open")
  }

  closeModal(event) {
    const boardId = event.currentTarget.dataset.boardId
    const modal = document.getElementById(`delete_board_modal_${boardId}`)
    modal.classList.remove("modal-open")
  }

  stopPropagation(event) {
    event.stopPropagation()
  }
}
