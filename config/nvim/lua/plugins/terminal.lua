return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", mode = { "n", "t" }, desc = "Toggle floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Toggle terminal in tab" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      on_open = function(term)
        vim.cmd("startinsert!")
        -- Allow Esc to return to normal mode in terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jk", [[<C-\><C-n>]], { noremap = true })
        -- Keep window navigation working from terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-h>", [[<Cmd>wincmd h<CR>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-j>", [[<Cmd>wincmd j<CR>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-k>", [[<Cmd>wincmd k<CR>]], { noremap = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-l>", [[<Cmd>wincmd l<CR>]], { noremap = true })
      end,
      float_opts = {
        border = "curved",
        winblend = 3,
        width = function() return math.floor(vim.o.columns * 0.85) end,
        height = function() return math.floor(vim.o.lines * 0.80) end,
      },
      highlights = {
        FloatBorder = { link = "FloatBorder" },
      },
      direction = "float",
      shell = vim.o.shell,
      close_on_exit = true,
      auto_scroll = true,
    },
  },
}
