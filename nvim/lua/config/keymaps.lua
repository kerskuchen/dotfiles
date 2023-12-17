-- Keycodes can be found in https://neovim.io/doc/user/intro.html#key-codes

-- Modes:
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

local optsNone = {}
local optsSilent = { silent = true}
local optsNonRecursiveAndSilent = { noremap = true, silent = true}
local optsNonRecursive = { noremap = true }


local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function startswith(text, prefix)
    return text:find(prefix, 1, true) == 1
end

local nvimTreeAPI = require("nvim-tree.api")
function ToggleExplorer() 
  if nvimTreeAPI.tree.is_visible() then
    local curBufferName = vim.api.nvim_buf_get_name(0)
    nvimTreeAPI.tree.close_in_all_tabs()
    if startswith(curBufferName, "NvimTree") then
      -- also close the split where the explorer was in because we don't want that weird vertical 
      -- split to stay open. Apparently `nvimTreeAPI.tree.close_in_all_tabs()` does only close the 
      -- buffer and not the split it is contained in
      vim.api.nvim_win_close()
    end
  else
    nvimTreeAPI.tree.open()
  end
end


local commentAPI = require("Comment.api")
function ToggleLineComment()
  commentAPI.toggle()
end

-- -- Debugstuff
-- function WriteTextAtCursor(text)
--   -- Get row and column cursor, use unpack because it's a tuple.
--   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--   -- Notice the text is given as an array parameter, you can pass multiple strings.
--   -- Params 2-5 are for start and end of row and columns.
--   -- See earlier docs for param clarification or `:help nvim_buf_set_text.
--   vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { text })
-- end
-- 
-- function GetCurrentWindowProperties()
--   local win_number = vim.api.nvim_get_current_win()
--   local v = vim.wo[win_number]
--   local all_options = vim.api.nvim_get_all_options_info()
--   local result = ""
--   for key, val in pairs(all_options) do
--       if val.global_local == false and val.scope == "win" then
--           result = result .. " | " .. key .. "=" .. tostring(v[key] or "<not set>")
--       end
--   end
--   WriteTextAtCursor(result)
-- end
-- 
-- vim.keymap.set("n", "<M-p>", GetCurrentWindowProperties, optsNonRecursiveAndSilent)

--------------------------------------------
-- Modern Default Editor Shortcuts

-- Undo / Redo
vim.keymap.set("n", "<C-z>", ":undo<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("i", "<C-z>", "<ESC>:undo<CR>i", optsNonRecursiveAndSilent)
vim.keymap.set("n", "<C-y>", ":redo<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("i", "<C-y>", "<ESC>:redo<CR>i", optsNonRecursiveAndSilent)

-- Paste
vim.keymap.set("i", "<C-v>", "<ESC>pi", optsNonRecursiveAndSilent)

-- Saving
vim.keymap.set("n", "<C-s>", ":w<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>i", optsNonRecursiveAndSilent)

-- Searching
vim.keymap.set("n", "<C-f>", "/", optsNonRecursive)
vim.keymap.set("n", "<C-f>", "<ESC>/", optsNonRecursive)
vim.keymap.set("n", "<f3>", "n", optsNonRecursive)
vim.keymap.set("n", "<s-F3>", "N", optsNonRecursive)

--------------------------------------------
-- Explorer

vim.keymap.set("n", "<M-e>", ToggleExplorer, optsNonRecursiveAndSilent)
vim.keymap.set("n", "<leader>te", ToggleExplorer, optsNonRecursiveAndSilent)
vim.keymap.set("n", "<leader>fc", ":cd %:h<CR>", optsNonRecursiveAndSilent) -- Goto current files working directory

--------------------------------------------
-- Navigation

vim.keymap.set("n", "<M-u>", "<C-u>", optsNonRecursiveAndSilent) -- Scroll up
vim.keymap.set("n", "<M-d>", "<C-d>", optsNonRecursiveAndSilent) -- Scroll down
vim.keymap.set("v", "<M-u>", "<C-u>", optsNonRecursiveAndSilent) -- Scroll up
vim.keymap.set("v", "<M-d>", "<C-d>", optsNonRecursiveAndSilent) -- Scroll down
vim.keymap.set("x", "<M-u>", "<C-u>", optsNonRecursiveAndSilent) -- Scroll up
vim.keymap.set("x", "<M-d>", "<C-d>", optsNonRecursiveAndSilent) -- Scroll down

--------------------------------------------
-- Commenting

-- apparently non of this shit is working to just rebind to comment out a line - yeah in 2023
-- vim.keymap.set("n", "<C-/>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("v", "<C-/>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("n", "<C-?>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("v", "<C-?>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("n", "<C-_>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("v", "<C-_>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("n", "<C-_>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("n", "<C-s-/>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
-- vim.keymap.set("v", "<C-s-/>", "gcc", optsNonRecursiveAndSilent) -- NOTE 'gcc' provided by comment plugin
vim.keymap.set("n", "<leader>kk", "gcc", optsNonRecursive) -- NOTE 'gcc' provided by comment plugin
vim.keymap.set("v", "<leader>kk", "gcc", optsNonRecursive) -- NOTE 'gcc' provided by comment plugin

------------------------------------------
-- Splits

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", optsNonRecursiveAndSilent) -- Split vertically
vim.keymap.set("n", "<leader>sh", ":hsplit<CR>", optsNonRecursiveAndSilent) -- Split horizontally
vim.keymap.set("n", "<leader>sc", ":close<CR>", optsNonRecursiveAndSilent) -- Close split

-- Better window-split navigation
vim.keymap.set("n", "<M-1>", "<C-w>h", optsNonRecursiveAndSilent) -- Navigate left
vim.keymap.set("n", "<M-2>", "<C-w>l", optsNonRecursiveAndSilent) -- Navigate right

vim.keymap.set("n", "<C-h>", "<C-w>h", optsNonRecursiveAndSilent) -- Navigate left
vim.keymap.set("n", "<C-l>", "<C-w>l", optsNonRecursiveAndSilent) -- Navigate right
vim.keymap.set("n", "<C-k>", "<C-w>k", optsNonRecursiveAndSilent) -- Navigate up
vim.keymap.set("n", "<C-j>", "<C-w>j", optsNonRecursiveAndSilent) -- Navigate down

-- Resize window-splits with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", optsNonRecursiveAndSilent)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", optsNonRecursiveAndSilent)

--------------------------------------------
-- Visual mode

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", optsNonRecursiveAndSilent)
vim.keymap.set("v", ">", ">gv", optsNonRecursiveAndSilent)

-- Move selected text block up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", optsNonRecursiveAndSilent)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", optsNonRecursiveAndSilent)

-- If we overwrite a selection by copy and pasting over it,
-- we don't want the selection to overwrite our clipboard
vim.keymap.set("v", "p", '"_dP', optsNonRecursiveAndSilent)

--------------------------------------------
-- Visual block mode

-- Move selected text block up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", optsNonRecursiveAndSilent)
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", optsNonRecursiveAndSilent)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", optsNonRecursiveAndSilent)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", optsNonRecursiveAndSilent)

--------------------------------------------
-- Terminal mode

-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", optsSilent)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", optsSilent)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", optsSilent)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", optsSilent)
