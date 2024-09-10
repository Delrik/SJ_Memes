SJ = SJ or {}

SJ.CallbackRegister = {}
local plugin = SJ.CallbackRegister

function plugin:register(event, callback)
    if not DBM:IsCallbackRegistered(event, callback) then
        DBM:RegisterCallback(event, callback)
    end
end

function plugin:unregister(event, callback)
    DBM:UnregisterCallback(event, callback)
end
