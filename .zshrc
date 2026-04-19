tmux

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# path 
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"

# path scripts .lua
path+=(~/.config/zsh/lua_scripts)
export PATH

# Carregar configuraçao zsh
for file in ~/.config/zsh/zsh_config/*.zsh; do
  [[ -f "$file" ]] && source "$file"
done


fzf_snippets() {
  prompt=$(~/.config/zsh/lua_scripts/snippets.lua "${LBUFFER}")
  LBUFFER=$prompt
  zle redisplay
}
zle -N fzf_snippets

bindkey '^z' fzf_snippets

export PATH="$HOME/.cargo/bin:$HOME/go/bin:$PATH"


