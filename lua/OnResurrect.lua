SJ = SJ or {}

SJ.OnResurrect = {
    enabled = false,
    callback = {}
}

local plugin = SJ.OnResurrect
local events = SJ.EventRegister
local sounds = SJ.SoundAssets:init(SJ.SoundAssets.ResurrectSounds)

function plugin.callback(_)
    PlaySoundFile(sounds:choose(), "Master")
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
