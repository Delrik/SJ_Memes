SJ = SJ or {}

SJ.HeavyNotReady = {
    enabled = false,
    callback = function()
        PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\heavy_not_ready.ogg", "Master")
    end
}

local plugin = SJ.HeavyNotReady
local callbacks = SJ.CallbackRegister

function plugin:enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        callbacks:register("DBM_Wipe", plugin.callback)
    else
        callbacks:unregister("DBM_Wipe", plugin.callback)
    end
end
