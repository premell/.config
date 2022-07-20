local M = {}

local bufferList = {}

local group = vim.api.nvim_create_augroup("BetterBuffer")
vim.api.nvim_create_autocmd("BufNew", {command = "echo 'Hello'", group = group})

return M
