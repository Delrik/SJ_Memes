SJ = SJ or {}
SJ.SavedVariables = {}

local plugin = SJ.SavedVariables
local events = SJ.EventRegister

function plugin.OnLoadEvent(arg1)
    if arg1 == SJ.addon_name then
        -- OnExecuteStage
        if not ExecuteThreshold then ExecuteThreshold = 35 end
        SJ.OnExecuteStage:set_threshold(ExecuteThreshold)
    end
end

function plugin.OnLogoutEvent()
    -- OnExecuteStage
    ExecuteThreshold = SJ.OnExecuteStage:get_threshold()
end

events:register("ADDON_LOADED", plugin.OnLoadEvent)
events:register("PLAYER_LOGOUT", plugin.OnLogoutEvent)
