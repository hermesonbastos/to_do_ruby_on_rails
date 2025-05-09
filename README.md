## 📦 Padrão de Commits – Conventional Commits

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
