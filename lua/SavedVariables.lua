SJ = SJ or {}
SJ.SavedVariables = {}

local plugin = SJ.SavedVariables
local events = SJ.EventRegister

function plugin.OnLoadEvent(arg1)
    if arg1 == SJ.addon_name then
        SJ.Options:set_options(SJ_Options)

        -- TODO: Remove this in the future
        -- Intented for backward compatibility
        if ExecuteThreshold then
            SJ.OnExecuteStage:set_threshold(ExecuteThreshold)
        end
    end
end

function plugin.OnLogoutEvent()
    -- OnExecuteStage
    SJ_Options = SJ.Options:get_options()
end

events:register("ADDON_LOADED", plugin.OnLoadEvent)
events:register("PLAYER_LOGOUT", plugin.OnLogoutEvent)
