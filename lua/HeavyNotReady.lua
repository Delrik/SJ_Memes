SJ = SJ or {}

SJ.HeavyNotReady = {
    enabled = false,
    callback = {}
}

local plugin = SJ.HeavyNotReady
local callbacks = SJ.CallbackRegister
local sounds = SJ.SoundAssets:init(SJ.SoundAssets.WipeSounds)

function plugin.callback()
    PlaySoundFile(sounds:choose(), "Master")
end

function plugin:enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        callbacks:register("DBM_Wipe", plugin.callback)
    else
        callbacks:unregister("DBM_Wipe", plugin.callback)
    end
end
