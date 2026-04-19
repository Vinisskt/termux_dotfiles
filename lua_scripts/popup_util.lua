#!/usr/bin/env lua

local config = {
  width = "90%",
  height = "90%",
  x = "C",
  y = "40%",
  border = "rounded",
  window_fzf = "80%"
}

local list_cmd = {
  ["nvim"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' -E 'fzf --preview "bat --color=always --style=numbers --line-range :500 {}" --preview-window=bottom:80%%:border-top --layout=reverse --prompt="Files > " --border=rounded | xargs nvim']],
    config.x, config.y, config.width, config.height, config.border),

  ["nvim_home"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d %s -E 'fzf --preview "bat --color=always --style=numbers --line-range :500 {}" --preview-window=bottom:80%%:border-top --layout=reverse --prompt="Files > " --border=rounded | xargs nvim']],
    config.x, config.y, config.width, config.height, config.border, os.getenv("HOME")),

  ["bat"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' 'fzf --preview "bat --color=always {}" --preview-window=right:"%s" | xargs bat']],
    config.x, config.y, config.width, config.height, config.border, config.window_fzf),

  ["mvn_test"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' -E 'zsh -c "mvn test -Dstyle.color=always 2>&1 | less -R"']],
    config.x, config.y, config.width, config.height, config.border),

  ["lazy_git"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' -E lazygit]],
    config.x, config.y, config.width, config.height, config.border),

  ["htop"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' htop]],
    config.x, config.y, config.width, config.height, config.border),

  ["lazy_docker"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -d '#{pane_current_path}' lazydocker]],
    config.x, config.y, config.width, config.height, config.border),

  ["tldr"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s "tldr --list | fzf --preview 'tldr {} | bat --color=always' --preview-window=right:70%% | xargs tldr | bat --color=always"]],
    config.x, config.y, config.width, config.height, config.border),

  ["zsh_history"] = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -E "cat ~/.zsh_history | sed 's/^: [0-9]*:[0-9]*;//' | fzf --layout=reverse --prompt='History > ' --border=rounded --tac | xargs -I {} tmux send-keys -t ! '{}'"]],
    config.x, config.y, config.width, config.height, config.border),

}

local run_command = function()
  os.execute(list_cmd[arg[1]])
end

run_command()
