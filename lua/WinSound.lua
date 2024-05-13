SJ = SJ or {}
SJ.WinSound = {
    enabled = false,
    dbm_sound = "",
    callback = function()
        PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\heavy_win.ogg", "Master")
    end
}

local plugin = SJ.WinSound
local callbacks = SJ.CallbackRegister

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
