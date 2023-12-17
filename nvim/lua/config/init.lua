local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.globals")

local options = {
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "dracula" }
  },
  rtp = {
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrwPlugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    }
  },
  change_direction = {
    notify = true,
  },
}

-- Load all our plugins from the plugin directory
require("lazy").setup("plugins", options)

require("config.keymaps")