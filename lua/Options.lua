SJ = SJ or {}

SJ.Options = {
    DefaultOptions = {
        ["OnWipe"] = { ["enabled"] = true },
        ["OnExecuteStage"] = { ["enabled"] = true, ["threshold"] = 35 },
        ["OnKill"] = { ["enabled"] = true },
        ["OnNinjaPull"] = { ["enabled"] = true },
        ["OnResurrect"] = { ["enabled"] = true },
        ["OnBreak"] = { ["enabled"] = true }
    }
}

local getter_setter_matcher = {
    ["OnWipe"] = {
        ["enabled"] = { function() return SJ.OnWipe:is_enabled() end, function(value) SJ.OnWipe:enable(value) end }
    },
    ["OnExecuteStage"] = {
        ["enabled"] = { function() return SJ.OnExecuteStage:is_enabled() end, function(value)
            SJ.OnExecuteStage:enable(value)
        end },
        ["threshold"] = { function() return SJ.OnExecuteStage:get_threshold() end, function(value)
            SJ.OnExecuteStage:set_threshold(value)
        end }
    },
    ["OnKill"] = {
        ["enabled"] = { function() return SJ.OnKill:is_enabled() end, function(value) SJ.OnKill:enable(value) end }
    },
    ["OnNinjaPull"] = {
        ["enabled"] = { function() return SJ.OnNinjaPull:is_enabled() end, function(value)
            SJ.OnNinjaPull:enable(value)
        end }
    },
    ["OnResurrect"] = {
        ["enabled"] = { function() return SJ.OnResurrect:is_enabled() end, function(value)
            SJ.OnResurrect:enable(value)
        end }
    },
    ["OnBreak"] = {
        ["enabled"] = { function() return SJ.OnBreak:is_enabled() end, function(value) SJ.OnBreak:enable(value) end }
    }
}

local plugin = SJ.Options

local function match_options(options)
    local result = plugin.DefaultOptions
    if not options then
        return result
    end
    for key, value in pairs(options) do
        if result[key] then
            for sub_key, sub_value in pairs(value) do
                if result[key][sub_key] then
                    result[key][sub_key] = sub_value
                end
            end
        end
    end
    return result
end

function plugin:apply_option(key, value)
    if not key or not value then
        return
    end
    if not getter_setter_matcher[key] then
        return
    end
    for sub_key, sub_value in pairs(value) do
        if getter_setter_matcher[key][sub_key] then
            getter_setter_matcher[key][sub_key][2](sub_value)
        end
    end
end

function plugin:set_parameter(subplugin, parameter, value)
    if not subplugin or not parameter or value == nil then
        return
    end
    if not getter_setter_matcher[subplugin] then
        return
    end
    if not getter_setter_matcher[subplugin][parameter] then
        return
    end
    getter_setter_matcher[subplugin][parameter][2](value)
end

function plugin:get_option(subplugin)
    if not subplugin then
        return nil
    end
    if not getter_setter_matcher[subplugin] then
        return nil
    end
    local result = {}
    for sub_key, sub_value in getter_setter_matcher[subplugin] do
        result[sub_key] = sub_value[1]()
    end
    return result
end

function plugin:get_parameter(subplugin, parameter)
    if not subplugin or not parameter then
        return nil
    end
    if not getter_setter_matcher[subplugin] then
        return nil
    end
    if not getter_setter_matcher[subplugin][parameter] then
        return nil
    end
    return getter_setter_matcher[subplugin][parameter][1]()
end

function plugin:get_options()
    local result = {}
    for key, _ in getter_setter_matcher do
        result[key] = plugin:get_option(key)
    end
    return result
end

function plugin:set_options(options)
    options = match_options(options)
    for key, value in pairs(options) do
        plugin:apply_option(key, value)
    end
end
