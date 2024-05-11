SJ = SJ or {}

local frame = CreateFrame("FRAME");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("PLAYER_LOGOUT")

function frame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == SJ.addon_name then
        -- ExecuteAlert
        if not ExecuteThreshold then ExecuteThreshold = 35 end
        SJ.ExecuteAlert:set_threshold(ExecuteThreshold)

    elseif event == "PLAYER_LOGOUT" then
        -- ExecuteAlert
        ExecuteThreshold = SJ.ExecuteAlert:get_threshold()

    end
end

frame:SetScript("OnEvent", frame.OnEvent);
