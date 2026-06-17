return {
  -- Parser installer / query provider
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- new nvim-treesitter does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup() -- accepts only { install_dir = ... }

      -- Install parsers (no-op if already installed)
      require("nvim-treesitter").install({
        "bash", "c", "css", "diff", "go", "gomod", "gosum",
        "html", "javascript", "json", "lua", "luadoc",
        "markdown", "markdown_inline", "python", "query",
        "regex", "rust", "toml", "tsx", "typescript",
        "vim", "vimdoc", "yaml",
      })
    end,
  },

  -- Textobject motions (select, move, swap) — new standalone API
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local sel = require("nvim-treesitter-textobjects.select")
      local mov = require("nvim-treesitter-textobjects.move")
      local swp = require("nvim-treesitter-textobjects.swap")

      -- ── Select text objects ──────────────────────────────────────────
      local selmap = {
        ["af"] = "@function.outer",  ["if"] = "@function.inner",
        ["ac"] = "@class.outer",     ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
        ["al"] = "@loop.outer",      ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
        ["ab"] = "@block.outer",     ["ib"] = "@block.inner",
      }
      for lhs, query in pairs(selmap) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          sel.select_textobject(query, "textobjects")
        end, { desc = "TS select " .. query })
      end

      -- ── Move to next/prev textobject ─────────────────────────────────
      local movmap = {
        { "]f", "@function.outer",    "next_start" },
        { "]F", "@function.outer",    "next_end"   },
        { "]c", "@class.outer",       "next_start" },
        { "]C", "@class.outer",       "next_end"   },
        { "]a", "@parameter.inner",   "next_start" },
        { "[f", "@function.outer",    "prev_start" },
        { "[F", "@function.outer",    "prev_end"   },
        { "[c", "@class.outer",       "prev_start" },
        { "[C", "@class.outer",       "prev_end"   },
        { "[a", "@parameter.inner",   "prev_start" },
      }
      local fn_map = {
        next_start = "goto_next_start",
        next_end   = "goto_next_end",
        prev_start = "goto_previous_start",
        prev_end   = "goto_previous_end",
      }
      for _, entry in ipairs(movmap) do
        local lhs, query, dir = entry[1], entry[2], entry[3]
        vim.keymap.set({ "n", "x", "o" }, lhs, function()
          mov[fn_map[dir]](query, "textobjects")
        end, { desc = "TS move " .. dir .. " " .. query })
      end

      -- ── Swap parameters ──────────────────────────────────────────────
      vim.keymap.set("n", "<leader>na", function()
        swp.swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>Na", function()
        swp.swap_previous("@parameter.inner")
      end, { desc = "Swap prev parameter" })
    end,
  },

  -- Auto-close/rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
