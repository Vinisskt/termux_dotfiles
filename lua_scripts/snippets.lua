#!/usr/bin/env lua

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/zsh/lua_scripts/?.lua"
local snippets = require("list_snippets")

local config = {
  width = "40%",
  height = nil,
  x = "C",
  y = "30%",
  border = "double",
}


local input = arg[1]

-- tirar espaçoes vazios
local function trim(input)
  return (input:gsub("^%s*(.-)%s*$", "%1"))
end

local line_popup = function(content)
  local number_char = 0
  local height_dinamic = 1

  for i = 1, #content do
    number_char = number_char + 1
    if content:sub(i, i) == "\n" then
      height_dinamic = height_dinamic + 1
      number_char = 0
    end
  end

  config.height = height_dinamic + 3
end

-- verificar alias e verificar se tem o comando na tabela
local check_alias = function()
  local clean_text = trim(input)
  local last_word = string.match(clean_text, "([%a%d]+)%s*$")
  local text = ""
  if snippets[last_word] ~= nil then
    for k, v in pairs(snippets[last_word]) do
      text = text .. v .. "\n"
    end
    return text
  else
    return input
  end
end

-- busca os snippets e insere no shell
local search_snippets_fzf = function(text)
  local file_temp = os.tmpname()
  line_popup(text)
  local cmd = string.format(
    [[tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -E "printf '%%s' '%s' | fzf > '%s'"]],
    config.x, config.y, config.width, config.height, config.border, text, file_temp)

  os.execute(cmd .. " 2>&1")
  local file = io.open(file_temp, "r")
  if file == nil then
    return input
  end

  local result = file:read("*a")
  if result == "" then
    return input
  end

  file:close()
  os.remove(file_temp)
  return trim(result)
end

-- main

if input == "" or nil then
  return input
end

local alias = check_alias()
if alias then
  local text = search_snippets_fzf(alias)
  print(text)
end
