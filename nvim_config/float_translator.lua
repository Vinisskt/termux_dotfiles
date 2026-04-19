local state = {
  win = nil,
  buf = nil,
}

-- fechar janela
local close_win_buf = function()
  vim.api.nvim_win_close(state.win, true)
  state.win = nil
end

-- criar janela flutuante
local function create_window_float(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  if state.buf == nil then
    state.buf = vim.api.nvim_create_buf(false, true)
  end
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    border = "double",
    style = "minimal",
  }

  if state.win == nil then
    state.win = vim.api.nvim_open_win(state.buf, true, win_config)
  end

  vim.keymap.set("n", "<leader>qq", close_win_buf, { desc = "[T]ranslate [Q]uit" })

  vim.api.nvim_create_autocmd("BufWinLeave", {
    buffer = state.buf,
    callback = function()
      state.win = nil
      state.buf = nil
    end,
  })

  if state.buf ~= nil then
    vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, opts)
  end
end

local text_lines = function(line)
  local cursor = vim.fn.line(".")
  local text_buffer = vim.api.nvim_buf_get_lines(0, cursor, cursor + line, false)
  local text = table.concat(text_buffer, " ")

  return text
end

local function text_break(text)
  local number_char = 0
  local new_text = {}

  for i = 1, #text do
    number_char = number_char + 1
    if number_char > 60 and text:sub(i, i) == " " then
      table.insert(new_text, text:sub(i - number_char, i))
      number_char = 0
    end
  end
  return new_text
end

-- traduzir texto via gemini
local function translate_text(text)
  if text == "" then
    os.execute("tmux display-message -c 'red' 'texto vazio'")
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

local mainLines = function()
  local text = text_lines(30)
  if text and text ~= "" then
    local text_translate = translate_text(text)
    local new_text = text_break(text_translate)
    if text_translate then
      create_window_float(new_text)
    end
  end
end


local mainLine = function()
  local text = text_lines(0)
  if text and text ~= "" then
    local text_translate = translate_text(text)
    if text_translate then
      create_window_float(text_translate)
    end
  end
end

vim.keymap.set("n", "<leader>mb", mainLines, { desc = "[T]ranslator [B]uffer" })
vim.keymap.set("n", "<leader>ml", mainLine, { desc = "[T]ranslator [L]ine" })

return {}
