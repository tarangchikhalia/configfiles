# Neovim Configuration

A modern Neovim setup built for productive software development. Powered by [lazy.nvim](https://github.com/folke/lazy.nvim) with the [GitHub theme](https://github.com/projekt0n/github-nvim-theme).

## Appearance

On macOS, Neovim follows the system appearance automatically: `github_dark`
for dark mode and `github_light` for light mode. It checks at startup, when
Neovim regains focus, and every three seconds while running.

Use `:Theme light` or `:Theme dark` to override appearance for the current session,
and `:Theme auto` to resume following macOS. On other platforms, the initial
theme follows Neovim's `background` option; manual commands are available.

## Requirements

- **Neovim** >= 0.9 (0.10+ recommended for inlay hints)
- **Git** — for lazy.nvim bootstrap and plugins
- **Node.js** — for TypeScript/JavaScript LSP
- **Python 3** — for Python LSP and DAP
- **Go** — for Go LSP and DAP
- **`lazygit`** — for `<leader>gg` git UI (install via Homebrew: `brew install lazygit`)
- **`ripgrep`** (`rg`) — for Telescope live grep (`brew install ripgrep`)
- **`fd`** — for Telescope file finding (`brew install fd`)
- **A [Nerd Font](https://www.nerdfonts.com/)** — for icons (e.g., JetBrainsMono Nerd Font)
- **`make`** — to build the fzf native Telescope extension

## First Launch

On first launch, lazy.nvim will auto-install itself and all plugins. Run `:Mason` afterward to install LSP servers, formatters, and linters.

```
nvim
:Lazy           # verify plugins installed
:Mason          # install LSP servers / formatters
:checkhealth    # check for any issues
```

---

## Architecture

```
~/.config/nvim/
├── init.lua                  # Entry point: bootstraps lazy.nvim
├── lua/
│   ├── config/
│   │   ├── options.lua       # Editor options
│   │   ├── keymaps.lua       # Base keymaps (no plugins)
│   │   └── autocmds.lua      # Autocommands
│   └── plugins/
│       ├── colorscheme.lua   # GitHub light/dark themes
│       ├── ui.lua            # Statusline, bufferline, notifications, dashboard
│       ├── editor.lua        # Autopairs, surround, comments, which-key, flash
│       ├── treesitter.lua    # Syntax highlighting + text objects
│       ├── telescope.lua     # Fuzzy finder + find & replace
│       ├── neo-tree.lua      # File explorer
│       ├── lsp.lua           # LSP, formatting, linting
│       ├── completion.lua    # nvim-cmp + snippets
│       ├── git.lua           # Gitsigns, Lazygit, Diffview
│       ├── debug.lua         # DAP debugger
│       ├── terminal.lua      # Toggleterm
│       └── harpoon.lua       # Quick file marks
└── README.md
```

---

## Key Bindings

**Leader key**: `Space`

### General

| Key | Action |
|-----|--------|
| `<C-s>` | Save file (normal, insert, visual) |
| `<C-a>` | Select all |
| `<leader>qq` | Quit all |
| `<leader>nh` | Clear search highlight |
| `<leader>so` | Source current file |
| `<leader>us` | Toggle spell check |
| `<leader>uw` | Toggle line wrap |
| `<leader>ur` | Toggle relative numbers |
| `<leader>uh` | Toggle inlay hints (when LSP supports it) |

### Windows & Splits

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate between windows |
| `<C-Up/Down>` | Resize window height |
| `<C-Left/Right>` | Resize window width |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split |

### Tabs

| Key | Action |
|-----|--------|
| `<leader>to` | Open new tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Prev tab |

### Buffers

| Key | Action |
|-----|--------|
| `<S-l>` | Next buffer |
| `<S-h>` | Prev buffer |
| `<leader>bd` | Delete buffer |
| `<leader>bo` | Close all other buffers |
| `<leader>bn` | New buffer |
| `<leader>bp` | Pin buffer |
| `<leader>bP` | Delete all unpinned buffers |
| `<leader>br` | Delete buffers to the right |
| `<leader>bl` | Delete buffers to the left |

---

### File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>E` | Focus file explorer |
| `<leader>fe` | Reveal current file in explorer |
| `<leader>ge` | Open git status in explorer |

**Inside Neo-tree:**

| Key | Action |
|-----|--------|
| `a` | Create file/directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut |
| `p` | Paste |
| `Y` | Copy absolute path |
| `O` | Open with system app |
| `<CR>` / `l` | Open / expand |
| `h` | Collapse directory |
| `?` | Show all mappings |

---

### Find / Search (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | List buffers |
| `<leader>fn` | Find nvim config files |
| `<leader>fg` | Live grep (all files) |
| `<leader>fw` | Grep word under cursor |
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fk` | Find keymaps |
| `<leader>fc` | Find commands |
| `<leader>fh` | Find help tags |
| `<leader>fm` | Find marks |
| `<leader>f/` | Fuzzy search in current buffer |
| `<leader>/` | Fuzzy search in current buffer |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `<C-j/k>` | Navigate results |
| `<C-n/p>` | Navigate history |
| `<C-f/b>` | Scroll preview |
| `<C-q>` | Send to quickfix list |
| `<Esc>` | Close |

---

### Find & Replace (Spectre)

| Key | Action |
|-----|--------|
| `<leader>sr` | Open Spectre (project-wide replace) |
| `<leader>sw` | Replace word under cursor |
| `<leader>sf` | Replace in current file only |

---

### LSP / Code Intelligence

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<C-k>` | Signature help (insert mode) |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` | Format file / selection |
| `<leader>cl` | Trigger linting |
| `<leader>ci` | Incoming calls |
| `<leader>co` | Outgoing calls |
| `[d` | Prev diagnostic |
| `]d` | Next diagnostic |
| `<leader>cd` | Show diagnostic float |
| `<leader>xx` | All workspace diagnostics |
| `<leader>xd` | Buffer diagnostics |

---

### Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `aa` / `ia` | Outer / inner argument |
| `al` / `il` | Outer / inner loop |
| `ai` / `ii` | Outer / inner conditional |
| `ab` / `ib` | Outer / inner block |
| `]f` / `[f` | Next / prev function start |
| `]c` / `[c` | Next / prev class start |
| `<C-space>` | Expand treesitter selection |
| `<BS>` | Shrink treesitter selection |

---

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>gG` | LazyGit current file |
| `<leader>gf` | LazyGit log |
| `<leader>gd` | Open Diffview |
| `<leader>gD` | Close Diffview |
| `<leader>gh` | File history (Diffview) |
| `<leader>gH` | Branch history (Diffview) |
| `<leader>gc` | Git commits (Telescope) |
| `<leader>gC` | Buffer commits (Telescope) |
| `<leader>gb` | Toggle blame line |
| `<leader>gwd` | Toggle word diff |
| `]h` / `[h` | Next / prev hunk |
| `]H` / `[H` | Last / first hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghR` | Reset buffer |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghP` | Preview hunk popup |
| `<leader>ghb` | Full blame for line |
| `<leader>ghB` | Blame whole buffer |
| `<leader>ghd` | Diff this vs HEAD |
| `<leader>ghu` | Undo stage hunk |
| `ih` (visual/operator) | Select hunk as text object |

---

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dL` | Log point |
| `<leader>dc` | Continue / Start session |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dC` | Run to cursor |
| `<leader>dl` | Run last config |
| `<leader>dx` | Terminate session |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression under cursor |

---

### Terminal (ToggleTerm)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<leader>tf` | Toggle floating terminal |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<leader>tt` | Toggle terminal in tab |

**Inside terminal:**

| Key | Action |
|-----|--------|
| `<Esc>` or `jk` | Exit terminal mode (return to normal) |
| `<C-h/j/k/l>` | Navigate windows from terminal |

---

### Harpoon (Quick File Marks)

| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon |
| `<leader>hh` | Open harpoon menu |
| `<leader>h1` | Jump to harpoon file 1 |
| `<leader>h2` | Jump to harpoon file 2 |
| `<leader>h3` | Jump to harpoon file 3 |
| `<leader>h4` | Jump to harpoon file 4 |
| `<leader>hp` | Jump to prev harpoon file |
| `<leader>hn` | Jump to next harpoon file |
| `<leader>fH` | Browse harpoon marks in Telescope |

---

### Editor Motions

| Key | Action |
|-----|--------|
| `s` | Flash jump — type 2 chars to jump anywhere |
| `S` | Flash treesitter — jump to a syntax node |
| `gcc` | Toggle line comment |
| `gc` | Toggle comment (visual / operator) |
| `gbc` | Toggle block comment |
| `gcO` / `gco` / `gcA` | Comment above / below / end-of-line |
| `ys<motion><char>` | Add surround (e.g. `ysiw"` to quote a word) |
| `cs<old><new>` | Change surround |
| `ds<char>` | Delete surround |
| `J` / `K` (visual) | Move selection down / up |
| `<` / `>` (visual) | Indent and stay in visual |
| `]t` / `[t` | Next / prev TODO comment |
| `<leader>tc` | Browse TODO comments |

---

### Session Management

| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for current directory |
| `<leader>ql` | Restore last session |
| `<leader>qd` | Don't save session on exit |

### Notifications (Noice)

| Key | Action |
|-----|--------|
| `<leader>nl` | Show last notification |
| `<leader>nh` | Show notification history |
| `<leader>na` | Show all messages |
| `<leader>nd` | Dismiss all notifications |
| `<leader>un` | Dismiss all notifications (nvim-notify) |

### Quickfix

| Key | Action |
|-----|--------|
| `<leader>qo` | Open quickfix list |
| `<leader>qx` | Close quickfix list |
| `]q` / `[q` | Next / prev quickfix item |

---

## LSP Servers (auto-installed via Mason)

| Server | Language |
|--------|----------|
| `lua_ls` | Lua |
| `ts_ls` | TypeScript / JavaScript |
| `pyright` | Python |
| `gopls` | Go |
| `rust_analyzer` | Rust |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `bashls` | Bash / Shell |
| `html` | HTML |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `eslint` | JS/TS linting |

### Formatters & Linters (auto-installed via Mason)

| Tool | Used For |
|------|----------|
| `stylua` | Lua formatting |
| `prettierd` | JS/TS/JSON/CSS/HTML/Markdown |
| `black` | Python formatting |
| `isort` | Python import sorting |
| `gofumpt` | Go formatting |
| `shfmt` | Shell formatting |
| `eslint_d` | JS/TS linting |

---

## Plugin List

| Plugin | Purpose |
|--------|---------|
| `lazy.nvim` | Plugin manager |
| `github-theme` | Color scheme (github_dark / github_light) |
| `lualine.nvim` | Status line |
| `bufferline.nvim` | Buffer tab bar |
| `noice.nvim` | Better cmdline/messages UI |
| `nvim-notify` | Notification system |
| `dressing.nvim` | Improved vim.ui.select/input |
| `indent-blankline.nvim` | Indent guides |
| `dashboard-nvim` | Startup dashboard |
| `nvim-colorizer.lua` | Hex color previews |
| `nvim-web-devicons` | File icons |
| `persistence.nvim` | Session management |
| `nvim-treesitter` | Syntax highlighting + text objects |
| `nvim-ts-autotag` | Auto-close HTML/JSX tags |
| `telescope.nvim` | Fuzzy finder |
| `telescope-fzf-native` | Fast fzf sorter |
| `telescope-ui-select` | Use Telescope for code actions |
| `nvim-spectre` | Project-wide find & replace |
| `neo-tree.nvim` | File explorer |
| `mason.nvim` | LSP/tool installer |
| `nvim-lspconfig` | LSP server configs |
| `conform.nvim` | Code formatting (format-on-save) |
| `nvim-lint` | Async linting |
| `fidget.nvim` | LSP progress spinner |
| `lazydev.nvim` | Neovim Lua dev completions |
| `nvim-cmp` | Completion engine |
| `LuaSnip` | Snippet engine |
| `friendly-snippets` | Snippet library |
| `nvim-autopairs` | Auto-close brackets |
| `nvim-surround` | Surround text objects |
| `Comment.nvim` | Easy commenting |
| `which-key.nvim` | Keybinding guide |
| `flash.nvim` | Fast jump navigation |
| `todo-comments.nvim` | TODO/FIXME highlighting |
| `mini.ai` | Extended text objects |
| `rainbow-delimiters.nvim` | Rainbow bracket pairs |
| `gitsigns.nvim` | Git hunk signs + operations |
| `lazygit.nvim` | LazyGit integration |
| `diffview.nvim` | Git diff viewer |
| `nvim-dap` | Debug Adapter Protocol |
| `nvim-dap-ui` | Debug UI panels |
| `nvim-dap-virtual-text` | Inline debug values |
| `mason-nvim-dap` | DAP adapter installer |
| `toggleterm.nvim` | Terminal management |
| `harpoon` (v2) | Quick file marks |

---

## Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Lazy update` | Update all plugins |
| `:Mason` | Open LSP/tool installer |
| `:LspInfo` | Show active LSP clients |
| `:ConformInfo` | Show active formatters |
| `:TSBufInfo` | Show active Treesitter parsers |
| `:checkhealth` | Run health checks |
| `:Telescope` | Open Telescope |
| `:Neotree` | Open file explorer |
| `:DiffviewOpen` | Open git diff view |
| `:LazyGit` | Open LazyGit |
| `:TodoTelescope` | Browse TODO comments |
| `:ToggleTerm` | Toggle terminal |
