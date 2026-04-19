#!/usr/bin/env lua

local config = {
  width = "80%",
  height = "80%",
  x = "C",
  y = "33%",
  border = "double",
}

local create_popup_gemini = function()
  local pane = '#{pane_current_path}'
  local cmd_popup = string.format([[tmux new-session -d -s floating -c "%s" 'gemini']], pane)

  local cmd = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s 'tmux attach -t floating']],
    config.x, config.y, config.width, config.height, config.border)

  if (os.execute("tmux has-session -t floating 2>/dev/null") == 0) then
    os.execute(cmd)
  else
    os.execute(cmd_popup)
    os.execute(cmd)
  end
end

create_popup_gemini()
