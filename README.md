# 💻 Meus Dotfiles - Termux & Productivity Hub

Este repositório contém meu ambiente de desenvolvimento otimizado para **Termux** (Android), focado em produtividade máxima com **Tmux**, **Zsh** e inteligência artificial via **Gemini CLI**.

## 🛠️ Stack Principal
- **Terminal:** Termux (Android)
- **Multiplexador:** Tmux (O centro das operações)
- **Shell:** Zsh com Oh My Zsh e Powerlevel10k
- **Editor:** Neovim (LazyVim base)
- **IA:** Gemini CLI (Integrado em scripts Lua)

---

## 🚀 Funcionalidades Customizadas (Scripts Lua)

O diferencial deste setup são os scripts Lua que automatizam tarefas e integram o Gemini diretamente no workflow.

### 🧠 O "Modo Lua" no Tmux (`Ctrl + a`)
O atalho global `Ctrl + a` no Tmux ativa um mapa de comandos dedicado para ferramentas em janelas flutuantes (popups).

| Atalho | Comando / Script | Descrição |
| :--- | :--- | :--- |
| `^a + C-t` | `translate.lua` | Traduz o clipboard (Termux) via Gemini e exibe em um popup. |
| `^a + g` | `gemini_float.lua` | Abre uma instância flutuante do Gemini CLI. |
| `^a + a` | `auto_anotation.lua` | Captura conteúdo web via URL e gera anotações estruturadas no Caderno Pessoal. |
| `^a + l` | `popup_util.lua lazy_git` | LazyGit em popup. |
| `^a + d` | `popup_util.lua lazy_docker` | LazyDocker em popup. |
| `^a + n` | `popup_util.lua nvim` | Neovim (diretório atual) em popup. |
| `^a + h` | `popup_util.lua zsh_history` | Histórico do Zsh com FZF que envia o comando para o painel ativo. |
| `^a + m` | `popup_util.lua tldr` | Consulta rápida ao `tldr` com preview do `bat`. |

### 🔍 Sistema de Snippets (`Ctrl + z` no Zsh)
Ao pressionar `Ctrl + z` no terminal, o sistema de snippets é acionado:
- Filtra comandos frequentes (Git, Maven, Docker, DB) usando FZF.
- Se o comando exigir argumentos, ele permite a edição antes da execução.
- Configurado em `lua_scripts/list_snippets.lua`.

---

## ⌨️ Atalhos Essenciais (Keybindings)

### Tmux
- **Prefix Principal:** `Ctrl + Space`
- **Navegação:** `Ctrl + h, j, k, l` (Panes), `h / l` (Windows anterior/próxima)
- **Modo de Cópia:** `v` para selecionar, `y` para copiar (estilo Vim).
- **Recarregar:** `prefix + r`

### Neovim
- `jk`: Atalho para `<Esc>` em modo de inserção e terminal.
- `<leader>mt`: Abre terminal interno.
- `<leader>mb`: Traduz o buffer atual via Gemini em uma janela flutuante.
- `<leader>ml`: Traduz a linha atual.

---

## 📁 Estrutura do Projeto
- `.tmux.conf`: Configurações de comportamento, plugins e o `prefix-lua`.
- `.zshrc`: Inicialização do shell e integração com scripts Lua.
- `lua_scripts/`: 
    - `popup_util.lua`: Motor genérico para popups do Tmux.
    - `translate.lua`: Integrador de tradução com `termux-clipboard`.
    - `auto_anotation.lua`: Web scraper + Resumo via IA.
- `zsh_config/`: Aliases e configurações modulares do Zsh.

---

## 🔧 Notas de Instalação no Termux
1. **Dependências:** `tmux`, `zsh`, `fzf`, `bat`, `eza`, `gum`, `w3m`, `curl`.
2. **Termux:API:** Necessário para `termux-clipboard-get` funcionar.
3. **Gemini CLI:** Deve estar configurado e no PATH para os scripts de IA funcionarem.
4. **Fontes:** Utilize uma Nerd Font no app do Termux para ver os ícones corretamente.
