vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.cmd([[set packpath=/tmp/nvim/site]])
local package_root = "/tmp/nvim/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local function load_plugins()
	require("packer").startup({
		{
			"wbthomason/packer.nvim",
			{
				"nvim-neo-tree/neo-tree.nvim",
				requires = {
					"nvim-lua/plenary.nvim",
					"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
					"MunifTanjim/nui.nvim",
				},
				config = function()
					require("neo-tree").setup({
						filesystem = {
							follow_current_file = true, -- This will find and focus the file in the active buffer every
						},
					})
				end,
			},
		},
		config = {
			package_root = package_root,
			compile_path = install_path .. "/plugin/packer_compiled.lua",
			display = { non_interactive = true },
		},
	})
end
if vim.fn.isdirectory(install_path) == 0 then
	vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end
load_plugins()
require("packer").sync()
vim.cmd([[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]])
