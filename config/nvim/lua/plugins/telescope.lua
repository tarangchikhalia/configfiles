return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      -- Files
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fn", "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", desc = "Find nvim config files" },

      -- Search / Grep
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fw", "<cmd>Telescope grep_string word_match=-w<cr>", desc = "Grep word under cursor" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", mode = "v", desc = "Grep selection" },
      { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },

      -- Misc
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Find commands" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Find marks" },
      { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search buffer" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },

      -- Git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Git buffer commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

      -- Diagnostics
      { "<leader>xx", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer diagnostics" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = "  ",
          multi_icon = " ",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
            horizontal = { width = 0.9, height = 0.9, preview_width = 0.6 },
            vertical = { width = 0.9, height = 0.9 },
          },
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/", "%.lock" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<esc>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = { hidden = true, follow = true },
          live_grep = { additional_args = { "--hidden" } },
          buffers = { previewer = false, layout_config = { width = 0.7 } },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },

  -- Project-wide find and replace
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Replace word under cursor" },
      { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Replace selection" },
      { "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Replace in current file" },
    },
  },
}
