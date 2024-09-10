SJ = SJ or {}

SJ.CommandProcessor = {
    command_table = {},
}

local plugin = SJ.CommandProcessor

function plugin:add_command(command, callback, hint)
    if not command or not callback then
        return
    end
    if type(command) ~= "string" or type(callback) ~= "function" then
        return
    end
    plugin.command_table[command] = { callback, hint }
end

function plugin:print_help()
    print("\124cFF00CCFFSJ Help:\124r")
    for command, data in pairs(plugin.command_table) do
        if command ~= "" then
            print("\124cFFFFFF00" .. command .. ":\124r " .. data[2])
        end
    end
end

-- Register the slash command
SLASH_SJ1 = "/sj"
SlashCmdList["SJ"] = function(msg)
    if msg == "help" then
        plugin:print_help()
        return
    end
    local command, args = msg:match("^(%S*)%s*(.-)$")
    if plugin.command_table[command] then
        plugin.command_table[command][1](args)
    else
        print("Command not found. Type /sj help for a list of commands.")
    end
end
