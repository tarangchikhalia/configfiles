-- Disable legacy remote providers — all plugins here are pure Lua.
-- Re-enable any you need by removing the corresponding line.
vim.g.loaded_perl_provider   = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider   = 0

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Backspace behaviour
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10

-- UI
opt.showmode = false    -- shown by lualine instead
opt.ruler = false
opt.laststatus = 3      -- global statusline
opt.showcmdloc = "statusline"

-- Mouse
opt.mouse = "a"

-- Fold (using treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false  -- open all folds by default
opt.foldlevel = 99

-- Fillchars
opt.fillchars = {
  foldopen = "▾",
  foldclose = "▸",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Spell (disabled by default, toggle with <leader>us)
opt.spelllang = { "en" }

-- Virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
})
