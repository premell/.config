  -- colorscheme gruvbox-material
  -- colorscheme catppuccin
  -- colorscheme github_dark_default
  -- colorscheme darkplus

vim.cmd[[
  let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
]]

local colorscheme = "github_dark_default"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
