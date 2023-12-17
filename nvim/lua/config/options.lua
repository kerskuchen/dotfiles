-- We can use the following for a description of all options:
-- :help options
-- We can also get a list of all settable options with
-- :set all

-- Set working directory to config file path
-- TODO: Later we want to check if our workind dir is the executable dir and only then change it to config dir
vim.cmd(":cd " .. vim.api.nvim_eval("stdpath('config')"))


----------------------------------------------------------------------------------------------------
-- Neovide GUI specific

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

----------------------------------------------------------------------------------------------------
-- Tabs and indentation

-- convert tabs to spaces when opening a file
vim.opt.expandtab = true                        
-- the number of spaces inserted for each indentation
vim.opt.shiftwidth = 2                          
-- insert 2 spaces for a tab
vim.opt.tabstop = 2                             
-- insert 2 spaces for a tab (insert mode)
vim.opt.softtabstop = 2                             
-- auto indent on newlines
vim.opt.smartindent = true                      

----------------------------------------------------------------------------------------------------
-- Search

-- highlight matches as we type
vim.opt.incsearch = true
-- highlight all matches on previous search pattern
vim.opt.hlsearch = true                         
-- ignore case in search patterns
vim.opt.ignorecase = true                       
-- override above ignore case option if uppercase letters were provided in the search pattern
vim.opt.smartcase = true                        

----------------------------------------------------------------------------------------------------
-- Visuals

-- the font used in graphical neovim applications
vim.opt.guifont = "Hack Nerd Font Mono:h14"
-- enable terminal colors (for terminals that support it)
vim.opt.termguicolors = true
-- always show document tabs
vim.opt.showtabline = 2                         
-- pop up menu height
vim.opt.pumheight = 10                          

-- set numbered lines
vim.opt.number = true                           
-- don't use relative numbered lines
vim.opt.relativenumber = false                  
-- set number column width
vim.opt.numberwidth = 4                         
-- show column line limiter
vim.opt.colorcolumn = "101"
-- always show the sign column (i.e. for debugger), otherwise it would shift the text each time
vim.opt.signcolumn = "yes"                      
-- more space in the command line for messages
vim.opt.cmdheight = 1
-- highlight the current line
vim.opt.cursorline = true                       

-- we don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false                        
-- make things like `` visible in markdown files
vim.opt.conceallevel = 0                        


--------------------------------------------------------------
-- Files

-- disable backup files
vim.opt.backup = false 
-- disables swapfile
vim.opt.swapfile = false                        
-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.writebackup = false                     
-- enable persistent undo
vim.opt.undofile = true                         
-- use system clipboard
vim.opt.clipboard = "unnamedplus"
-- default encoding
vim.opt.fileencoding = "utf-8"                  
-- don't automatically change working directory to the currently opened file
vim.opt.autochdir = false
-- make buffers editable
vim.opt.modifiable = true

----------------------------------------------------------------------------------------------------
-- Behavior

-- allow the mouse to be used in neovim
vim.opt.mouse = "a"                             
-- don't make noise
vim.opt.errorbells = false

-- force all horizontal splits to go below current window
vim.opt.splitbelow = true                       
-- force all vertical splits to go to the right of current window
vim.opt.splitright = true                       

-- if a buffer is abandoned it becomes 'hidden' instead of being unloaded and losing its undo history
vim.opt.hidden = true
-- disable line wrapping (we can always re-enable this with :set wrap or :set nowrap)
vim.opt.wrap = false                            
-- minimum number of screen lines to keep above and below the cursor for context
vim.opt.scrolloff = 8

-- makes words connected by `-` (like `hello-world`) be treated as whole for navigation/deletion
vim.opt.iskeyword:append("-")
-- disable autocomplete messages
vim.opt.shortmess:append "c"
-- better completion defaults. 
-- - menuone: shows completion even if only one item exist
-- - noselect: does not select a completion item by default
-- - noinsert: does not insert a completion item by default
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
-- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.timeoutlen = 1000                       
-- faster completion (4000ms default)
vim.opt.updatetime = 300                        
