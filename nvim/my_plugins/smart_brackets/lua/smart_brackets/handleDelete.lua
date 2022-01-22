local M = {}
-- InsertEnter
-- TextChanged

local function handleChange()
	print("A change was made")
end

function M.listenForChange()
	vim.api.nvim_command("autocmd TextChanged * handleChange()")
end

return M
