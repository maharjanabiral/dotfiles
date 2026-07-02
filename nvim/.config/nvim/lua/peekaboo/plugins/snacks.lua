
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enable the terminal module explicitly
    terminal = {
      enabled = true,
    },
  },
  keys = {
    -- Toggle terminal globally using Ctrl + /
    { "<C-/>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
    -- Map for terminal mode so you can hide it using the same shortcut while typing
    { "<C-/>", function() Snacks.terminal.toggle() end, mode = "t", desc = "Toggle Terminal" },
  },


}
