return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  ft = "python",
  keys = {
    {
      "<leader>vs",
      "<cmd>VenvSelect<CR>",
      desc = "Select Python venv",
    },
  },
  opts = {},
}

