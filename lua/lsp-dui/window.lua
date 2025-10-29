-- window.lua
local Shared = require "lsp-dui.shared"
local Constants = require "lsp-dui.constants"
local LDWindowIDPackage = require "lsp-dui.window_id_package"

---@class LDWindow
local LDWindow = { name = "LDWindow" }
LDWindow.__index = LDWindow
-- Prevent modification of properties by accident
LDWindow.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDWindow.__metatable = false

function LDWindow.new(orig_buf, orig_win, opts)
  ---@class LDWindow
  local o = setmetatable({}, LDWindow)

  -- Guardar los identificadores del buffer y ventana originales
  o._orig_buf = orig_buf
  o._orig_win = orig_win

  -- Creación de un buffer para nuestra ventana
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "nofile", { scope = "local", buf = buf })
  vim.api.nvim_buf_set_lines(buf, 0, 1, false, { " ⚡ LSP-DUI: Window Ready" })
  vim.api.nvim_buf_set_lines(buf, 1, 2, false, { "7:1: Primer error de la línea 7 descrito en ..." })
  vim.api.nvim_buf_set_lines(buf, 2, 3, false, { "      multilinea [errorKind]" })
  vim.api.nvim_buf_set_lines(buf, 3, 4, false, { "7:2: Segundo error de la línea 7 [errorKind]" })
  local last_error = "10: Error de una línea con solo un error [errorKind]"
  vim.api.nvim_buf_set_lines(buf, 4, 5, false, { last_error })
  -- Crear un namespace: sirve para agrupar highlights/extmarks
  -- y poder eliminarlos o modificarlos independientemente de otros
  local ns = vim.api.nvim_create_namespace "demo_ns"
  vim.api.nvim_set_hl(0, "MyRedText", { fg = 0xFF0000, bg = "NONE", bold = true })

  -- Mostrar un texto virtual rojo al final de la línea 2
  vim.api.nvim_buf_set_extmark(buf, ns, 2, 0, {
    virt_text = { { "Error!", "MyRedText" } }, -- "Error" es rojo por defecto
    virt_text_pos = "eol", -- posición al final de la línea
  })

  -- Crear un grupo de highlight que use colores del tema pero permita distinguir fg y bg
  -- vim.hl.range(buf, ns, "Visual", { 4, 0 }, { 4, 80 }) -- línea 4 completa
  -- vim.api.nvim_buf_set_extmark(buf, ns, 4, 0, {
  --   end_col = #last_error + 10, -- hasta donde quieras
  --   hl_group = "Visual",
  --   hl_eol = true, -- hace que el fondo se extienda hasta el final de la línea
  -- })
  -- define sign tipo
  vim.fn.sign_define("LastErrorSign", {
    text = "E", -- un espacio en la columna de signos
    -- texthl = "", -- sin color al texto del signo
    linehl = "Visual", -- fondo de toda la línea
    -- numhl = "", -- sin color en el número de línea
  })
  -- coloca la sign en la línea 5 (1‑based)
  vim.fn.sign_place(9999, "LDWindow", "LastErrorSign", buf, { lnum = 5 })

  -- Crear un namespace
  local ns_error = vim.api.nvim_create_namespace "error_ns"

  -- Aplicar el highlight solo a la línea 4
  vim.hl.range(buf, ns_error, "LastError", { 4, 0 }, { 4, 80 }) -- 80 = hasta columna arbitraria

  -- String es un highlight group predefinido en vim (en decay se ve verde)
  -- vim.hl.range(buf, ns, "String", { 0, 3 }, { 0, 12 }) -- El icono ocupa más espacio
  vim.api.nvim_set_option_value("modifiable", false, { scope = "local", buf = buf })

  -- Crear un namespace para el highlight parpadeante
  local blink_ns = vim.api.nvim_create_namespace "blink_demo"
  local line, start_col, end_col = 0, 3, 12
  local blink_on = true

  -- Función que alterna el highlight
  local count = 0
  local function blink()
    count = count + 1
    if blink_on then
      vim.hl.range(buf, blink_ns, "String", { line, start_col }, { line, end_col })
    else
      vim.api.nvim_buf_clear_namespace(buf, blink_ns, line, line + 1)
    end
    blink_on = not blink_on
    -- Vuelve a llamarse después de 500 ms
    if count > 10 then
      -- Detener el parpadeo después de 10 ciclos
      return
    end
    vim.defer_fn(blink, 500)
  end

  -- Iniciar el parpadeo
  vim.defer_fn(blink, 500)

  if buf == 0 then
    vim.notify("Failed to create buffer for diagnostic window.", vim.log.levels.ERROR)
    return nil
  end
  o._buf = buf

  -- Dimensiones del editor
  local columns = vim.o.columns
  local lines = vim.o.lines
  -- Dimensiones y posición de la ventana original
  local orig_width = vim.api.nvim_win_get_width(orig_win)
  local orig_height = vim.api.nvim_win_get_height(orig_win)
  local position = vim.api.nvim_win_get_position(orig_win)
  -- line empieza en 1, col en 0
  local pos = vim.api.nvim_win_get_position(orig_win)
  -- Cursor:
  -- local orig_cur_y, orig_cur_x = table.unpack(vim.api.nvim_win_get_cursor(orig_win))

  -- Creación de la ventana
  local target_win = opts and opts.target_win or orig_win
  ---@class vim.api.keyset.win_config
  local vim_win_config = {
    -- relative = "win",
    -- win = target_win,
    -- width = 50,
    -- height = 20,
    -- row = 5,
    -- col = 5,
    -- fixed = true,
    -- border = "single",
    split = "below",
    noautocmd = true, -- Evitar disparar autocmds al abrir la ventana
  }
  -- Abrimos la ventana con el buffer creado
  local win = vim.api.nvim_open_win(o._buf, false, vim_win_config)
  if win == 0 then
    vim.notify("Failed to create diagnostic window.", vim.log.levels.ERROR)
    return nil
  end

  -- Ocultar números de línea en la ventana diagnóstica
  -- vim.api.nvim_set_option_value("number", false, { scope = "local", win = win })
  -- vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = win })

  o._win = win

  -- DE MOMENTO NO LAS HEMOS USADO
  o._autofocus = opts and opts.autofocus or Constants.DEFAULT_OPTS.default_autofocus
  o._type = opts and opts.type or Constants.DEFAULT_OPTS.default_type
  o._order = opts and opts.order or Constants.DEFAULT_OPTS.default_order
  o._idpkg = LDWindowIDPackage.new(o._orig_buf, o._orig_win, o._buf, o._win)

  return o
end

function LDWindow:orig_buf()
  return self._orig_buf
end

function LDWindow:orig_win()
  return self._orig_win
end

function LDWindow:buf()
  return self._buf
end

function LDWindow:win()
  return self._win
end

function LDWindow:idpkg()
  return self._idpkg
end

function LDWindow:type()
  return self._type
end

function LDWindow:order()
  return self._order
end

return LDWindow
