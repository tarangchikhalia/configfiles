return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      local map = vim.keymap.set
      -- Add current file
      map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      -- Open harpoon menu
      map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

      -- Quick jump to slot 1-4
      map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

      -- Toggle between last two marked files
      map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev file" })
      map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next file" })

      -- Telescope extension (if available)
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("harpoon")
        map("n", "<leader>fH", "<cmd>Telescope harpoon marks<cr>", { desc = "Find harpoon marks" })
      end
    end,
  },
}
