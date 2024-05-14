SJ = SJ or {}

SJ.OnRoll = {
    enabled = false,
    callback = {}
}

local plugin = SJ.OnRoll
local events = SJ.EventRegister

function plugin:check_roll(value)
    if tonumber(value) == 100 then
        PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\heavy_ninja_pull.ogg", "Master")
    end
end

function plugin.raid_roll(msg)
    local pattern = "(%a+) rolls (%d+) %(1%-100%)"
    local _, roll = msg:match(pattern)
    if roll then
        plugin:check_roll(roll)
    end
end

function plugin.enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        print("Done")
        events:register("CHAT_MSG_SYSTEM", plugin.raid_roll)
    else
        events:unregister("CHAT_MSG_SYSTEM", plugin.raid_roll)
    end
end
