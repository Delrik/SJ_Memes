SJ = SJ or {}

SJ.OnResurrect = {
    enabled = false,
    callback = {}
}

local plugin = SJ.OnResurrect
local events = SJ.EventRegister

function plugin.callback(_)
    PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\ress_sound_1.ogg", "Master")
end

function plugin.enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        events:register("RESURRECT_REQUEST", plugin.callback)
    else
        events:unregister("RESURRECT_REQUEST", plugin.callback)
    end
end
