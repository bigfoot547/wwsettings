wwsettings = {}

function wwsettings.setting_get(set)
	local file
	local errstr
	local filestr
	local retval
	
	-- Create the file if non-existant
	file, errstr = io.open(minetest.get_worldpath().."/wwsettings.conf", "a")
	io.close(file)
	
	-- Open the file for reading
	file, errstr = io.open(minetest.get_worldpath().."/wwsettings.conf", "r")
	filestr = file:read("*a")
	if not filestr then
		print(errstr)
		minetest.chat_send_all(minetest.colorize("#FF0000", "An internal error occurred: "..errstr))
		io.close(file)
		return false, errstr
	end
	
	-- Parse the file
	local savetable = filestr:split('\n')
	local i
	for i in pairs(savetable) do
		if savetable[i]:find(set) then
			io.close(file)
			_, retval = string.match(savetable[i], "([^ ]+) = (.+)")
			return retval
		end
	end
	io.close(file)
	return "<not set>"
end

function wwsettings.setting_set(set, val)
	local file
	local errstr
	local savetable
	local j = 0
	
	file, errstr = io.open(minetest.get_worldpath().."/wwsettings.conf", "a+")
	
	if not file then
		print(errstr)
		minetest.chat_send_all(minetest.colorize("#FF0000", "An internal error occurred: "..errstr))
		return false, errstr
	end
	
	savetable = file:read("*a"):split('\n')
	
	local i
	for i in pairs(savetable) do
		if savetable[i]:find(set) then
			savetable[i] = savetable[i]:split(' ')[1].." "..savetable[i]:split(' ')[2].." "..val.."\n"
			j = 1
		end
	end
	if j == 0 then
		file:write(set.." = "..val.."\n")
		io.close(file)
	else
		io.close(file)
		file = io.open(minetest.get_worldpath().."/wwsettings.conf", "w")
		file:write(table.concat(savetable, "\n"))
		io.close(file)
	end
	return true
end

minetest.register_chatcommand("wwset", {
	description = "Set/Get a world-wide setting",
	params = "<setting> [value]",
	privs = {server = true},
	func = function(name, param)
		local setting, value = string.match(param, "([^ ]+) (.+)")
		if value and setting then
			wwsettings.setting_set(setting, value)
			return true, setting .. " = " .. wwsetting.setting_get(setting)
		end
		if param then
			return true, param .. " = " .. wwsettings.setting_get(param)
		end
		minetest.chat_send_player(name, minetest.colorize("#FF0000", "Invalid Usage."))
		return false
	end
})
