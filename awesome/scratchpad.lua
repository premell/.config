local awful = require("awful")

local scratchpad = {}

function scratchpad.start()
	local scratchpad = awful.tag.find_by_name(awful.screen.focused(), "scratch")
	awful.tag.incncol(1, scratchpad, true)

	awful.spawn("spotify")
	awful.spawn("discord")
	awful.spawn("signal-desktop")
	awful.spawn("element-desktop")
	awful.spawn("sxiv ~/Pictures/wallpapers/1.jpg")
	-- awful.spawn("alacritty -e lvim notes", {
	-- 	tag = scratchpad,
	-- })
end

--THIS IS WORKING SO FUUCKING BADLY

-- This is a comment

function scratchpad.toggleScratchpad()
	local scratchpad = awful.tag.find_by_name(awful.screen.focused(), "scratch")
	local currentTag = awful.screen.focused().selected_tag
	local scratchpad = awful.tag.find_by_name(awful.screen.focused(), "scratch")

	if scratchpad.index == currentTag.index then
		awful.tag.history.restore()
	else
		scratchpad:view_only()
	end
end

return scratchpad
