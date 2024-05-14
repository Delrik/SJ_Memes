SJ = SJ or {}
SJ.EventRegister = {
    frame = CreateFrame("FRAME"),
    callbacks = {}, -- store the callbacks in format {event = [callbacks]}
}

local plugin = SJ.EventRegister

function plugin:register(event, callback)
    if not plugin.callbacks[event] then
        plugin.callbacks[event] = {}
        plugin.frame:RegisterEvent(event)
    end
    table.insert(plugin.callbacks[event], callback)
end

function plugin:unregister(event, callback)
    if not plugin.callbacks[event] then return end
    for i, cb in ipairs(plugin.callbacks[event]) do
        if cb == callback then
            table.remove(plugin.callbacks[event], i)
            break
        end
    end
    if #plugin.callbacks[event] == 0 then
        plugin.callbacks[event] = nil
        plugin.frame:UnregisterEvent(event)
    end
end

function plugin:OnEvent(event, ...)
    for ev, callbacks in pairs(plugin.callbacks) do
        if event == ev then
            for _, callback in pairs(callbacks) do
                callback(...)
            end
        end
    end
end

plugin.frame:SetScript("OnEvent", plugin.OnEvent);
