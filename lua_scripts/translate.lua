#!/usr/bin/env lua

local config = {
  width = "80%",
  height = nil,
  x = "C",
  y = "80%",
  border = "double",
}

-- redimensionar pop up do tmux
local function table_popup_config(content)
  local height_dinamic = 0
  local number_char = 0
  local text = ""

  for i = 1, #content do
    number_char = number_char + 1
    if number_char < 70 and content:sub(i, i) == "\n" then
      text = text .. content:sub(i - number_char, i)
      height_dinamic = height_dinamic + 1
      number_char = 0
    end

    if number_char > 70 and content:sub(i, i) == " " then
      text = text .. content:sub(i - number_char, i) .. "\n"
      height_dinamic = height_dinamic + 1
      number_char = 0
    end
  end

  config.height = height_dinamic + 2
  return text
end


-- criar pop up via tmux
local create_popup = function(translate)
  local safe_translate = translate:gsub("['\"%(%)%`]", "")
  local cmd = string.format(
    'tmux display-popup -s "bg=black,fg=white" -S "fg=black" -x %s -y %s -w %s -h %s -b %s -E "echo \'%s\' | less; echo ; read"',
    config.x, config.y,
    config.width, config.height, config.border, safe_translate)
  return cmd
end

local function read_clipBoard()
  local read_content = io.popen("termux-clipboard-get")
  if not read_content then
    os.execute("tmux display-message -c 'red' 'erro na leitura'")
    return nil
  end

  local content = read_content:read("*a")

  read_content:close()
  return content .. "\n"
end

-- traduzir texto via gemini
local function translate_text(text)
  if text == "" then
    os.execute("tmux display-message -c 'red' 'area de tranferencia vazia'")
    return nil
  end

  local safe_text = text:gsub("'", "'\\''")
  local prompt = "Traduza o seguinte texto para português brasileiro. Retorne apenas a tradução, sem comentários extras: " .. safe_text

  local cmd = string.format("echo '%s' | gemini", prompt:gsub("'", "'\\''"))

  local pipe = io.popen(cmd, "r")
  if not pipe then
    os.execute("tmux display-message -c 'red' 'traduçao falhou'")
    return nil
  end

  local result = pipe:read("*a")
  pipe:close()
  if result == "" then return nil end

  local clean = result:gsub("[@#]", ""):gsub("^%s*(.-)%s*$", "%1")
  return clean
end

-- principal
local content = read_clipBoard()
local text = table_popup_config(content)
if content and content ~= "" then
  local translate = translate_text(text)
  if translate then
    local cmd = create_popup(translate)
    os.execute(cmd)
  end
end
