local M = {}

M.BetterN = function()










	-- local line_length = #vim.api.nvim_get_current_line()
	-- local position_before = vim.api.nvim_win_get_cursor(0)
	--
	-- vim.cmd([[
 --    normal! w
 --  ]])
	--
	-- local position_after = vim.api.nvim_win_get_cursor(0)
	--
	-- if position_before[1] ~= position_after[1] and position_before[2] + 1 ~= line_length and line_length ~= 0 then
	-- 	vim.cmd([[
 --      normal! k$
 --    ]])
	-- end
end

-- vim.cmd [[
--   augroup _bettern
--     autocmd QuickFixCmdPost * echo "hello" 
--   augroup end
-- ]]
    --autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 



return M
