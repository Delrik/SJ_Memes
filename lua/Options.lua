SJ = SJ or {}

SJ.Options = {
    DefaultOptions = {
        OnWipe = { enabled = true },
        OnExecuteStage = { enabled = true, threshold = 35 },
        OnKill = { enabled = true },
        OnNinjaPull = { enabled = true },
        OnResurrect = { enabled = true },
        OnBreak = { enabled = true }
    }
}

local plugin = SJ.Options

local function match_options(options)
    local result = plugin.DefaultOptions
    if not options then
        return result
    end
    for key, value in pairs(options) do
        result[key] = value
    end
    return result
end

local plugin_matcher = {
    ["OnWipe"] = SJ.OnWipe,
    ["OnExecuteStage"] = SJ.OnExecuteStage,
    ["OnKill"] = SJ.OnKill,
    ["OnNinjaPull"] = SJ.OnNinjaPull,
    ["OnResurrect"] = SJ.OnResurrect,
    ["OnBreak"] = SJ.OnBreak
}

function plugin:apply_option(key, value)
    local subplugin = plugin_matcher[key]
    if subplugin then
        subplugin:enable(value.enabled)
        if key == "OnExecuteStage" then
            subplugin:set_threshold(value.threshold)
        end
    end
end

function plugin:get_options()
    local result = {}
    result["OnWipe"] = { enabled = SJ.OnWipe:is_enabled() }
    result["OnExecuteStage"] = { enabled = SJ.OnExecuteStage:is_enabled(), threshold = SJ.OnExecuteStage:get_threshold() }
    result["OnKill"] = { enabled = SJ.OnKill:is_enabled() }
    result["OnNinjaPull"] = { enabled = SJ.OnNinjaPull:is_enabled() }
    result["OnResurrect"] = { enabled = SJ.OnResurrect:is_enabled() }
    result["OnBreak"] = { enabled = SJ.OnBreak:is_enabled() }
    return result
end

function plugin:set_options(options)
    options = match_options(options)
    for key, value in pairs(options) do
        plugin:apply_option(key, value)
    end
end
