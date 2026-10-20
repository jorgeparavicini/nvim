-- Helpers around Snacks.terminal for a numbered, per-directory terminal set.
-- Snacks keys terminals by (cmd, cwd, count); plain shells have cmd = nil.

local M = {}

local positions = {
  bottom = { position = "bottom", height = 0.35 },
  right = { position = "right", width = 0.4 },
  float = { position = "float" },
}

--- Plain shell terminals for the current directory, as { win, id } pairs.
local function shells()
  local cwd = vim.fn.getcwd(0)
  local out = {}
  for _, t in ipairs(Snacks.terminal.list()) do
    local info = vim.b[t.buf].snacks_terminal or {}
    if info.cmd == nil and (info.cwd or cwd) == cwd then
      table.insert(out, { win = t, id = info.id })
    end
  end
  table.sort(out, function(a, b)
    return (a.id or 0) < (b.id or 0)
  end)
  return out
end

--- Open a fresh shell with the lowest unused number.
---@param where "bottom"|"right"|"float"
function M.new(where)
  local used = {}
  for _, s in ipairs(shells()) do
    used[s.id] = true
  end
  local n = 1
  while used[n] do
    n = n + 1
  end
  Snacks.terminal.toggle(nil, { count = n, win = positions[where] })
end

--- Pick one of the open terminals (any cwd, any command) and focus it.
function M.pick()
  local items = {}
  for _, t in ipairs(Snacks.terminal.list()) do
    local info = vim.b[t.buf].snacks_terminal or {}
    local title = vim.b[t.buf].term_title or ""
    local cmd = info.cmd and (type(info.cmd) == "table" and table.concat(info.cmd, " ") or info.cmd) or "shell"
    table.insert(items, {
      text = string.format("%d  %s  %s  %s", info.id or 0, cmd, title, vim.fn.fnamemodify(info.cwd or "", ":~")),
      buf = t.buf,
      term = t,
      id = info.id or 0,
    })
  end
  if #items == 0 then
    return vim.notify("No terminals open", vim.log.levels.INFO)
  end
  table.sort(items, function(a, b)
    return a.id < b.id
  end)
  Snacks.picker({
    title = "Terminals",
    items = items,
    format = "text",
    preview = "file",
    layout = { preset = "vscode" },
    confirm = function(picker, item)
      picker:close()
      if item then
        item.term:show():focus()
      end
    end,
  })
end

--- Kill the terminal under the cursor: closes the window and its process.
function M.kill()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= "terminal" then
    return vim.notify("Not in a terminal", vim.log.levels.WARN)
  end
  vim.api.nvim_buf_delete(buf, { force = true })
end

--- Prompt for a shell command and run it in a new bottom terminal that stays
--- open after the command exits (q hides it, <leader>tk kills it).
function M.run()
  Snacks.input({ prompt = "Run in terminal" }, function(cmd)
    if not cmd or cmd == "" then
      return
    end
    Snacks.terminal.open({ vim.o.shell, "-lc", cmd .. "; echo; echo '[exit ' $? ']'; exec " .. vim.o.shell }, {
      win = positions.bottom,
      start_insert = false,
      auto_close = false,
    })
  end)
end

return M
