import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static targets = ["labelsList", "labelSelector", "addButton", "newLabelForm", "availableLabelsList"]
  
  connect() {
    console.log("Task Labels Controller conectado");
    
    // Adiciona event listeners para os seletores de cor
    document.querySelectorAll('.badge-color-selector').forEach(badge => {
      badge.addEventListener('click', () => {
        const radio = badge.previousElementSibling;
        radio.checked = true;
      });
    });
  }
  
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
      console.log(html)
      Turbo.renderStreamMessage(html);
      this.labelSelectorTarget.classList.remove("hidden");
    });
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
    .then(response => 
      {
        console.log("acelereou")
        return response.text()

      })
    .then(html => {
              console.log("tatoooo")
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
createLabel(event) {
    event.preventDefault();
    
    const form = this.newLabelFormTarget.querySelector('form');
    console.log(form)
    // Obter task_id do elemento HTML ou do data attribute
    // Podemos obter isso do formulário ou de um elemento oculto
    const taskIdElement = form.querySelector('input[name="task_id"]');
    const taskId = taskIdElement ? taskIdElement.value : form.dataset.taskId;
    
    // Obter board_id do URL atual
    const urlParts = window.location.pathname.split('/');
    const boardIdIndex = urlParts.indexOf('boards') + 1;
    const boardId = urlParts[boardIdIndex];
    console.log(boardId)
    console.log(taskId)
    if (!taskId || !boardId) {
      console.error('Task ID ou Board ID não encontrados');
      alert('Erro ao identificar a tarefa ou o quadro. Por favor, tente novamente.');
      return;
    }
    
    // Obter os dados do formulário
    const formData = new FormData(form);
    formData.append('task_id', taskId);
    
    // Obter o token CSRF
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    
    // Fazer a requisição AJAX
    fetch(`/boards/${boardId}/labels`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken,
        'Accept': 'application/json'
      },
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Limpar o formulário
        form.reset();
        
        // Esconder o formulário e mostrar a lista de etiquetas disponíveis
        this.newLabelFormTarget.classList.add("hidden");
        this.availableLabelsListTarget.classList.remove("hidden");
        
        // Atualizar a lista de etiquetas da tarefa
        this.updateTaskLabels(data.task_id, data.task_labels_html);
        
        // Atualizar a lista de etiquetas disponíveis
        this.updateAvailableLabels(data.task_id, data.available_labels_html);
      } else {
        // Exibir erros
        alert(data.errors.join(', '));
      }
    })
    .catch(error => {
      console.error('Erro ao criar etiqueta:', error);
      alert('Ocorreu um erro ao criar a etiqueta. Por favor, tente novamente.');
    });
  }
  
updateTaskLabels(taskId, html) {
  // Corrija o seletor para corresponder ao ID no seu HTML
  const taskLabelsContainer = document.getElementById(`task_labels_${taskId}`);
  if (taskLabelsContainer) {
    taskLabelsContainer.innerHTML = html;
  } else {
    console.error(`Elemento com ID task_labels_${taskId} não encontrado`);
  }
}
  
  updateAvailableLabels(taskId, html) {
    const availableLabelsContainer = document.getElementById(`available_labels_${taskId}`);
    if (availableLabelsContainer) {
      availableLabelsContainer.innerHTML = html;
    }
  }
}