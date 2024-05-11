SJ = SJ or {}

SJ.ExecuteAlert = {
    threshold = 35,
    enabled = false,
    mod = {},
    engaged = false,
    notified = false
}

local plugin = SJ.ExecuteAlert
local callbacks = SJ.CallbackRegister

function plugin:notify()
    SendChatMessage("Execute phase!", "WHISPER", nil, UnitName("player"))
    PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\heavy_execute.ogg", "Master")
end

function plugin:repeater()
    if not plugin.engaged then return end
    local hp = plugin:get_boss_hp()
    if hp > plugin.threshold then
        plugin.notified = false
    end
    if hp <= plugin.threshold and not plugin.notified then
        plugin.notify()
        plugin.notified = true
    end
    C_Timer.After(0.1, plugin.repeater)
end

plugin.start_callback = function(event, mod)
    plugin.engaged = true
    plugin.mod = mod
    plugin:repeater();
end

plugin.end_callback = function(event, mod)
    plugin.engaged = false
    plugin.mod = {}
    plugin.notified = false
end

function plugin:get_boss_hp()
    if not plugin.engaged then return 0 end
    return plugin.mod:GetBossHP(plugin.mod.mainBoss or plugin.mod.combatInfo.mob or -1)
end

function plugin:set_threshold(value)
    if value < 0 then
        value = 0
    end
    if value > 100 then
        value = 100
    end
    plugin.threshold = value
end

function plugin:get_threshold()
    return plugin.threshold
end

function plugin:enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        callbacks:register("DBM_Pull", plugin.start_callback)
        callbacks:register("DBM_Wipe", plugin.end_callback)
        callbacks:register("DBM_Kill", plugin.end_callback)
    else
        callbacks:unregister("DBM_Kill", plugin.start_callback)
        callbacks:unregister("DBM_Wipe", plugin.end_callback)
        callbacks:unregister("DBM_Pull", plugin.end_callback)
    end
end

-- Register the command
SJ.CommandProcessor:add_command("execute", function(value)
    value = tonumber(value)
    if not value then
        return
    end
    if type(value) ~= "number" then
        return
    end
    plugin:set_threshold(value)
end, "execute <value>: Sets threshold for an execution phase")
