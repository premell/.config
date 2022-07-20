vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.cmd([[set packpath=/tmp/nvim/site]])
local package_root = "/tmp/nvim/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local function load_plugins()
	require("packer").startup({
		{
			"wbthomason/packer.nvim",
			{
				"nvim-telescope/telescope.nvim",
				requires = {
					"nvim-lua/plenary.nvim",
					{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				},
			},
			"ibhagwan/fzf-lua",
			"premell/betterw.nvim",
			{
				"nvim-neo-tree/neo-tree.nvim",
				requires = {
					"nvim-lua/plenary.nvim",
					"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
					"MunifTanjim/nui.nvim",
				},
				branch = "main",
				config = function()
					require("neo-tree").setup({
						window = {
							width = 300,
							popup = { -- settings that apply to float position only
								size = {
									height = "80%",
									width = "80%",
								},
								position = "50%", -- 50% means center it
								-- you can also specify border here, if you want a different setting from
								-- the global popup_border_style.
							},
						},
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
_G.load_config = function()
	require("telescope").setup()
	require("telescope").load_extension("fzf")
	-- ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
end
if vim.fn.isdirectory(install_path) == 0 then
	print("Installing Telescope and dependencies.")
	vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end
load_plugins()
require("packer").sync()
vim.cmd([[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]])

-- hej hej hej
--
--
--
--
