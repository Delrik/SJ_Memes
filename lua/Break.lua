SJ = SJ or {}

SJ.Break = {
    enabled = false,
    callback = {},
    announced = false
}

local plugin = SJ.Break
local callbacks = SJ.CallbackRegister

function plugin.callback(_, _, arg)
    if arg == "Break time!" and not plugin.announced then
        plugin.announced = true
        -- TODO: Update this to use the new sound system when one is implemented
        PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\break_1.ogg", "Master")
        -- Handle sound duplication due to 2 callbacks being fired from DBM one right after the other
        C_Timer.After(5, function()
            plugin.announced = false
        end)
    end
end

function plugin:enable(value)
    self.enabled = value
    if value then
        callbacks:register("DBM_TimerStart", plugin.callback)
    else
        callbacks:unregister("DBM_TimerStart", plugin.callback)
    end
end
