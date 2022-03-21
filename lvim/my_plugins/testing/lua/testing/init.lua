local M = {}

M.BetterW = function() 
  line_length = #vim.api.nvim_get_current_line()
  position_before = vim.api.nvim_win_get_cursor(0)

  vim.cmd[[
    normal w
  ]]
  position_after = vim.api.nvim_win_get_cursor(0)

  if position_before[1] ~= position_after[1] and position_before[2]+1 ~= line_leng then
  vim.cmd[[
    normal k$
  ]]
  end
end

M.BetterW()

return M
