-- Global keymaps (leader = space).
--
-- Convention for <leader> prefixes. Plugin files register their own keys under
-- the same prefixes, and which-key.lua names every group.
--
--   <leader>b  Buffer        <leader>q  Quit
--   <leader>c  Code / LSP    <leader>r  Rust       (crates in Cargo.toml)
--   <leader>d  Debug
--   <leader>f  Find files    <leader>s  Search     (grep, symbols, help, ...)
--   <leader>g  Git           <leader>t  Terminal   (<c-/> toggles, count picks which)
--   <leader>T  Test
--   <leader>gh Git hunks     <leader>u  UI toggles
--   <leader>w  Window        <leader>x  Diagnostics / lists
--
--   g*  goto (gd, gD, gI, gy, grr, grn, gra)     gs*  surround
--   ]x / [x  next / prev x  (b buffer, d diag, e error, h hunk, q qf, t todo)

local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Save / quit --------------------------------------------------------------
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")
map("n", "<leader>qq", "<cmd>qa<cr>", "Quit all")
map("n", "<leader>qQ", "<cmd>qa!<cr>", "Quit all (discard changes)")

-- Windows -------------------------------------------------------------------
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")
map("n", "<leader>ww", "<C-w>p", "Other window")
map("n", "<leader>wd", "<C-w>c", "Close window")
map("n", "<leader>wo", "<C-w>o", "Close other windows")
map("n", "<leader>w-", "<C-w>s", "Split below")
map("n", "<leader>w|", "<C-w>v", "Split right")
map("n", "<leader>w=", "<C-w>=", "Equalise windows")
map("n", "<leader>wH", "<C-w>H", "Move window to far left")
map("n", "<leader>wJ", "<C-w>J", "Move window to bottom")
map("n", "<leader>wK", "<C-w>K", "Move window to top")
map("n", "<leader>wL", "<C-w>L", "Move window to far right")
map("n", "<leader>wx", "<C-w>x", "Swap with next window")
map("n", "<leader>-", "<C-w>s", "Split below")
map("n", "<leader>|", "<C-w>v", "Split right")

-- Buffers -------------------------------------------------------------------
-- (bufferline.lua adds <S-h>/<S-l>, [b/]b, pin and close-others)
map("n", "<leader>bb", "<cmd>e #<cr>", "Switch to last buffer")
map("n", "<leader>`", "<cmd>e #<cr>", "Switch to last buffer")
map("n", "<leader>bn", "<cmd>enew<cr>", "New empty buffer")
map("n", "<leader>bD", "<cmd>bd<cr>", "Delete buffer and window")

-- Editing -------------------------------------------------------------------
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")
map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>", "Redraw / clear highlight")
-- Move lines. No Alt keys: Alt is taken by AeroSpace. In visual mode J/K
-- move the selection (use gJ to join lines while in visual mode).
map("n", "<S-Down>", "<cmd>m .+1<cr>==", "Move line down")
map("n", "<S-Up>", "<cmd>m .-2<cr>==", "Move line up")
map("i", "<S-Down>", "<esc><cmd>m .+1<cr>==gi", "Move line down")
map("i", "<S-Up>", "<esc><cmd>m .-2<cr>==gi", "Move line up")
map("v", "<S-Down>", ":m '>+1<cr>gv=gv", "Move selection down")
map("v", "<S-Up>", ":m '<-2<cr>gv=gv", "Move selection up")
map("v", "J", ":m '>+1<cr>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<cr>gv=gv", "Move selection up")
map("v", "<", "<gv", "Indent left (keep selection)")
map("v", ">", ">gv", "Indent right (keep selection)")
map("n", "J", "mzJ`z", "Join lines (keep cursor)")
map("n", "n", "nzzzv", "Next match (centred)")
map("n", "N", "Nzzzv", "Prev match (centred)")
map("n", "<C-d>", "<C-d>zz", "Half page down (centred)")
map("n", "<C-u>", "<C-u>zz", "Half page up (centred)")
map("x", "p", '"_dP', "Paste without yanking selection")
-- Undo break-points so a long insert can be undone in sensible chunks.
map("i", ",", ",<c-g>u", "")
map("i", ".", ".<c-g>u", "")
map("i", ";", ";<c-g>u", "")

-- Diagnostics / lists --------------------------------------------------------
local diag_jump = function(count, severity)
  return function()
    vim.diagnostic.jump({ count = count, float = true, severity = severity and vim.diagnostic.severity[severity] })
  end
end
map("n", "]d", diag_jump(1), "Next diagnostic")
map("n", "[d", diag_jump(-1), "Prev diagnostic")
map("n", "]e", diag_jump(1, "ERROR"), "Next error")
map("n", "[e", diag_jump(-1, "ERROR"), "Prev error")
map("n", "]w", diag_jump(1, "WARN"), "Next warning")
map("n", "[w", diag_jump(-1, "WARN"), "Prev warning")
map("n", "]q", "<cmd>cnext<cr>", "Next quickfix item")
map("n", "[q", "<cmd>cprev<cr>", "Prev quickfix item")

-- Terminal ------------------------------------------------------------------
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")
map("t", "<C-h>", "<cmd>wincmd h<cr>", "Go to left window")
map("t", "<C-j>", "<cmd>wincmd j<cr>", "Go to lower window")
map("t", "<C-k>", "<cmd>wincmd k<cr>", "Go to upper window")
map("t", "<C-l>", "<cmd>wincmd l<cr>", "Go to right window")

-- Misc ------------------------------------------------------------------------
map("n", "<leader>l", "<cmd>Lazy<cr>", "Lazy (plugin manager)")
map("n", "<leader>fn", "<cmd>enew<cr>", "New file")
