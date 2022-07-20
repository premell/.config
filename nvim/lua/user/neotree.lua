local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

-- local config_status_ok, neo-tree = pcall(require, "neo-tree.config")
-- if not config_status_ok then
-- 	return
-- end
--

--vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
neotree.setup({
	enable_git_status = true,
	enable_diagnostics = true,

	window = {
		width = 80,
		popup = { -- settings that apply to float position only
			size = {
				height = "80%",
				width = "65%",
			},
			position = "50%", -- 50% means center it
			-- you can also specify border here, if you want a different setting from
			-- the global popup_border_style.
		},
	},
	filesystem = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together}
    hijack_netrw_behavior = "open_current",
	},
	buffers = {
		follow_current_file = true, -- This will find and focus the file in the active buffer every
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["d"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
			},
		},
	},
})
