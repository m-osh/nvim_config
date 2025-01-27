require("toggleterm").setup({
  size = 20,                          -- Height of the terminal in horizontal mode
  open_mapping = [[<C-\>]],           -- Keybinding to toggle terminal
  hide_numbers = true,                -- Hide line numbers in the terminal buffer
  shade_filetypes = {},               -- No shading for specific file types
  shade_terminals = true,             -- Apply background shading to terminals
  shading_factor = 2,                 -- Shading intensity (1-3)
  start_in_insert = true,             -- Start terminal in insert mode
  persist_size = true,                -- Remember terminal size between sessions
  direction = "horizontal",           -- Options: "horizontal", "vertical", "tab", "float"
  close_on_exit = true,               -- Close terminal window when the process exits
  shell = vim.o.shell,                -- Shell to use in the terminal (default: system shell)
  float_opts = {                      -- Options for floating terminal
    border = "curved",                -- Border style: single/double/shadow/curved
    winblend = 0,                     -- Transparency of floating window
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- Key mappings for split terminals
vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>2ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>2ToggleTerm direction=vertical size=40<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>2ToggleTerm direction=float<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
