# 🧾 ToDone

> Aplicação Rails desenvolvida com o objetivo de aumentar a sua produtividade nas tarefas mais importantes com simplicidade, design agradável e integração com seu Google Calendar.

---

## 📚 Índice

- [🔍 Sobre o Projeto](#-sobre-o-projeto)
- [🛠️ Tecnologias Utilizadas](#️-tecnologias-utilizadas)
- [▶️ Como Executar o Projeto](#️-como-executar-o-projeto)
- [📦 Padrões de Contribuição – Conventional Commits e HermesonFlow](#-padrões-de-contribuição)
- [🏗️ Arquitetura e Funcionalidades](#️-arquitetura-e-funcionalidades)

---

## 🔍 Sobre o Projeto

O projeto consiste basicamente em um sistema com múltiplos usuários, cada um pode criar seus quadros (boards), e dentro desses boards que são uma espécie de Kanban customizável.

### Principais Telas

![alt text](image.png)
![alt text](image-1.png)
![alt text](image-3.png)
![alt text](image-2.png)
![alt text](image-4.png)


---

## 🛠️ Tecnologias Utilizadas

- [Ruby 3.2.2](https://www.ruby-lang.org/pt/)
- [Rails 8.0.2](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [DaisyUI](https://daisyui.com/)

---

## ▶️ Como Instalar e Executar o Projeto

**Pré-requisitos:**

- Ruby, Rails, PostgreSQL e npm instalados

```bash
# Clone o projeto
git clone https://github.com/hermesonbastos/to_do_ruby_on_rails
cd nome-do-repo

# Instale as dependências (sem as de ambiente de testes pois algumas exigem outras instalações)
bundle install --without development test

# Instale as dependências
npm install

# Configure o banco de dados
rails db:create db:migrate db:seed

# Rode o servidor
rails server

# Se for contribuir com novos estilos execute, para o live reload do Tailwind
rails tailwindcss:watch
```

## 📦 Padrões de Contribuição

### Conventional Commits e HermesonFlow (minha releitura do GitFlow rs)

Para manter o histórico do projeto organizado, adotei o padrão [**Conventional Commits**](https://www.conventionalcommits.org/) pois é o que eu mais tive contato desde as minhas primeiras experiências e acho muito funcional pois consigo expressar com clareza o conteúdo de cada commit sem muito aprofundamento.

### 🛠️ Como escrever sua mensagem de commit

Sempre use este formato:

```
<tipo>(optional scope): short message
```

**Exemplo:**

```
feat(auth): add logout button
```

---

### ✅ Tipos principais

| Tipo              | Emoji | Descrição                                                                                                      |
| ----------------- | :---: | -------------------------------------------------------------------------------------------------------------- |
| `feat`            |   ✨   | Adiciona uma nova funcionalidade.                                                                              |
| `fix`             |   🐛  | Corrige um bug.                                                                         

---

### 🔧 Tipos complementares

| Tipo       | Emoji | Descrição                                                  |
| ---------- | :---: | ---------------------------------------------------------- |
| `docs`     |   📝  | Mudanças na documentação.                                  |
| `style`    |   💄  | Ajustes de estilo (sem impacto na lógica).                 |
| `refactor` |   ♻️  | Refatoração de código sem alterar comportamento.           |
| `test`     |   ✅   | Adição ou modificação de testes.                           |
| `chore`    |   🧹  | Tarefas de manutenção que não afetam o código em produção. |
| `perf`     |   ⚡️  | Otimizações de performance.                                |

---

### 💡 Boas práticas

* Use verbos no imperativo (ex: "add", "fix", "update").
* O escopo entre parênteses é opcional, mas útil (ex: `feat(login)`).

Seguindo esse padrão, você colabora com minha saúde mental rs. Obrigado por contribuir! 🚀

### 🌳 Como criar sua branch

Optei por uma versão customizada (vou chamar de HermesonFlow rs) do [**GitFlow**](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) pois também já tenho familiaridade e assim como o Conventional Commits, deixa bem claro o papel daquela branch, sem a necessidade de abrir o código.

##### ⚙️ Branches Principais

* **`main`:** Representa a versão estável e pronta para produção, apenas recebe merge da `develop`.
* **`develop`:** É a branch principal de integração. Todo o trabalho será mandado pra cá, nada de commits na `main`.

##### 🌿 Branches de Suporte

São branches temporárias criadas para trabalhos específicos e depois são mergeadas de volta às branches principais.

* **`feature/<nome-da-feature>`:** Usada para desenvolver novas funcionalidades. Cada nova funcionalidade deve ter sua própria branch a partir da `develop`. Depois de concluída, ela é mergeada de volta na `develop`.
* **`update/<nome-da-alteração>`:** Essa não existe originalmente no GitFlow, mas você pode utilizá-la para explicitar alterações em features já consolidadas.
* **`fix/<bug-corrigido>`:** Essa também não existe originalmente no GitFlow, costumo utilizar para representar correções feitas em features ou em updates que ainda não foram mandadas para a `main`.
* **`hotfix/<bug-corrigido>`:** Usada para resolver os "BO's" em produção, deve ser criada sempre à partir da `main`, e mergeada para a main e para a `develop` para garantir que esse bug não ocorra mais nem no ambiente de desenvolvimento.

Seguir o HermesonFlow me ajuda a manter o código organizado, ter menos dor de cabeça e entender o fluxo do projeto rapidamente!😉

# 🏗️ Arquitetura e Funcionalidades
![alt text](image-5.png)

## Principais Funcionalidades

* Criar conta
* Realizar Login
* Realizar Logout
* CRUD Quadros
* CRUD Colunas
* CRUD Tarefas
* CRUD Etiquetas
* Agendar uma tarefa no Google Calendar
* Visualizar Métricas

# Muito obrigado por chegar até aqui! 😄

Este projeto é fruto de muita curiosidade, café ☕ e vontade de criar algo útil e bonito. Se você gostou do ToDone e tem alguma sugestão de melhorai, sugestões de melhorias !

📬 Entre em contato:

[💼 LinkedIn] (https://www.linkedin.com/in/hermeson-bastos-632578226/)

📧 hermesonbastos@gmail.com

Fique à vontade para abrir issues, contribuir ou simplesmente dar uma estrela ⭐ no projeto!
