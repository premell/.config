  -- colorscheme github_dark_default
  -- colorscheme gruvbox-material
  -- colorscheme catppuccin
vim.cmd [[
try
  colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
