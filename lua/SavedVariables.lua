SJ = SJ or {}
SJ.SavedVariables = {}

local plugin = SJ.SavedVariables

function plugin.OnLoadEvent(event, arg1)
    if arg1 == SJ.addon_name then
        -- ExecuteAlert
        if not ExecuteThreshold then ExecuteThreshold = 35 end
        SJ.ExecuteAlert:set_threshold(ExecuteThreshold)
    end
end

function plugin.OnLogoutEvent(event)
    -- ExecuteAlert
    ExecuteThreshold = SJ.ExecuteAlert:get_threshold()
end

SJ.EventRegister:register("ADDON_LOADED", plugin.OnLoadEvent)
SJ.EventRegister:register("PLAYER_LOGOUT", plugin.OnLogoutEvent)
