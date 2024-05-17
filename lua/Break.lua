SJ = SJ or {}

SJ.Break = {
    enabled = false,
    callback = {},
    announced = false
}

local plugin = SJ.Break
local callbacks = SJ.CallbackRegister
local sounds = SJ.SoundAssets:init(SJ.SoundAssets.BreakSounds)

function plugin.callback(_, _, arg, seconds)
    if arg == "Break time!" and not plugin.announced then
        plugin.announced = true
        local sound
        if seconds == 60 then
            sound = sounds:choose(1)
        elseif seconds == 180 then
            sound = sounds:choose(2)
        else
            sound = sounds:choose()
        end
        PlaySoundFile(sound, "Master")
        -- Handle sound duplication due to 2 callbacks being fired from DBM one right after the other
        C_Timer.After(5, function()
            plugin.announced = false
        end)
    end
end

function plugin:enable(value)
    plugin.enabled = value
    if plugin.enabled then
        callbacks:register("DBM_TimerStart", plugin.callback)
    else
        callbacks:unregister("DBM_TimerStart", plugin.callback)
    end
end
