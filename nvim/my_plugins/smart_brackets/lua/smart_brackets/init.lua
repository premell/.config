local smart_brackets = {}

local i = "hejsan"

-- local lastState = ""
-- local newState = ""
-- local lastChange = ""

function smart_brackets.handleEnter()
	i = "I WAS CHANGED"
end

function smart_brackets.setup()
	vim.api.nvim_command([[    autocmd InsertEnter * lua require('smart_brackets').handleEnter() ]])

	-- this works!
	-- require("smart_brackets").handleEnter()
end

function smart_brackets.testing()
	-- print(i)
	-- print(k)
	-- l = string.gsub(k, "hejsan", "kakakak")

	-- local show = (vim.o.laststatus > 0) or (vim.o.showtabline > 0)

	-- vim.api.nvim_command([[changes]])
	-- local show = vim.api.nvim_eval(vim.api.nvim_command([[changes]]))
	vim.command(changes)

	-- vim.api.nvim_get_option()
	-- print(show)
end

return smart_brackets
