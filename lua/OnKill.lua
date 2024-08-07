SJ = SJ or {}
SJ.OnKill = {
    enabled = false,
    dbm_sound = "",
    callback = {}
}

local plugin = SJ.OnKill
local callbacks = SJ.CallbackRegister
local sounds = SJ.SoundAssets:init(SJ.SoundAssets.OnKillSounds)

function plugin.callback()
    PlaySoundFile(sounds:choose(), "Master")
end

function plugin:enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        callbacks:register("DBM_Kill", plugin.callback)
        plugin.dbm_sound = DBM.Options.EventSoundVictory2
        DBM.Options.EventSoundVictory2 = ""
    else
        callbacks:unregister("DBM_Kill", plugin.callback)
        DBM.Options.EventSoundVictory2 = plugin.dbm_sound
        plugin.dbm_sound = ""
    end
end

function plugin:is_enabled()
    return plugin.enabled
end
