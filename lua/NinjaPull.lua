SJ = SJ or {}

SJ.NinjaPull = {
    enabled = false,
    callback = {},
    pull_at = 0,
    threshold = 1
}

local plugin = SJ.NinjaPull
local callbacks = SJ.CallbackRegister

function plugin.callback(event, mod)
    if plugin.pull_at == 0 then return end
    if plugin.pull_at - GetServerTime() > plugin.threshold then
        PlaySoundFile("Interface\\AddOns\\SJ_Memes\\assets\\heavy_ninja_pull.ogg", "Master")
        local suspect_name = mod:GetBossTarget(mod.mainBoss or mod.combatInfo.mob or -1)
        print("Ninja pull suspect: " .. suspect_name)
    end
    plugin.pull_at = 0
end

local original_pull = C_PartyInfo.DoCountdown
function plugin.Pull(seconds)
    plugin.pull_at = GetServerTime() + seconds
    C_Timer.After(seconds, function()
        plugin.pull_at = 0
    end)
    original_pull(seconds)
end

function plugin.enable(value)
    if plugin.enabled == value then return end
    plugin.enabled = value
    if plugin.enabled then
        C_PartyInfo.DoCountdown = function(seconds)
            plugin.Pull(seconds)
        end
        callbacks:register("DBM_Pull", plugin.callback)
    else
        C_PartyInfo.DoCountdown = original_pull
        callbacks:unregister("DBM_Pull", plugin.callback)
    end
end
